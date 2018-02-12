//
//  PXHelpTesting.swift
//  PaxusAppTests
//
//  Created by Jithin on 12/2/18.
//  Copyright © 2018 Jithinpala. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import PaxusApp

class PXHelpTesting: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLocalizedString() {
        func testLocalizedStringConversion() {
            let resultString = "Alert.people.list.empty".localized()
            XCTAssert(resultString == "Oops.. No data to display.", "String localizing is not working")
        }
    }
    
    func testCapitalizingFirstLetter() {
        let resultString = "jithin balan".capitalizingFirstLetter()
        XCTAssert(resultString == "Jithin balan", "Init cap not working")
    }
    
    func testPeopleFetchRequest() {
        let URLpath = NetworkingAPI.apiBaseURL()
        let expectationComment = expectation(description: "GET data from \(URLpath)")
        WebserviceServerManager.sharedServerManager.sendRequestToServer(apiServiceFullURL: URLpath, parameters: nil, apiRequestType: .get, success: { (resultJSON) in
            //XCTAssert(resultJSON is JSON, "Confirm result is object of JSON")
            var fetchedResults = [ActorsModel]()
            for (_,subJson):(String, JSON) in resultJSON["actors"] {
                fetchedResults.append(ActorsModel(resultArray: subJson))
            }            
            XCTAssertEqual(fetchedResults.count, 6, "Checking people count in model")
            expectationComment.fulfill()
        }) { (ApiError) in
            print("failure")
            XCTFail()
        }
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
