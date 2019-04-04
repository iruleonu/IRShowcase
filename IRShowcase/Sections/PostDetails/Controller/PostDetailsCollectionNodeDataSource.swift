//
//  PostDetailsCollectionNodeDataSource.swift
//  IRShowcase
//
//  Created by Nuno Salvador on 24/03/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation
import AsyncDisplayKit
import ReactiveSwift

enum PostDetailsSupplementaryElementOfKinds {
    case header
}

protocol PostDetailsCollectionNodeDataSourceHeaderDetails {
    var posterName: String { get }
    var posterUsername: String { get }
    var posterEmail: String { get }
    var refreshSupplementaryElementOfKind: MutableProperty<PostDetailsSupplementaryElementOfKinds> { get }
}

protocol PostDetailsCollectionNodeDataSourceProtocol: PostDetailsCollectionNodeDataSourceHeaderDetails {
    func numberOfSections(dataSource: PostDetailsViewModelState.VMSharedState.DataSource) -> Int
    func numberOfRowsInSection(_ section: Int, dataSource: PostDetailsViewModelState.VMSharedState.DataSource) -> Int
}

class PostDetailsCollectionNodeDataSource: NSObject, ASCollectionDataSource {
    let dataSource: PostDetailsCollectionNodeDataSourceProtocol
    var cachedState: PostDetailsViewModelState.VMSharedState.DataSource
    let viewModel: PostDetailsViewModel
    
    required init(viewModel vm: PostDetailsViewModel) {
        dataSource = vm
        cachedState = .empty
        viewModel = vm
        super.init()
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return dataSource.numberOfRowsInSection(section, dataSource: cachedState)
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        guard dataSource.numberOfRowsInSection(indexPath.section, dataSource: cachedState) > indexPath.row else { return { ASCellNode() } }

        let postVM = cachedState.rows[indexPath.row]
        let cellNodeBlock = { () -> ASCellNode in
            return PostDetailsCellNode(viewModel: postVM)
        }
        return cellNodeBlock
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> ASCellNodeBlock {
        let vm = viewModel
        let headerNodeBlock = { () -> ASCellNode in
            return PostDetailsHeaderNode(viewModel: vm)
        }
        return headerNodeBlock
    }
}
