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
    
    func waitForElementToAppear(_ element: XCUIElement) -> Bool {
        let expectation = XCTKVOExpectation(keyPath: "exists", object: element,
                                            expectedValue: true)
        
        let result = XCTWaiter().wait(for: [expectation], timeout: 5)
        return result == .completed
    }

    func testTableCellsExist() {
        
       let  myTable = app.tables["myTable"]
//        let cell
         XCTAssertTrue(myTable.exists, "Table couldnt be found")
       let tableCells = myTable.cells
        if  tableCells.count > 0 {
            let count: Int = (tableCells.count - 1)
            
            let promise = expectation(description: "Wait for table cells")
            
//            for i in stride(from: 0, to: count , by: 1) {
                // Grab the first cell and verify that it exists and tap it
                let tableCell = tableCells.element(boundBy: 1)
           
            
//                if waitForElementToAppear(tableCell){
                XCTAssertTrue(tableCell.exists, "The cell is not in place on the table")
//                tableCell.textFields[""]
                
                XCTAssertTrue(tableCell.images["cellImage"].exists, "image doesn't exist")
                
                XCTAssertTrue(tableCell.staticTexts["cellLabel"].exists, "label doesn't exist")
            XCTAssertEqual(tableCell.staticTexts["cellLabel"].label , "Keanu Reeves", "wrong actor name")
            
            
//                XCTAssertEqual(tableCell.staticTexts.element(boundBy: 1).label, "Dwayne Johnson", "wrong actor name")
//            tableCell.staticTexts["cellLabel"].accessibilityLabel?.
                // Does this actually take us to the next screen
//                tableCell.tap()
               
                
                
//                if i == (count - 1) {
                    promise.fulfill()
//                }

//        }
            waitForExpectations(timeout: 20, handler: nil)
            XCTAssertTrue(true, "Finished validating the table cells")
        }
}
}
