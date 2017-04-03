//
//  EasyVRKitTests.swift
//  EasyVRKitTests
//
//  Created by Martin Bradford Gago on 22/02/2017.
//  Copyright © 2017 Martin Bradford Gago. All rights reserved.
//

import XCTest
@testable import EasyVRKit

class EasyVRKitTests: XCTestCase {
    
    var port = "/dev/cu.usbserial-fd1";
    var baudRate = 9600;
    
    var tempVr: EasyVRLibrary!
    
    override func setUp() {
        super.setUp()
        
        tempVr = EasyVRLibrary(portName: port, baudRate: 9600);
    }
    
    override func tearDown() {
        
        tempVr.CloseConnection();
        
        super.tearDown()
    }
    
    func testAddCommand_GroupOutOfRange_ThrowsException() {
        
        //Act
        XCTAssertThrowsError(try tempVr.AddCommand(group: 17, index: 12))
    }
    
    
    func  testAddCommand_IndexOutOfRange_ThrowsException() {
        //Act
        XCTAssertThrowsError(try tempVr.AddCommand(group: 12, index: 45))
    }
    
    
    func  testAddCommand_Success() {
        tempVr.ResetAll();
        
        //Act
        let response = try! tempVr.AddCommand(group: 0, index: 0);
        //Assert
        XCTAssertTrue(response);
    }
    
    
    func  testChangeBaudrate_Success() {
        //Act
        let response = tempVr.ChangeBaudrate(baudRate: EasyVRKit.Protocol.Baudrate.B9600);
        //Assert
        XCTAssertTrue(response);
    }
    
    
    
    
    func testPlayPhoneTone() {
        
        //Arrange
        var response: Bool = true;
        
        //Act
        response = try! tempVr.PlayPhoneTone(tone: 1, duration: 9)
        
        //Assert
        XCTAssert(response == true);
    }
    
    
    
}
