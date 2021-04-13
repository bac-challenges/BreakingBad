//
//  Tests.swift
//  Tests
//
//  Created by emile on 04/04/2021.
//

@testable import BreakingBad
import XCTest
import Combine

final class BreakingBadTests: XCTestCase, ListViewModelInjected, ListModelInjected, ServiceInjected, JSONDecoderInjected {

    private var disposables: Set<AnyCancellable> = []
    
    override func setUpWithError() throws {
        InjectionMap.service = ServiceMock()
        InjectionMap.listModel = ListModelMock()
    }
    
    override func tearDownWithError() throws {
        disposables = []
    }
    
    func testService() throws {
        service.get(EndPoint.mock)
            .sink { error in
                print(error)
            } receiveValue: { data in
                XCTAssertNotNil(data)
            }
            .store(in: &disposables)
    }
    
    func testModel() throws {
        listModel.get()
            .replaceError(with: [])
            .eraseToAnyPublisher()
            .sink(receiveValue: { items in
                XCTAssertNotNil(items)
                XCTAssertEqual(items.count, 1)
                
                guard  let item = items.first else {
                    XCTFail()
                    return
                }
                
                XCTAssertEqual(item.image, "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg")
                XCTAssertEqual(item.name, "Walter White")
                XCTAssertEqual(item.occupation, ["High School Chemistry Teacher","Meth King Pin"])
                XCTAssertEqual(item.status, "Presumed dead")
                XCTAssertEqual(item.nickname, "Heisenberg")
                XCTAssertEqual(item.season, [1,2,3,4,5])
            })
            .store(in: &disposables)
    }
    
    func testViewModel() throws {
        listViewModel.get()
        listViewModel.$items
            .sink { items in
                XCTAssertEqual(items.count, 1)
                
                guard  let item = items.first else {
                    XCTFail()
                    return
                }
                
                XCTAssertEqual(item.image, "https://images.amcnetworks.com/amc.com/wp-content/uploads/2015/04/cast_bb_700x1000_walter-white-lg.jpg")
                XCTAssertEqual(item.name, "Walter White")
                XCTAssertEqual(item.occupation, ["High School Chemistry Teacher","Meth King Pin"])
                XCTAssertEqual(item.status, "Presumed dead")
                XCTAssertEqual(item.nickname, "Heisenberg")
                XCTAssertEqual(item.season, [1,2,3,4,5])
            }
            .store(in: &disposables)
    }
}
