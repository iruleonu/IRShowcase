//
//  PostsListViewModelTests.swift
//  IRShowcaseTests
//
//  Created by Nuno Salvador on 02/04/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation
import Quick
import Nimble
import SwiftyMocky
import ReactiveSwift
import enum Result.Result
import enum Result.NoError

@testable import IRShowcase

class PostsListViewModelTests: QuickSpec {
    override func spec() {
        describe("PostsListViewModelTests") {
            var subject: PostsListViewModelImpl!
            var routing: PostsListRoutingMock!
            var network: APIServiceMock!
            var persistence: PersistenceLayerMock!
            var connectivity: ConnectivityServiceMock!
            
            beforeEach {
                routing = PostsListRoutingMock()
                network = APIServiceMock()
                persistence = PersistenceLayerMock()
                connectivity = ConnectivityServiceMock()
                let localConfig = DataProviderConfiguration.localOnly
                let remoteConfig = DataProviderConfiguration.remoteOnly
                let localDataProvider: DataProvider<[Post]> = DataProviderBuilder.makeDataProvider(config: localConfig, network: network, persistence: persistence)
                let remoteDataProvider: DataProvider<[Post]> = DataProviderBuilder.makeDataProvider(config: remoteConfig, network: network, persistence: persistence)
                Given(connectivity, .isReachableProperty(getter: MutableProperty<Bool>(true)))
                subject = PostsListViewModelImpl(routing: routing, localDataProvider: localDataProvider, remoteDataProvider: remoteDataProvider, connectivity: connectivity)
            }
            
            afterEach {
                subject = nil
            }
            
            context("fetch stuff dance") {
                it("should get posts after calling fetchStuff on the happy path") {
                    Given(network, .buildUrlRequest(resource: .any, willReturn: Resource.posts.buildUrlRequest(apiBaseUrl: URL(string: "https://fake.com")!)))
                    Given(network, .fetchData(request: .any, willReturn: SignalProducer({ (observer, _) in
                        let posts: [Post] = Factory.arrayReponse(from: "posts", extension: "json")
                        var data: Data? = nil
                        
                        do {
                            let jsonData = try JSONEncoder().encode(posts)
                            data = jsonData
                        } catch { }
                        
                        if let d = data {
                            observer.send(value: (d, URLResponse()))
                        } else {
                            observer.send(error: DataProviderError.parsing(error: DataProviderError.unknown))
                        }
                    })))
                    Given(persistence, .fetchResource(.any, willReturn: SignalProducer<[Post], PersistenceLayerError>({ (observer, _) in
                        observer.send(value: [Post(id: 0, userId: 0, title: "", body: "")])
                    })))
                    
                    waitUntil(action: { (done) in
                        subject.fetchedStuff.observeValues({ (result) in
                            switch result {
                            case .success(let value):
                                expect(value.count) == 100
                            case .failure:
                                fail()
                            }
                            
                            // Verify that we called the method that saves to persistence
                            persistence.verify(PersistenceLayerMock.Verify.persistObjects(Parameter<[Post]>.any, saveCompletion: .any))
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                                // Verify that the fetchStuffAction isnt executing
                                expect(subject.fetchStuffAction.isExecuting.value).to(equal(false))
                                done()
                            }
                        })
                        subject.fetchStuff()
                    })
                }
                
                it("should get posts after calling fetchStuff with an error from empty persistence") {
                    Given(network, .buildUrlRequest(resource: .any, willReturn: Resource.posts.buildUrlRequest(apiBaseUrl: URL(string: "https://fake.com")!)))
                    Given(network, .fetchData(request: .any, willReturn: SignalProducer({ (observer, _) in
                        let posts: [Post] = Factory.arrayReponse(from: "posts", extension: "json")
                        var data: Data? = nil
                        
                        do {
                            let jsonData = try JSONEncoder().encode(posts)
                            data = jsonData
                        } catch { }
                        
                        if let d = data {
                            observer.send(value: (d, URLResponse()))
                        } else {
                            observer.send(error: DataProviderError.parsing(error: DataProviderError.unknown))
                        }
                    })))
                    Given(persistence, .fetchResource(.any, willReturn: SignalProducer<[Post], PersistenceLayerError>({ (observer, _) in
                        observer.send(error: PersistenceLayerError.persistence(error: NSError.error(withMessage: "should get a signal after calling fetchStuff Error")))
                    })))
                    
                    waitUntil(action: { (done) in
                        subject.fetchedStuff.observeValues({ (result) in
                            switch result {
                            case .success(let value):
                                expect(value.count) == 100
                            case .failure:
                                fail()
                            }
                            
                            // Verify that we called the method that saves to persistence
                            persistence.verify(PersistenceLayerMock.Verify.persistObjects(Parameter<[Post]>.any, saveCompletion: .any))
                            
                            // Verify that the fetchStuffAction isnt executing
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                                expect(subject.fetchStuffAction.isExecuting.value).to(equal(false))
                                done()
                            }
                        })
                        subject.fetchStuff()
                    })
                }
                
                it("should get posts after calling fetchStuff with an error from the network") {
                    Given(network, .buildUrlRequest(resource: .any, willReturn: Resource.posts.buildUrlRequest(apiBaseUrl: URL(string: "https://fake.com")!)))
                    Given(network, .fetchData(request: .any, willReturn: SignalProducer({ (observer, _) in
                        observer.send(error: DataProviderError.parsing(error: DataProviderError.unknown))
                    })))
                    Given(persistence, .fetchResource(.any, willReturn: SignalProducer<[Post], PersistenceLayerError>({ (observer, _) in
                        observer.send(value: [Post(id: 0, userId: 0, title: "", body: "")])
                    })))
                    
                    waitUntil(action: { (done) in
                        subject.fetchedStuff.observeValues({ (result) in
                            switch result {
                            case .success(let value):
                                expect(value.count) == 1
                            case .failure:
                                fail()
                            }
                            
                            // Verify that we DIDNT called the method that saves to persistence
                            persistence.verify(PersistenceLayerMock.Verify.persistObjects(Parameter<[Post]>.any, saveCompletion: .any), count: 0)
                            
                            // Verify that the fetchStuffAction isnt executing
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                                expect(subject.fetchStuffAction.isExecuting.value).to(equal(false))
                                done()
                            }
                        })
                        subject.fetchStuff()
                    })
                }
                
