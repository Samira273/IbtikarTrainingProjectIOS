//
//  HomeScreenModelTest.swift
//  IbtikarProjectTests
//
//  Created by Samira.Marassy on 9/25/19.
//  Copyright © 2019 Samira Marassy. All rights reserved.
//

import XCTest
@testable import IbtikarProject

class HomeScreenModelTest: XCTestCase {
   
    var sut : HomeScreenModel!
    
    override func setUp() {
        sut = HomeScreenModel()
    
        
    }

    override func tearDown() {
        sut = nil
    }

    func testDataFetchedCompletely() {
        
        let promise = expectation(description: "data completed")
        let dataDone : (Bool) -> Void = { onSuccess in
            promise.fulfill()
        }
        sut.loadDataOf(url: "https://api.themoviedb.org/3/person/popular?api_key=6b93b25da5cdb9298216703c40a31832&language=en-US&page=", forPageNO: 1, completion: dataDone)
        wait(for: [promise], timeout: 5)
        XCTAssertEqual(sut.getArraysCount(), 20, "data wasn't fetched")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
