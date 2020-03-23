//
//  MonkeyPinchTests.swift
//  MonkeyPinchTests
//
//  Created by Michael Charland on 2016-05-10.
//  Copyright © 2016 Bloc. All rights reserved.
//

@testable import MonkeyPinch
import XCTest

class MonkeyPinchTests: XCTestCase {
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        let tgr = TickleGestureRecognizer()
        let touches = Set<UITouch>()
        let event = UIEvent()
        tgr.touchesMoved(touches, with: event)
    }

    func testRandomFailure() {
        let number = Int.random(in: 0 ... 1)
        XCTAssertEqual(number, 0)
       }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
