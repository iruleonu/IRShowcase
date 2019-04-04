//
//  PostDetailsCoordinator.swift
//  IRShowcase
//
//  Created by Nuno Salvador on 20/03/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation

import UIKit

//sourcery: AutoMockable
protocol PostDetailsRouting: class {
    // Empty
}

final class PostDetailsCoordinator: PostDetailsRouting {
    private weak var navigation: UINavigationController?
    private let builders: PostDetailsChildBuilders
    
    init(navigation nav: UINavigationController?, builders b: PostDetailsChildBuilders) {
        navigation = nav
        builders = b
    }
}
