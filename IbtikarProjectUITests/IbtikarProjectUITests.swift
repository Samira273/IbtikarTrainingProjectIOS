//
//  IbtikarProjectUITests.swift
//  IbtikarProjectUITests
//
//  Created by Lost Star on 9/2/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import XCTest
@testable import IbtikarProject
class IbtikarProjectUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launch()
        
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testTableCellAtIndexExists() {
        
        let  myTable = app.tables["myTable"]
        //        let cell
        XCTAssertTrue(myTable.exists, "Table couldnt be found")
        
        let tableCells = myTable.cells
        if  tableCells.count > 0 {
            //            let count: Int = (tableCells.count - 1)
            
            let promise = expectation(description: "Wait for table cells")
            
            //            for i in stride(from: 0, to: count , by: 1) {
            //                 Grab the first cell and verify that it exists and tap it
            let tableCell = tableCells.element(boundBy: 5)
            
            XCTAssertTrue(tableCell.exists, "The cell is not in place on the table")
            
            XCTAssertTrue(tableCell.images["cellImage"].exists, "image doesn't exist")
            
            XCTAssertTrue(tableCell.staticTexts["cellLabel"].exists, "label doesn't exist")
            //                XCTAssertEqual(tableCell.staticTexts["cellLabel"].label , "Keanu Reeves", "wrong actor name")
            
            // Does this actually take us to the next screen
            
            //            app.navigationBars["myNavBar"].buttons["Back"].tap()
            //            app.navigationBars.buttons.element(boundBy: 0).tap()
            //            app.buttons["back"].tap()
            
            //                tableCell.tap()
            //
            
            //                if i == (count - 1) {
            promise.fulfill()
            //                }
        }
        waitForExpectations(timeout: 20, handler: nil)
    }
    
    func testCellIsHavingCorrectObject(){
        let  myTable = app.tables["myTable"]
        let tableCells = myTable.cells
        let tableCell = tableCells.element(boundBy: 1)
        tableCell.tap()
        XCTAssertEqual(app.staticTexts["mainCellLabel"].label, "Keanu Reeves", "wrong cell navigation")
    }
    
    
    func testGoingToDetailsScreenAndBack(){
        let  myTable = app.tables["myTable"]
        let tableCells = myTable.cells
        let tableCell = tableCells.element(boundBy: 1)
        tableCell.tap()
        XCTAssertTrue(app.collectionViews["detailsView"].exists, "details screen isnt displayed")
        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssertTrue(app.tables["myTable"].exists, "home screen isnt displayed")
    }
}
