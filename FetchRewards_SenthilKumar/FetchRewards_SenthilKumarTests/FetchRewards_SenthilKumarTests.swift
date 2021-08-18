//
//  FetchRewards_SenthilKumarTests.swift
//  FetchRewards_SenthilKumarTests
//
//  Created by Senthil Kumar on 16/08/21.
//

import XCTest
@testable import FetchRewards_SenthilKumar

class FetchRewards_SenthilKumarTests: XCTestCase {

    let categoryViewModel = CategoriesViewModel(webProvider: APIService())
    let subCategoryViewModel = SubCategoriesViewModel(webProvider: APIService())
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testValidCategoryURL() throws {
        
        let expectation = XCTestExpectation(description: "PerformFetchRequest")
        categoryViewModel.apiService.fetchCategories(){ (result) in
            XCTAssertNil(Result<[Categories], NetworkError>.failure)
        }
        wait(for: [expectation], timeout: 3)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
