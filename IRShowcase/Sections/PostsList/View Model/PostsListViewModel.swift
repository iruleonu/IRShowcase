//
//  PostsListViewModel.swift
//  IRShowcase
//
//  Created by Nuno Salvador on 20/03/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation
import ReactiveSwift
import Connectivity

enum PostsListViewModelError: Error {
    case unknown
    case noData
    case noConnection
    
    var errorDescription: String {
        switch self {
        case .noData:
            return "Couldnt fetch any data"
        default:
            return "Unknown error"
        }
    }
}

protocol PostsListViewModelInputs {
    func viewDidLoad()
    func fetchStuff()
    func userDidTapCellWithPostId(_ postId: Int)
    func triggerRefreshControl()
}

protocol PostsListViewModelOutputs {
    var fetchedStuff: Signal<Result<[Post], PostsListViewModelError>, Never> { get }
    var dataSourceChanges: Signal<PostsListViewModelState.VMSharedState.DataSource, Never> { get }
}

protocol PostsListViewModel: PostsListCollectionNodeDataSourceProtocol {
    var inputs: PostsListViewModelInputs { get }
    var outputs: PostsListViewModelOutputs { get }
}

final class PostsListViewModelImpl: PostsListViewModel, PostsListViewModelInputs, PostsListViewModelOutputs {
    private let routing: PostsListRouting
    private let localDataProvider: DataProvider<[Post]>
    private let remoteDataProvider: DataProvider<[Post]>
    private let vmState: Atomic<(PostsListViewModelState.VMState, PostsListViewModelState.VMSharedState)>
    private let connectivity: ConnectivityService
    private var disposables = CompositeDisposable()
    
    var inputs: PostsListViewModelInputs { return self }
    private let viewDidLoadProperty: MutableProperty<Void>
    private let fetchStuffProperty: MutableProperty<Resource>
    
    var outputs: PostsListViewModelOutputs { return self }
    var fetchedStuff: Signal<Result<[Post], PostsListViewModelError>, Never>
    private var fetchedStuffObserver: Signal<Result<[Post], PostsListViewModelError>, Never>.Observer
    var dataSourceChanges: Signal<PostsListViewModelState.VMSharedState.DataSource, Never>
    private let dataSourceChangesObserver: Signal<PostsListViewModelState.VMSharedState.DataSource, Never>.Observer

    let fetchStuffAction: Action<Resource, [([Post], DataProviderSource)], DataProviderError>
    
    deinit {
        disposables.dispose()
    }
    
    init(routing r: PostsListRouting, localDataProvider ldp: DataProvider<[Post]>, remoteDataProvider rdp: DataProvider<[Post]>, connectivity c: ConnectivityService) {
        routing = r
        localDataProvider = ldp
        remoteDataProvider = rdp
        vmState = Atomic((PostsListViewModelState.VMState.empty, PostsListViewModelState.VMSharedState.empty))
        connectivity = c
        
        viewDidLoadProperty = MutableProperty(())
        fetchStuffProperty = MutableProperty(Resource.unknown)
        
        (fetchedStuff, fetchedStuffObserver) = Signal<Result<[Post], PostsListViewModelError>, Never>.pipe()
        (dataSourceChanges, dataSourceChangesObserver) = Signal<PostsListViewModelState.VMSharedState.DataSource, Never>.pipe()
        
        fetchStuffAction = Action { PostsListViewModelImpl.fetchStuffHandler($0, localDataProvider: ldp, remoteDataProvider: rdp) }
        
        setupBindings()
    }
    
    private func setupBindings() {
        disposables += connectivity.isReachableProperty.signal.skipRepeats().observeValues({ [weak self] (connected) in
            guard connected else { return }
            self?.fetchStuff()
        })
        disposables += viewDidLoadProperty.signal.observeValues { [weak self] _ in
            guard let strongSelf = self else { return }
            strongSelf.disposables += strongSelf.connectivity.performSingleConnectivityCheck().start()
            strongSelf.fetchStuff()
        }
        disposables += fetchStuffProperty.signal.observeValues { [weak self] (resource) in
            guard let strongSelf = self else { return }
            guard !strongSelf.fetchStuffAction.isExecuting.value else { return }
            strongSelf.fetchStuffAction.apply(resource).start()
        }
        disposables += fetchStuffAction.values.observeValues { [weak self] value in
            self?.postsDPHandler(result: Result.success(value))
        }
        disposables += fetchStuffAction.errors.observeValues({ [weak self] (error) in
            self?.postsDPHandler(result: Result.failure(error))
        })
    }
    
