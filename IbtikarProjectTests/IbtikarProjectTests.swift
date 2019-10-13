////
////  IbtikarProjectTests.swift
////  IbtikarProjectTests
////
////  Created by Lost Star on 9/2/19.
////  Copyright © 2019 esraa mohamed. All rights reserved.
////
//
//import XCTest
//@testable import IbtikarProject
//
//class IbtikarProjectTests: XCTestCase  {
//
//    var sut : HomeScreenPresenter!
//    var homeViewTest : HomeViewTest!
//    var homeModelTest : HomeModelTest!
//
//    override func setUp() {
//        super.setUp()
//        homeViewTest = HomeViewTest()
//        homeModelTest = HomeModelTest()
//        sut = HomeScreenPresenter(viewProtocol: homeViewTest, modelProtocol: homeModelTest)
//
//    }
//
//    override func tearDown() {
//        sut = nil
//        homeViewTest = nil
//        homeModelTest = nil
//        super.tearDown()
//    }
//
//    func testHomeScreenPresenterLoadingMore(){
//        let promise = expectation(description: "data completed")
//        let dataDone : (Bool) -> Void = { onSuccess in
//            promise.fulfill()
//        }
//        homeModelTest.loadDataOf(url: "", forPageNO: 0, completion: dataDone)
//        wait(for: [promise], timeout: 5)
//        sut.loadMoreData()
//        XCTAssertEqual(homeModelTest.getArraysCount() , 10, "loading more failed")
//
//    }
//
//    func testHomeScreenPresenterRefresh(){
//
//        let promise = expectation(description: "data completed")
//        let dataDone : (Bool) -> Void = { onSuccess in
//            promise.fulfill()
//        }
//        homeModelTest.loadDataOf(url: "", forPageNO: 0, completion: dataDone)
//        wait(for: [promise], timeout: 5)
//        self.sut?.refreshSelected()
//        XCTAssertEqual(homeModelTest.getArraysCount(), 5, "refresh failed")
//
//
//    }
//
//    func testHomeScreenPresenterItemSelected(){
//        let promise = expectation(description: "data completed")
//        let dataDone : (Bool) -> Void = { onSuccess in
//            promise.fulfill()
//        }
//        homeModelTest.loadDataOf(url: "", forPageNO: 0, completion: dataDone)
//        wait(for: [promise], timeout: 5)
//
//        let detailsModelTest = sut.itemSelectedAtIndex(ind: 3)
//        XCTAssertEqual(detailsModelTest.per.name, "Saori Hara", "wrong actor")
//    }
//
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//
//    class HomeViewTest : HomeScreenViewProtocol{
//        func reloadHomeScreen() {
//
//        }
//
//        func setActivity(status: Bool) {
//
//        }
//
//        func activityAction(action: String) {
//
//        }
//
//
//    }
//
//    class HomeModelTest: HomeScreenModelProtocol {
//
//        var arrayOfPersons = [Person]()
//        var apiTotalPages : Int?
//
//        func loadDataOf(url urlString: String, forPageNO pageNumber: Int, completion: @escaping (Bool) -> Void) {
//            let testBundle = Bundle(for: type(of: self))
//            let path = testBundle.path(forResource: "actorData", ofType: "json")
//            let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
//            let jsonObject = try? JSONSerialization.jsonObject(with: data!)
//            let dictionary = jsonObject as? NSDictionary
//
//                if pageNumber==1{
//                    self.arrayOfPersons.removeAll()
//                }
//                if let results = dictionary?["results"] as? [NSDictionary]{
//                    self.apiTotalPages = dictionary?["total_pages"] as? Int
//                    for result in results{
//                        let person = Person()
//                        person.id = result["id"] as? Int
//                        person.name = result["name"] as? String
//                        person.popularity = result["popularity"] as? Double
//                        person.path = result["profile_path"] as? String
//                        self.arrayOfPersons.append(person)
//                    }
//                    print("\(self.arrayOfPersons.count)")
//                    completion(true)
//                }
//
//        }
//
//
//        func clearData() {
//            arrayOfPersons = []
//            XCTAssertEqual(arrayOfPersons.count ,0,  "data is still there")
//
//        }
//
//        func getPersonAtIndex(index: Int) -> Actor {
//            return arrayOfPersons[index]
//        }
//
//        func getApiTottalPages() -> Int? {
//            return apiTotalPages
//        }
//
//        func getArraysCount() -> Int {
//            return arrayOfPersons.count
//        }
//
//        func imageFromUrl(urlString: String, completion: @escaping (Data, String) -> Void) {
//
//        }
//        
//    }
//
//}
