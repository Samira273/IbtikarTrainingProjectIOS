//
//  IbtikarProjectTests.swift
//  IbtikarProjectTests
//
//  Created by Lost Star on 9/2/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import XCTest
@testable import IbtikarProject

class IbtikarProjectTests: XCTestCase  {

    var sut : HomeScreenPresenter!
    var homeViewTest : HomeViewTest!
    var homeModelTest : HomeModelTest!
    
    override func setUp() {
        super.setUp()
        sut = HomeScreenPresenter(viewProtocol: homeViewTest, modelProtocol: homeModelTest)
        let testBundle = Bundle(for: type(of: self))
        let path = testBundle.path(forResource: "actorData", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        
        let url =
            URL(string: "ttps://api.themoviedb.org/3/person/popular?api_key=6b93b25da5cdb9298216703c40a31832&language=en-US&page=1")
        let urlResponse = HTTPURLResponse(
            url: url!,
            statusCode: 200,
            httpVersion: nil,
            headerFields: nil)
        
        let sessionMock = URLSessionMock(data: data, response: urlResponse, error: nil)
    }

    override func tearDown() {
        sut = nil
        homeViewTest = nil
        homeModelTest = nil
        super.tearDown()
    }

    func testHomeScreenPresenter(){
        
    }
    
    func testHomeScreenPresenterRefresh(){
        
    }
    
    func testHomeScreenPresenterClearingData(){
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    class HomeViewTest : HomeScreenViewProtocol{
        func reloadHomeScreen() {
            
        }
        
        func setActivity(status: Bool) {
            
        }
        
        func activityAction(action: String) {
            
        }
        
        
    }
    
    class HomeModelTest: HomeScreenModelProtocol {
        
        var arrayOfPersons = [Person]()
        
        func loadDataOf(url urlString: String, forPageNO pageNumber: Int, completion: @escaping (Bool) -> Void) {
            
        }
        
        func clearData() {
            arrayOfPersons = []
        }
        
        func getPersonAtIndex(index: Int) -> Person {
            
        }
        
        func getApiTottalPages() -> Int? {
            
        }
        
        func getArraysCount() -> Int {
            
        }
        
        func imageFromUrl(urlString: String, completion: @escaping (Data, String) -> Void) {
            
        }
        
    }

}
