//
//  PostsListCoordinator.swift
//  IRShowcase
//
//  Created by Nuno Salvador on 20/03/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation
import UIKit

//sourcery: AutoMockable
protocol PostsListRouting {
    func showPost(id: Int, action: @escaping (PostListAction) -> Void)
}

final class PostsListCoordinator: PostsListRouting {
    private weak var navigation: UINavigationController?
    private let builders: PostsListChildBuilders
    private let network: DataProviderNetworkProtocol
    private let persistence: DataProviderPersistenceProtocol
    private let connectivity: ConnectivityService
    
    init(navigation nav: UINavigationController?, builders b: PostsListChildBuilders, network n: DataProviderNetworkProtocol, persistence p: DataProviderPersistenceProtocol, connectivity c: ConnectivityService) {
        navigation = nav
        builders = b
        network = n
        persistence = p
        connectivity = c
    }
    
    func showPost(id: Int, action: @escaping (PostListAction) -> Void) {
        let vc = builders.makePostDetails(navigation: navigation, postId: id, network: network, persistence: persistence, connectivity: connectivity, action: action)
        navigation?.pushViewController(vc, animated: true)
    }
}
