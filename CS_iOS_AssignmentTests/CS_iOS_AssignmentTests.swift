//
//  CS_iOS_AssignmentTests.swift
//  CS_iOS_AssignmentTests
//
//  Created by steve on 1/3/21.
//

import XCTest
import SwiftUI
@testable import CS_iOS_Assignment

class CSiOSAssignmentTests: XCTestCase {

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
    
    func testDownloadWebData() {
        let expectation = XCTestExpectation(description: "Check if API connects and publishes in viewModel")
        _ = MoviesViewModel().$popularMovies.sink(receiveCompletion: { print ($0)
        },
        receiveValue: {
            print ($0)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 10)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
