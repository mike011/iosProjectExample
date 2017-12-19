//
//  ViewController.swift
//  MonkeyPinch
//
//  Created by Michael Charland on 2016-05-10.
//  Copyright © 2016 Bloc. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet var monkeyPan: UIPanGestureRecognizer!
    @IBOutlet var bananaPan: UIPanGestureRecognizer!
    
    var chompPlayer:AVAudioPlayer? = nil
    var hehePlayer:AVAudioPlayer? = nil
    
    func loadSound(filename:NSString) -> AVAudioPlayer {
        let url = Bundle.main.url(forResource: filename as String, withExtension: "caf")
        let player = try? AVAudioPlayer(contentsOf: url!, fileTypeHint: "caf")
        if player == nil {
            print("Error loading \(url)")
        } else {
            player?.prepareToPlay()
        }
        return player!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let filteredSubviews = self.view.subviews
        for view in filteredSubviews {
            let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            recognizer.delegate = self
            view.addGestureRecognizer(recognizer)
            
            recognizer.require(toFail: monkeyPan)
            recognizer.require(toFail: bananaPan)
            
            let recognizer2 = TickleGestureRecognizer(target: self, action: #selector(handleTickle))
            recognizer2.delegate = self
            view.addGestureRecognizer(recognizer2)
            
        }
        self.chompPlayer = self.loadSound(filename: "chomp")
        self.hehePlayer = self.loadSound(filename: "hehehe1")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        
        // comment for panning
        // uncomment for tickling
        return;
        
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x, y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint(x: 0,y :0), in: self.view)
        
        if recognizer.state == UIGestureRecognizerState.ended {
            
            let velocity = recognizer.velocity(in: self.view)
            let magnitude = sqrt((velocity.x * velocity.x) + (velocity.y * velocity.y))
            let slideMultiplier = magnitude / 200
            print("magnitude: \(magnitude), slideMultiplier: \(slideMultiplier)")
            
            let slideFactor = 0.1 * slideMultiplier // Increase for more slide
            var finalPoint = CGPoint(x:recognizer.view!.center.x + (velocity.x * slideFactor),
                                     y:recognizer.view!.center.y + (velocity.y * slideFactor))
            finalPoint.x = min(max(finalPoint.x, 0), self.view.bounds.size.width)
            finalPoint.y = min(max(finalPoint.y, 0), self.view.bounds.size.height)
            
            UIView.animate(withDuration: Double(slideFactor * 2), delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {recognizer.view!.center = finalPoint }, completion: nil)
            
        }
    }
    
    @IBAction func handlePinch(recognizer: UIPinchGestureRecognizer) {
        if let view = recognizer.view {
            //view.transform = CGAffineTransformScale(view.transform, recognizer.scale, recognizer.scale)
            view.transform = view.transform.scaledBy(x: 0, y: 0)
            recognizer.scale = 1
        }
    }
    
    @IBAction func handleRotate(recognizer: UIRotationGestureRecognizer) {
        if let view = recognizer.view {
            //view.transform = CGAffineTransformRotate(view.transform, recognizer.rotation)
             view.transform = view.transform.scaledBy(x: 0, y: 0)
            recognizer.rotation = 0
        }
        
    }

    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func handleTap(recognizer: UITapGestureRecognizer) {
        self.chompPlayer?.play()
    }
    
    func handleTickle(recognizer: TickleGestureRecognizer) {
        self.hehePlayer?.play()
    }

}

