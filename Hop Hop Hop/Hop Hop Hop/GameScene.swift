//
//  GameScene.swift
//  Hop Hop Hop
//
//  Created by Scott Blackwell on 2017-02-13.
//  Copyright © 2017 Scott Blackwell. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    // Variables
    var karateKidNode = SKSpriteNode()
    var actionJumpUp = SKAction()
    var actionJumpDown = SKAction()
    var actionJumpSequence = SKAction()
    var platformNode = SKSpriteNode()
    var tapToStart = SKSpriteNode()
    var scoreLabelNode = SKLabelNode()
    var scoreNode = SKLabelNode()
    var tapToStartzPosition = 101
    
    let cameraNode = SKCameraNode()

    var score = 0
    
    var touchCount = 0
    
    var didJump = false
    
    override func update(_ currentTime: TimeInterval) {
        
        if karateKidNode.physicsBody!.velocity.dx == 0 && didJump == true {
            didJump = false
            
            score = score + 1
            updateScore()
        }
        
//        if touchCount >= 1 {
//            tapToStartzPosition = 0
//        }
        
        cameraNode.position = CGPoint(x: karateKidNode.position.x + 200, y: karateKidNode.position.y + 300)
        
        // Set location of score to camera location
        scoreLabelNode.position = CGPoint(x: cameraNode.position.x, y: cameraNode.position.y + 560)
        scoreNode.position = CGPoint(x: cameraNode.position.x, y: cameraNode.position.y + 510)
        
    }
    
    //Initial functions
    override func didMove(to view: SKView) {
        
        // Creating physics effects
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
        
        // Creating physics boundries
        let sceneBody = SKPhysicsBody(edgeLoopFrom: self.frame.insetBy(dx: CGFloat(-1000), dy: CGFloat(-1000)))
        sceneBody.friction = 0.9
        self.physicsBody = sceneBody
        
        // Making background
        let background = SKSpriteNode(imageNamed: "fortuneCookieBackground")
        background.position = CGPoint(x: self.size.height*0, y: self.frame.width*0)
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.size = CGSize(width: self.frame.size.width*4, height: self.frame.size.height*4)
        background.zPosition = -1
        self.addChild(background)
        
        // Making score label
        scoreLabelNode = SKLabelNode(fontNamed: "Futura")
        scoreLabelNode.text = "SCORE"
        scoreLabelNode.fontSize = 60
        scoreLabelNode.fontColor = SKColor.white
        scoreLabelNode.position = CGPoint(x: self.frame.size.width*0, y: self.frame.size.height*0.4)
        scoreLabelNode.zPosition = 1
        self.addChild(scoreLabelNode)
        
        // Show score under label
        scoreNode = SKLabelNode(fontNamed: "Futura")
        scoreNode.text = String(score)
        scoreNode.fontSize = 50
        scoreNode.fontColor = SKColor.gray
        scoreNode.position = CGPoint(x: self.frame.size.width*0, y: self.frame.size.height*0.35)
        scoreLabelNode.zPosition = 1
        self.addChild(scoreNode)
        
        // Making game character
        karateKidNode = SKSpriteNode(imageNamed: "karateKid")
        karateKidNode.size = CGSize(width: 130, height: 130)
        karateKidNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        karateKidNode.position = CGPoint(x: -250, y: 900)
        karateKidNode.zPosition = 100
        karateKidNode.name = "karateKid"
        self.addChild(karateKidNode)
        karateKidNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 130, height: 130))
        
        // PLATFORMS
        
        // Making platform
        platformNode = SKSpriteNode(imageNamed: "platform")
        platformNode.size = CGSize(width: 150, height: 22.5)
        platformNode.anchorPoint = CGPoint(x: 0, y: 0)
        platformNode.position = CGPoint(x: -350, y: -400)
        platformNode.zPosition = 99
        platformNode.name = "platform1"
        self.addChild(platformNode)
        let platformBody = CGRect(x: 0, y: 0, width: 150, height: 22.5)
        platformNode.physicsBody = SKPhysicsBody(edgeLoopFrom: platformBody)
        platformNode.physicsBody!.friction = 1.0
        
        // Making platform
        platformNode = SKSpriteNode(imageNamed: "platform")
        platformNode.size = CGSize(width: 150, height: 22.5)
        platformNode.anchorPoint = CGPoint(x: 0, y: 0)
        platformNode.position = CGPoint(x: 100, y: (Int(arc4random_uniform(400)) - 400))
        platformNode.zPosition = 99
        platformNode.name = "platform2"
        self.addChild(platformNode)
        let platformBody2 = CGRect(x: 0, y: 0, width: 150, height: 22.5)
        platformNode.physicsBody = SKPhysicsBody(edgeLoopFrom: platformBody2)
        platformNode.physicsBody!.friction = 1.0
        
//        // Making 'touch-to-start' screen
//        tapToStart = SKSpriteNode(imageNamed: "tapToStartImage")
//        tapToStart.size = CGSize (width: self.frame.size.width*0.9, height: self.frame.size.height*0.9)
//        tapToStart.anchorPoint = CGPoint(x: 0.5, y: 0.5)
//        tapToStart.position = CGPoint(x: 0, y: 0)
//        tapToStart.zPosition = CGFloat(tapToStartzPosition)
//        self.addChild(tapToStart)
        
        addChild(cameraNode)
        camera = cameraNode
        cameraNode.position = CGPoint(x: size.width/2, y: size.height/2)
    }
    
    func updateScore(){
        
        scoreNode.text = String(score)
    }
    
    // When screen is touched...
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        touchCount = touchCount + 1
        
    }
    
    // Testing to make sure touch is registered (noticed)
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("test")
        print(score)
        print(touchCount)
        
        guard let touch = touches.first else {
            return
        }
        
        // Track touch location
        let touchLocation = touch.location(in: self)
        
        // Create value for distance from character to touch
        let dX = touchLocation.x - karateKidNode.position.x
        let dY = touchLocation.y - karateKidNode.position.y
        
        // Apply an impulse in direction towards touch
        if let body = karateKidNode.physicsBody {
            body.applyImpulse(CGVector(dx: (dX), dy: (dY)*2.2))
        }
        
        didJump = true
        
    }
}