                it("should get a signal (failure) after calling fetchStuff with an error on both the persistence and network layer") {
                    Given(network, .buildUrlRequest(resource: .any, willReturn: Resource.posts.buildUrlRequest(apiBaseUrl: URL(string: "https://fake.com")!)))
                    Given(network, .fetchData(request: .any, willReturn: SignalProducer({ (observer, _) in
                        observer.send(error: DataProviderError.parsing(error: DataProviderError.unknown))
                    })))
                    Given(persistence, .fetchResource(.any, willReturn: SignalProducer<[Post], PersistenceLayerError>({ (observer, _) in
                        observer.send(error: PersistenceLayerError.persistence(error: NSError.error(withMessage: "should get a signal after calling fetchStuff Error")))
                    })))
                    
                    waitUntil(action: { (done) in
                        subject.fetchedStuff.observeValues({ (result) in
                            switch result {
                            case .success:
                                fail()
                            case .failure:
                                break
                            }
                            
                            // Verify that we DIDNT called the method that saves to persistence
                            persistence.verify(PersistenceLayerMock.Verify.persistObjects(Parameter<[Post]>.any, saveCompletion: .any), count: 0)
                            
                            // Verify that the fetchStuffAction isnt executing
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                                expect(subject.fetchStuffAction.isExecuting.value).to(equal(false))
                                done()
                            }
                        })
                        subject.fetchStuff()
                    })
                }
            }
            
            context("tapped on a post") {
                it("should open next screen") {
                    waitUntil(action: { (done) in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            routing.verify(PostsListRoutingMock.Verify.showPost(id: .value(1), action: .any))
                            done()
                        }
                        subject.userDidTapCellWithPostId(1)
                    })
                }
            }
            
            context("pulled down to refresh") {
                it("should call fetch stuff") {
                    Given(network, .buildUrlRequest(resource: .any, willReturn: Resource.posts.buildUrlRequest(apiBaseUrl: URL(string: "https://fake.com")!)))
                    Given(network, .fetchData(request: .any, willReturn: SignalProducer({ (observer, _) in
                        observer.send(error: DataProviderError.parsing(error: DataProviderError.unknown))
                    })))
                    Given(persistence, .fetchResource(.any, willReturn: SignalProducer<[Post], PersistenceLayerError>({ (observer, _) in
                        observer.send(error: PersistenceLayerError.persistence(error: NSError.error(withMessage: "should get a signal after calling fetchStuff Error")))
                    })))
                    
                    waitUntil(action: { (done) in
                        subject.fetchedStuff.observeValues({ (result) in
                            done()
                        })
                        subject.triggerRefreshControl()
                    })
                }
            }
        }
    }
}
