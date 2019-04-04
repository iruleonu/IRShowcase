//
//  PostsListCollectionNodeDataSource.swift
//  IRShowcase
//
//  Created by Nuno Salvador on 23/03/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation
import AsyncDisplayKit
import ReactiveSwift
import Result

protocol PostsListCollectionNodeDataSourceProtocol {
    func numberOfSections(dataSource: PostsListViewModelState.VMSharedState.DataSource) -> Int
    func numberOfRowsInSection(_ section: Int, dataSource: PostsListViewModelState.VMSharedState.DataSource) -> Int
}

class PostsListCollectionNodeDataSource: NSObject, ASCollectionDataSource {
    let dataSource: PostsListCollectionNodeDataSourceProtocol
    var cachedState: PostsListViewModelState.VMSharedState.DataSource
    
    required init(viewModel vm: PostsListCollectionNodeDataSourceProtocol) {
        dataSource = vm
        cachedState = .empty
        super.init()
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return dataSource.numberOfRowsInSection(section, dataSource: cachedState)
    }

    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {
        guard dataSource.numberOfRowsInSection(indexPath.section, dataSource: cachedState) > indexPath.row else { return { ASCellNode() } }
        
        let postVM = cachedState.rows[indexPath.row]
        let cellNodeBlock = { () -> ASCellNode in
            return PostCellNode(viewModel: postVM)
        }
        return cellNodeBlock
    }
}
