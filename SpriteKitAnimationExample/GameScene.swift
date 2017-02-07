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
            
            // Set physics body for the square based on its existing dimensions (frame size)
            square.physicsBody = SKPhysicsBody(edgeLoopFrom: square.frame)
        }

        // Add the ball that will be shot
        let circle = SKSpriteNode(imageNamed: "circle")
        circle.name = "shape"
        circle.position = CGPoint(x: self.size.width * 0.25,
                                  y: self.size.height * 0.50)
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
    
    // This method handles setup of the actions to create the basic animation
    func showMonologue() {
        
        // Array of sentences to display on screen
        var sentences : [String] = []
        sentences += ["Space..."]
        sentences += ["The Final Frontier"]
        sentences += ["These are the voyages"]
        sentences += ["of the starship"]
        sentences += ["Enterprise."]
        sentences += ["It's continuing mission..."]
        sentences += ["to explore strange new worlds"]
        sentences += ["to seek out new life"]
        sentences += ["and new civilizations"]
        sentences += ["to boldly go"]
        sentences += ["where no one"]
        sentences += ["has gone before."]
        
        // Create some actions that will be reused below several times (action creation is expensive so unnecessary re-creation of actions should be avoided)
        let actionMakeVisible = SKAction.unhide()
        let actionFadeIn = SKAction.fadeIn(withDuration: 1)
        let actionWaitToShow = SKAction.wait(forDuration: 1)
        let actionFadeOut = SKAction.fadeOut(withDuration: 1)
        let actionRemoveNode = SKAction.removeFromParent()
        
        // Play short sound clip
        let actionPlaySound = SKAction.playSoundFileNamed("space-final-frontier.mp3", waitForCompletion: false)
        let sequence = SKAction.sequence([actionWaitToShow, actionPlaySound])
        self.run(sequence)
        
        // Iterate over the sentences and create SKLabelNodes
        var monologueLabels : [SKLabelNode] = []
        for sentence in sentences {
            
            // Create the instance of SKLabelNode
            monologueLabels += [SKLabelNode(fontNamed: "Futura")]
            
            // Configure the instance just added to the monologueLabels array
            monologueLabels[monologueLabels.count - 1].fontSize = 24
            monologueLabels[monologueLabels.count - 1].fontColor = SKColor.white
            monologueLabels[monologueLabels.count - 1].zPosition = 250
            monologueLabels[monologueLabels.count - 1].position = midPoint
            monologueLabels[monologueLabels.count - 1].text = sentence
            monologueLabels[monologueLabels.count - 1].isHidden = true
            
            // Set up some actions to show each label
            let delay = TimeInterval(3 * (monologueLabels.count - 1))
            let actionWaitToAppear = SKAction.wait(forDuration: delay)
            let sequence = SKAction.sequence([actionWaitToAppear, actionMakeVisible, actionFadeIn, actionWaitToShow, actionFadeOut, actionRemoveNode])
            
            // Add the label to the scene and then run the sequence on it
            self.addChild(monologueLabels[monologueLabels.count - 1]) // Add to scene
            monologueLabels[monologueLabels.count - 1].run(sequence)
            
        }

    }
}
