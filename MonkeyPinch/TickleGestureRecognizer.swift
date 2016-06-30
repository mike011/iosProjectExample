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
    var curTickleStart:CGPoint = CGPointZero
    var lastDirection:Direction = .DirectionUnknown

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent) {
        if let touch = touches.first {
            self.curTickleStart = touch.locationInView(self.view)
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent) {
        if let touch = touches.first {
            let ticklePoint = touch.locationInView(self.view)
            
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
            
                if self.state == .Possible && self.tickleCount > self.requiredTickles {
                    self.state = .Ended
                }
            }
        }
    }
    
    override func reset() {
        self.tickleCount = 0
        self.curTickleStart = CGPointZero
        self.lastDirection = .DirectionUnknown
        if self.state == .Possible {
            self.state = .Failed
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent) {
        self.reset()
    }
    
    override func touchesCancelled(touches: Set<UITouch>, withEvent event: UIEvent) {
        self.reset()
    }
}

