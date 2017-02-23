//
//  GameScene.swift
//  SpriteKitAnimationExample
//
//  Created by Russell Gordon on 12/19/16.
//  Copyright © 2016 Russell Gordon. All rights reserved.
//

import SpriteKit
import GameplayKit

class MenuScene : SKScene {
    
    // Properties available to all methods in the class are defined here
    var midPoint = CGPoint()
    var title = SKLabelNode()
    
    // This method runs once after the scene loads
    override func didMove(to view: SKView) {
        
        // Set the background color
        backgroundColor = SKColor.blue
        
        // Set the midpoint value
        midPoint = CGPoint(x: size.width / 2.0, y: size.height / 2.0)
        
        // This will allow us to see what's happening with the collision
        title = SKLabelNode(fontNamed: "Futura Bold")
        title.position = midPoint
        title.isHidden = false
        title.fontSize = 48
        title.zPosition = 250
        title.fontColor = SKColor.white
        title.text = "Menu"
        self.addChild(title)
        
    }
    
    // This function runs every time the viewable frame is updated by SpriteKit (roughly 60 fps)
    // Code in this loop should be kept as minimal as possible so that game performance is not degraded
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    override func mouseDragged(with event: NSEvent) {
        
        
    }
    
    override func mouseDown(with event: NSEvent) {
        
    }
    
    override func mouseUp(with event: NSEvent) {
        
        
    }
    
    
    // Tells you when two bodies first make contact
    func didBegin(_ contact: SKPhysicsContact) {
        
        
    }
    
    // Tells you when two bodies end their contact
    func didEnd(_ contact: SKPhysicsContact) {
        
    }
    
}
