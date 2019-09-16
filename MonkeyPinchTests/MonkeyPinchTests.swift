//
//  MonkeyPinchTests.swift
//  MonkeyPinchTests
//
//  Created by Michael Charland on 2016-05-10.
//  Copyright © 2016 Bloc. All rights reserved.
//

import XCTest
@testable import MonkeyPinch

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
    
    func testCoverage() {
        let vc = ViewController()
        vc.viewDidLoad()
    }
    
}
