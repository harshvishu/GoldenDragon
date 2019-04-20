//
//  GoldenDragonTests.swift
//  GoldenDragonTests
//
//  Created by harsh vishwakarma on 20/04/19.
//  Copyright © 2019 Harsh Vishwakarma. All rights reserved.
//

import XCTest
@testable import GoldenDragon

class GoldenDragonTests: XCTestCase {

    private var router: Router<Api>!
    
    override func setUp() {
        router = Router<Api>()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        router = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

extension GoldenDragonTests {
    func testApi() {
        
        let apiExpectation = expectation(description: "Successful Execution!")
        
        let expect: Future<SearchResult> = router.request(Api.search(query: "swift"))
        expect.observe { result in
            switch result {
            case .success(let searchData):
                print("\(searchData.totalCount) repositories found")
                apiExpectation.fulfill()
            case .failure(let error):
                XCTFail("Error: \(error.localizedDescription)")
            }
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    
    struct SearchResult: Codable {
        let totalCount: Int
        let items: [Item]
        
        enum CodingKeys: String, CodingKey {
            case totalCount = "total_count"
            case items
        }
    }
    
    struct Item: Codable {
        let id: Int
        let htmlURL: String
        let description: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case htmlURL = "html_url"
            case description
        }
    }
    
}
