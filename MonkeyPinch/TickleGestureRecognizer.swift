//
//  TickleGestureRecognizer.swift
//  MonkeyPinch
//
//  Created by Michael Charland on 2016-05-31.
//  Copyright © 2016 Bloc. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

class TickleGestureRecognizer: UITapGestureRecognizer {
    let requiredTickles = 2
    let distanceForTickleGesture: CGFloat = 25.0

    enum Direction: Int {
        case DirectionUnknown = 0
        case DirectionLeft
        case DirectionRight
    }

    var tickleCount: Int = 0
    var curTickleStart: CGPoint = CGPoint(x: 0, y: 0)
    var lastDirection: Direction = .DirectionUnknown

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if let touch = touches.first {
            curTickleStart = touch.location(in: view)
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        if let touch = touches.first {
            let ticklePoint = touch.location(in: view)

            let moveAmt = ticklePoint.x - curTickleStart.x
            var curDirection: Direction
            if moveAmt < 0 {
                curDirection = .DirectionLeft
            } else {
                curDirection = .DirectionRight
            }

            // moveAmt is a Float, so self.distanceForTickleGesture needs to be a Float also
            if abs(moveAmt) < distanceForTickleGesture {
                return
            }

            if lastDirection == .DirectionUnknown ||
                (lastDirection == .DirectionLeft && curDirection == .DirectionRight) ||
                (lastDirection == .DirectionRight && curDirection == .DirectionLeft) {
                tickleCount += 1
                curTickleStart = ticklePoint
                lastDirection = curDirection

                if state == .possible, tickleCount > requiredTickles {
                    state = .ended
                }
            }
        }
    }

    override func reset() {
        tickleCount = 0
        curTickleStart = CGPoint(x: 0, y: 0)
        lastDirection = .DirectionUnknown
        if state == .possible {
            state = .failed
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        reset()
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        reset()
    }
}
