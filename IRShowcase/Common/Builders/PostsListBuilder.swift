//
//  PostsListBuilder.swift
//  IRShowcase
//
//  Created by Nuno Salvador on 20/03/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation
import UIKit
import enum Result.Result

// Actions available from childs built from PostsListChildBuilders
enum PostListAction {
    case deletePost
}

// swiftlint:disable function_parameter_count
protocol PostsListChildBuilders {
    func makePostDetails(navigation: UINavigationController?, postId: Int, network: DataProviderNetworkProtocol, persistence: DataProviderPersistenceProtocol, connectivity: ConnectivityService, action: @escaping (PostListAction) -> Void) -> UIViewController
}
// swiftlint:enable function_parameter_count

struct PostsListBuilder: PostsListChildBuilders {
    func make(navigation: UINavigationController, network: DataProviderNetworkProtocol, persistence: DataProviderPersistenceProtocol, connectivity: ConnectivityService) -> UIViewController {
        let coordinator = PostsListCoordinator(navigation: navigation, builders: self, network: network, persistence: persistence, connectivity: connectivity)
        let localConfig = DataProviderConfiguration.localOnly
        let remoteConfig = DataProviderConfiguration.remoteOnly
        let localDataProvider: DataProvider<[Post]> = DataProviderBuilder.makeDataProvider(config: localConfig, network: network, persistence: persistence)
        let remoteDataProvider: DataProvider<[Post]> = DataProviderBuilder.makeDataProvider(config: remoteConfig, network: network, persistence: persistence)
        let viewModel = PostsListViewModelImpl(routing: coordinator, localDataProvider: localDataProvider, remoteDataProvider: remoteDataProvider, connectivity: connectivity)
        let viewController = PostsListViewController(viewModel: viewModel)
        return viewController
    }
    
    // swiftlint:disable function_parameter_count
    func makePostDetails(navigation: UINavigationController?, postId: Int, network: DataProviderNetworkProtocol, persistence: DataProviderPersistenceProtocol, connectivity: ConnectivityService, action: @escaping (PostListAction) -> Void) -> UIViewController {
        let vc = PostDetailsBuilder().make(navigation: navigation, postId: postId, network: network, persistence: persistence, connectivity: connectivity, action: action)
        return vc
    }
    // swiftlint:enable function_parameter_count
}
