//
//  MonkeyPinchTests.swift
//  MonkeyPinchTests
//
//  Created by Michael Charland on 2016-05-10.
//  Copyright © 2016 Bloc. All rights reserved.
//

@testable import MonkeyPinch
import Testing
import UIKit

struct MonkeyPinchTests {

    @Test func example() async {
        let tgr = await TickleGestureRecognizer()
        let touches = Set<UITouch>()
        let event = await UIEvent()
        await tgr.touchesMoved(touches, with: event)
    }
    
    @Test func coverage() async {
        let vc = await ViewController()
        await vc.viewDidLoad()
    }
    
}
