import SpriteKit
import PlaygroundSupport

// Define the size of the animation
let frame = CGRect(x: 0, y: 0, width: 400, height: 256)

// Set the midpoint of the scene
let midPoint = CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0)

// Create the scene
var scene = SKScene(size: frame.size)

// Set scene background colour
scene.backgroundColor

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
scene.run(sequence)

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
    scene.addChild(monologueLabels[monologueLabels.count - 1]) // Add to scene
    monologueLabels[monologueLabels.count - 1].run(sequence)
    
}

// Create the view
let view = SKView(frame: frame)
view.showsFPS = true
view.showsNodeCount = true

// Present the scene we just configured
view.presentScene(scene)

// Show the view in the live view area at right
PlaygroundPage.current.liveView = view

