//
//  ViewController.swift
//  SpriteKitAnimationExample
//
//  Created by Russell Gordon on 12/19/16.
//  Copyright © 2016 Russell Gordon. All rights reserved.
//

import Cocoa
import SpriteKit

class ViewController: NSViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create the game scene
        let scene = Scene(size: CGSize(width: 800, height: 600))
        
        // Configure and present the scene
        let skView = SKView(frame: NSRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 800, height: 600)))
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        view.addSubview(skView)
        scene.scaleMode = .aspectFit
        skView.presentScene(scene)
        
        // DEBUG: Show physics bodies outlines
        skView.showsPhysics = true
        
    }
    
    override func viewDidAppear() {
        super.viewDidAppear()
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
}
