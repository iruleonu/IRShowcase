//
//  ResourceTests.swift
//  IRShowcaseTests
//
//  Created by Nuno Salvador on 02/04/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation
import XCTest

@testable import IRShowcase

class ResourceTests: XCTestCase {
    
    func testEqualityForSameResource() {
        let resource1 = Resource.posts
        let resource2 = Resource.posts
        XCTAssertEqual(resource1, resource2)
        
        let resource3 = Resource.post(id: "1")
        let resource4 = Resource.post(id: "1")
        XCTAssertEqual(resource3, resource4)
    }
    
    func testInequalityForDifferentResource() {
        let resource1 = Resource.posts
        let resource2 = Resource.post(id: "1")
        XCTAssertNotEqual(resource1, resource2)
        XCTAssertNotEqual(resource2, resource1)
    }
}
