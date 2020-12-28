//
//  BreakingBadTests.swift
//  BreakingBadTests
//
//  Created by emile on 28/12/2020.
//

import XCTest
@testable import BreakingBad

class BreakingBadTests: XCTestCase {

    let items = [Character(image: "String",
                           name: "John",
                           occupation: ["String"],
                           status: "String",
                           nickname: "String",
                           season: [1]),
                 Character(image: "String",
                           name: "Jane",
                           occupation: ["String"],
                           status: "String",
                           nickname: "String",
                           season: [2])]
    
    func testRepository() throws {
        let repository = RemoteRepository()
        repository.originalItems = items
        repository.items = items
        repository.search(query: "Jane")
        XCTAssertEqual(1, repository.items.count)
        repository.clear()
        XCTAssertEqual(2, repository.items.count)
        repository.filter(query: 2)
        XCTAssertEqual(1, repository.items.count)
    }
}
