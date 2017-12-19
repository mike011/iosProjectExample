//
//  TickleGestureRecognizer.swift
//  MonkeyPinch
//
//  Created by Michael Charland on 2016-05-31.
//  Copyright © 2016 Bloc. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class TickleGestureRecognizer:UITapGestureRecognizer {
    
    let requiredTickles = 2
    let distanceForTickleGesture:CGFloat = 25.0
    
    enum Direction:Int {
        case DirectionUnknown = 0
        case DirectionLeft
        case DirectionRight
    }
    
    var tickleCount:Int = 0
    var curTickleStart:CGPoint = CGPoint(x: 0, y: 0)
    var lastDirection:Direction = .DirectionUnknown

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if let touch = touches.first {
            self.curTickleStart = touch.location(in: self.view)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        if let touch = touches.first {
            let ticklePoint = touch.location(in: self.view)
            
            let moveAmt = ticklePoint.x - curTickleStart.x
            var curDirection:Direction
            if moveAmt < 0 {
                curDirection = .DirectionLeft
            } else {
                curDirection = .DirectionRight
            }
        
        
            // moveAmt is a Float, so self.distanceForTickleGesture needs to be a Float also
            if abs(moveAmt) < self.distanceForTickleGesture {
                return
            }
        
            if   self.lastDirection == .DirectionUnknown ||
                (self.lastDirection == .DirectionLeft && curDirection == .DirectionRight) ||
                (self.lastDirection == .DirectionRight && curDirection == .DirectionLeft) {
                self.tickleCount += 1
                self.curTickleStart = ticklePoint
                self.lastDirection = curDirection
            
                if self.state == .possible && self.tickleCount > self.requiredTickles {
                    self.state = .ended
                }
            }
        }
    }
    
    override func reset() {
        self.tickleCount = 0
        self.curTickleStart = CGPoint(x: 0,y :0)
        self.lastDirection = .DirectionUnknown
        if self.state == .possible {
            self.state = .failed
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        self.reset()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        self.reset()
    }
}

