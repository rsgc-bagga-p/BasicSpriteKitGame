//
//  GameScene.swift
//  SpriteKitAnimationExample
//
//  Created by Russell Gordon on 12/19/16.
//  Copyright © 2016 Russell Gordon. All rights reserved.
//

import SpriteKit
import GameplayKit

struct PhysicsCategory {
    static let None     :   UInt32 = 0
    static let Block    :   UInt32 = 0b0001  // 1
    static let Ball     :   UInt32 = 0b0010  // 2
    static let Edge     :   UInt32 = 0b0100  // 4
}

class Scene : SKScene, SKPhysicsContactDelegate {

    // Properties available to all methods in the class are defined here
    var midPoint = CGPoint()
    var circle = SKSpriteNode()
    var collisionNotification = SKLabelNode()
    
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
            square.physicsBody = SKPhysicsBody(edgeLoopFrom: squarePath)
            
            // Set the physics category
            square.physicsBody!.categoryBitMask = PhysicsCategory.Block
            
            // IMPORTANT: You need this line to receive callbacks in didBegin and didEnd to detect when collisions start and end with the block
            square.physicsBody!.contactTestBitMask = PhysicsCategory.Ball
            
        }

        // Add the ball that will be shot
        circle = SKSpriteNode(imageNamed: "circle")
        circle.name = "shape"
        circle.position = CGPoint(x: self.size.width * 0.25,
                                  y: circle.frame.height / 2)
        self.addChild(circle)
        
        // Set physics body for the circle based on its radius
        circle.physicsBody = SKPhysicsBody(circleOfRadius: circle.size.width / 2)
        
        // Set the category and collision bit masks for the circle
        circle.physicsBody!.categoryBitMask = PhysicsCategory.Ball
        circle.physicsBody!.collisionBitMask = PhysicsCategory.Block | PhysicsCategory.Edge
        
        // Make an edge loop at the boundaries of the scene
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        
        // Categorize the boundary of the scene as an edge
        self.physicsBody!.categoryBitMask = PhysicsCategory.Edge

        // IMPORTANT: You need this line to receive callbacks in didBegin and didEnd to detect when collisions start and end with the wall
        self.physicsBody!.contactTestBitMask = PhysicsCategory.Ball

        // Make sure the physics world is set up to respond to contact and collision events
        physicsWorld.contactDelegate = self
        
        // This will allow us to see what's happening with the collision
        collisionNotification = SKLabelNode(fontNamed: "Futura Bold")
        collisionNotification.position = midPoint
        collisionNotification.isHidden = true
        collisionNotification.fontSize = 48
        collisionNotification.zPosition = 250
        collisionNotification.fontColor = SKColor.white
        collisionNotification.text = ""
        self.addChild(collisionNotification)
        
        
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

        // Get the vector that represents the difference between the click location and the circle location
        let differenceX = event.locationInWindow.x - circle.position.x
        let differenceY = event.locationInWindow.y - circle.position.y
        
        // Move the circle
        if let body = circle.physicsBody {
            body.applyImpulse(CGVector(dx: differenceX, dy: differenceY))
        }
        
    }

    
    // Tells you when two bodies first make contact
    func didBegin(_ contact: SKPhysicsContact) {
        

        // Get the logical OR bit mask of the two bodies that are colliding
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        print("Collision between \(collision)")
        
        // See whether the ball hit the blocks, or the edge of the scene
        if collision == PhysicsCategory.Ball | PhysicsCategory.Block {
            collisionNotification.text = "Block"
        } else if collision == PhysicsCategory.Ball | PhysicsCategory.Edge {
            collisionNotification.text = "Edge"
        }
        
        // Make the notification show up
        collisionNotification.isHidden = false
        
    }
    
    // Tells you when two bodies end their contact
    func didEnd(_ contact: SKPhysicsContact) {
        
        print("Did end")

        // Make the notification go away
        collisionNotification.isHidden = true
        
    }
    
}
