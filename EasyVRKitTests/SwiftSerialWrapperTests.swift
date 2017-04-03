//
//  SwiftSerialWrapperTests.swift
//  EasyVRKit
//
//  Created by Martin Bradford Gago on 07/03/2017.
//  Copyright © 2017 Martin Bradford Gago. All rights reserved.
//

import XCTest
@testable import EasyVRKit;

class SwiftSerialWrapperTests: XCTestCase {
    
    var port = "/dev/cu.usbserial-fd1";
    var baudRate = 9600;
    
    var testWrapper: SwiftSerialWrapper!
    
    override func setUp() {
        super.setUp()
        
        testWrapper = SwiftSerialWrapper(port: port,baudRate: baudRate);
    }
    
    override func tearDown() {
        testWrapper.Close();
        
        super.tearDown()
    }
    
    func testRead() {
        
        testWrapper.Write(request: "x");
        let response = testWrapper.Read();
        XCTAssert(response == "x","didn't work - response: \(response)");
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