    func viewDidLoad() {
        viewDidLoadProperty.value = ()
    }
    
    func fetchStuff() {
        fetchStuffProperty.value = .posts
    }
    
    func userDidTapCellWithPostId(_ postId: Int) {
        routing.showPost(id: postId) { (action) in
            switch action {
            case .deletePost:
                break
            }
        }
    }
    
    func triggerRefreshControl() {
        fetchStuff()
    }
    
    private static func fetchStuffHandler(_ resource: Resource, localDataProvider ldp: DataProvider<[Post]>, remoteDataProvider rdp: DataProvider<[Post]>) -> SignalProducer<[([Post], DataProviderSource)], DataProviderError> {
        return SignalProducer({ (observer, _) in
            let localFetch = ldp.fetchStuff(resource: resource).flatMapError({ _ -> SignalProducer<([Post], DataProviderSource), DataProviderError> in
                return SignalProducer({ (observer, _) in
                    observer.send(value: ([], .local))
                })
            })
            let remoteFetch = rdp.fetchStuff(resource: resource).flatMapError({ _ -> SignalProducer<([Post], DataProviderSource), DataProviderError> in
                return SignalProducer({ (observer, _) in
                    observer.send(value: ([], .remote))
                })
            })
            
            localFetch.combineLatest(with: remoteFetch).startWithResult({ (result) in
                switch result {
                case .success(let localValue, let remoteValue):
                    guard localValue.0.count > 0 || remoteValue.0.count > 0 else {
                        let error = NSError.error(withMessage: "No data")
                        observer.send(error: DataProviderError.requestError(error: error))
                        return
                    }
                    
                    observer.send(value: [localValue, remoteValue])
                    observer.sendCompleted()
                case .failure(let error):
                    observer.send(error: error)
                }
            })
        })
    }
    
    private func postsDPHandler(result: Result<[([Post], DataProviderSource)], DataProviderError>) {
        switch result {
        case .success(let value):
            disposables += persistRemotePosts(value.filter({ $0.1 == .remote }).compactMap({ $0.0 }).flatMap({ $0 }))
            
            let posts = mergeLocalAndRemotePosts(value)
            
            vmState.modify({ vmState in
                var sharedState = vmState.1
                
                let sharedStateAction = PostsListViewModelState.SharedStateAction.replacePosts(posts)
                sharedState = PostsListViewModelState.handleSharedStateAction(sharedStateAction, sharedState: sharedState)
                
                vmState.1 = sharedState
            })
            
            fetchedStuffObserver.send(value: Result.success(posts))
            dataSourceChangesObserver.send(value: vmState.value.1.dataSource)
        case .failure(let error):
            print(error)
            fetchedStuffObserver.send(value: Result.failure(PostsListViewModelError.noData))
        }
    }
    
    private func mergeLocalAndRemotePosts(_ posts: [([Post], DataProviderSource)]) -> [Post] {
        // Simply give preference to the remote posts
        let nonLocal = posts.first(where: { $0.1 == .remote })?.0
        if let nl = nonLocal, nl.count > 0 {
            return nl
        }
        
        return posts.compactMap({ $0.0 }).flatMap({ $0 })
    }
    
    private func persistRemotePosts(_ posts: [Post]) -> Disposable? {
        guard posts.count > 0 else { return nil }
        return localDataProvider.saveToPersistence(posts).start()
    }
}

// MARK: PostsListCollectionNodeDataSourceProtocol
extension PostsListViewModelImpl {
    func numberOfSections(dataSource: PostsListViewModelState.VMSharedState.DataSource) -> Int {
        return 1
    }

    func numberOfRowsInSection(_ section: Int, dataSource: PostsListViewModelState.VMSharedState.DataSource) -> Int {
        return dataSource.rows.count
    }
}
