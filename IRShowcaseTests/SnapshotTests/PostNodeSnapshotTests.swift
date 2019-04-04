//
//  PostNodeSnapshotTests.swift
//  IRShowcaseTests
//
//  Created by Nuno Salvador on 23/03/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation
import AsyncDisplayKit

@testable import IRShowcase

class PostNodeSnapshotTests: SnapshotTestCase {
    override func setUp() {
        super.setUp()
        self.recordMode = false
    }
    
    // Nodes
    func testPostNodeOneLineSubtitle() {
        let desiredSize = CGSize(width: 325, height: PostCellNode.NDesign.size.height)
        let cellViewModel = PostsListCellViewModel(id: 1, title: "Test title", subtitle: "Subtiteling")
        let node = PostCellNode(viewModel: cellViewModel)
        sizeNodeToFitSize(node, size: desiredSize)
        verifyNode(node)
    }
    
    func testPostNodeTwoLineSubtitle() {
        let desiredSize = CGSize(width: 325, height: PostCellNode.NDesign.size.height)
        let cellViewModel = PostsListCellViewModel(id: 1, title: "Test title", subtitle: "Subtiteling uahsdon uahsdon uahsdon uahsdon uahsdon uahsdon uahsdon uahsdon uahsdon uahsdon uahsdon")
        let node = PostCellNode(viewModel: cellViewModel)
        sizeNodeToFitSize(node, size: desiredSize)
        verifyNode(node)
    }
    
    func testPostNodeNoTitle() {
        let desiredSize = CGSize(width: 325, height: PostCellNode.NDesign.size.height)
        let cellViewModel = PostsListCellViewModel(id: 1, title: "", subtitle: "Subtiteling")
        let node = PostCellNode(viewModel: cellViewModel)
        sizeNodeToFitSize(node, size: desiredSize)
        verifyNode(node)
    }
}
