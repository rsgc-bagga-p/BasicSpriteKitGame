//
//  GameScene.swift
//  SpriteKitAnimationExample
//
//  Created by Russell Gordon on 12/19/16.
//  Copyright © 2016 Russell Gordon. All rights reserved.
//

import SpriteKit
import GameplayKit

class Scene: SKScene {

    // Properties available to all methods in the class are defined here
    var midPoint = CGPoint()
    var circle = SKSpriteNode()
    
    // This method runs once after the scene loads
    override func didMove(to view: SKView) {
        
        // Set the background color
        backgroundColor = SKColor.black
        
        // Set the midpoint value
        midPoint = CGPoint(x: size.width / 2.0, y: size.height / 2.0)
        
        // Make sprite objects for various shapes
        for y in stride(from: 35, through: 315, by: 70) {
            
            // Define a square
            let square = SKSpriteNode(imageNamed: "square")
            square.name = "wall square"
            square.position = CGPoint(x: self.size.width - 200,
                                      y: CGFloat(y))
            
            // Add the sprites to the scene
            self.addChild(square)
            
            // Make a path around the rectangle
            let squarePath = CGMutablePath()
            // Start at bottom left corner
            squarePath.move(to: CGPoint(x: -square.size.width / 2, y: -square.size.height / 2))
            // Draw left path to upper left corner
            squarePath.addLine(to: CGPoint(x: -square.size.width / 2, y: square.size.height / 2))
            // Draw top path to upper right corner
            squarePath.addLine(to: CGPoint(x: square.size.width / 2, y: square.size.height / 2))
            // Draw right path to lower right corner
            squarePath.addLine(to: CGPoint(x: square.size.width / 2, y: -square.size.height / 2))
            // Draw bottom path to bottom left corner
            squarePath.addLine(to: CGPoint(x: -square.size.width / 2, y: -square.size.height / 2))
            
            // Set physics body for the square based on its existing dimensions (frame size)
//            square.physicsBody = SKPhysicsBody(edgeLoopFrom: square.centerRect)
//            square.physicsBody = SKPhysicsBody(texture: square.texture!, size: square.size)
            square.physicsBody = SKPhysicsBody(edgeLoopFrom: squarePath)
            
        }

        // Add the ball that will be shot
        circle = SKSpriteNode(imageNamed: "circle")
        circle.name = "shape"
        circle.position = CGPoint(x: self.size.width * 0.25,
                                  y: circle.frame.height / 2)
        self.addChild(circle)
        
        // Set physics body for the circle based on its radius
        circle.physicsBody = SKPhysicsBody(circleOfRadius: circle.size.width / 2)
        
        // Make an edge loop at the boundaries of the scene
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
                
    }
    
    // This function runs every time the viewable frame is updated by SpriteKit (roughly 60 fps)
    // Code in this loop should be kept as minimal as possible so that game performance is not degraded
    override func update(_ currentTime: TimeInterval) {
        
    }
    
    override func mouseDragged(with event: NSEvent) {
        print(event.locationInWindow.x)
    }
    
    override func mouseDown(with event: NSEvent) {
        
        
        
    }
    
    override func mouseUp(with event: NSEvent) {
        // Get the vector that represents the difference between the click location and the circle location
        let differenceX = event.locationInWindow.x - circle.position.x
        print("DifferenceX is: \(differenceX)")
        let differenceY = event.locationInWindow.y - circle.position.y
        print("DifferenceY is: \(differenceY)")
        
        // Move the circle
        if let body = circle.physicsBody {
            body.applyImpulse(CGVector(dx: differenceX, dy: differenceY))
        }
        
    }
    
}
