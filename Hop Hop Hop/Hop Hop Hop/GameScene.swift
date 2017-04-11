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
    var background = SKSpriteNode()
    var gameOverNode = SKLabelNode()
    var youWinNode = SKLabelNode()
    
    let cameraNode = SKCameraNode()

    var score = 0
    
    var touchCount = 0
    
    var didJump = false
    
    // Update function
    override func update(_ currentTime: TimeInterval) {
        
        print("-----------")
        print("score: ", score)
        print("touches: ", touchCount)
        
        if karateKidNode.physicsBody!.velocity.dx == 0 && didJump == true && karateKidNode.position.y >= -600 {
            didJump = false
            
            score = score + 1
            updateScore()
        }
        
        // Showing GAME OVER node
        gameOverNode.zPosition = -5
        
        if karateKidNode.position.y < -1000 {
            
            gameOverNode.zPosition = 200
            gameOverNode.position = CGPoint(x: cameraNode.position.x, y: cameraNode.position.y)
        }
        
        // Showing YOU WIN node
        youWinNode.zPosition = -5
        
        if karateKidNode.position.x > 3600 && karateKidNode.position.y >= -600 {
            youWinNode.zPosition = 200
            youWinNode.position = CGPoint(x: cameraNode.position.x, y: cameraNode.position.y)
        }
        
        cameraNode.position = CGPoint(x: karateKidNode.position.x + 200, y: karateKidNode.position.y + 300)
        
        // Set location of score to camera location
        scoreLabelNode.position = CGPoint(x: cameraNode.position.x, y: cameraNode.position.y + 560)
        scoreNode.position = CGPoint(x: cameraNode.position.x, y: cameraNode.position.y + 510)
        background.position = CGPoint(x: (cameraNode.position.x)-0.1*(karateKidNode.position.x), y: (cameraNode.position.y)-0.1*(karateKidNode.position.y) + 560)
        
    }
    
    //Initial functions
    override func didMove(to view: SKView) {
            
        // Creating physics effects
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
        
        // Creating physics boundries
        let sceneBody = SKPhysicsBody(edgeLoopFrom: self.frame.insetBy(dx: CGFloat(-5000), dy: CGFloat(-2000)))
        sceneBody.friction = 0.9
        self.physicsBody = sceneBody
        
        // Making background
        background = SKSpriteNode(imageNamed: "fortuneCookieBackground")
        background.position = CGPoint(x: self.size.height*0, y: self.frame.width*0)
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.size = CGSize(width: self.frame.size.width*9, height: self.frame.size.height*2.25)
        background.zPosition = -1
        self.addChild(background)
        
        // Making score label
        scoreLabelNode = SKLabelNode(fontNamed: "Futura Bold")
        scoreLabelNode.text = "SCORE"
        scoreLabelNode.fontSize = 60
        scoreLabelNode.fontColor = SKColor.white
        scoreLabelNode.position = CGPoint(x: self.frame.size.width*0, y: self.frame.size.height*0.4)
        scoreLabelNode.zPosition = 1
        self.addChild(scoreLabelNode)
        
        // Show score under label
        scoreNode = SKLabelNode(fontNamed: "Futura Bold")
        scoreNode.text = String(score)
        scoreNode.fontSize = 50
        scoreNode.fontColor = SKColor.gray
        scoreNode.position = CGPoint(x: self.frame.size.width*0, y: self.frame.size.height*0.35)
        scoreLabelNode.zPosition = 1
        self.addChild(scoreNode)
        
        // Making GAME OVER label
        gameOverNode = SKLabelNode(fontNamed: "Futura Bold")
        gameOverNode.text = String("GAME OVER!")
        gameOverNode.fontSize = 100
        gameOverNode.fontColor = SKColor.white
        gameOverNode.position = CGPoint(x: self.frame.size.width*0, y: self.frame.size.height*0)
        gameOverNode.zPosition = -5
        self.addChild(gameOverNode)
        
        // Making YOU WIN label
        youWinNode = SKLabelNode(fontNamed: "Futura Bold")
        youWinNode.text = String("YOU WIN!")
        youWinNode.fontSize = 100
        youWinNode.fontColor = SKColor.white
        youWinNode.position = CGPoint(x: self.frame.size.width*0, y: self.frame.size.height*0)
        youWinNode.zPosition = -5
        self.addChild(youWinNode)
        
        // Making game character
        karateKidNode = SKSpriteNode(imageNamed: "karateKid")
        karateKidNode.size = CGSize(width: 130, height: 130)
        karateKidNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        karateKidNode.position = CGPoint(x: -250, y: 500)
        karateKidNode.zPosition = 100
        karateKidNode.name = "karateKid"
        self.addChild(karateKidNode)
        karateKidNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 130, height: 130))
        
        // PLATFORMS
        
        // Making platform #1
        platformNode = SKSpriteNode(imageNamed: "platform")
        platformNode.size = CGSize(width: 150, height: 22.5)
        platformNode.anchorPoint = CGPoint(x: 0, y: 0)
        platformNode.position = CGPoint(x: -350, y: -600)
        platformNode.zPosition = 99
        platformNode.name = "platform1"
        self.addChild(platformNode)
        let platformBody = CGRect(x: 0, y: 0, width: 150, height: 22.5)
        platformNode.physicsBody = SKPhysicsBody(edgeLoopFrom: platformBody)
        platformNode.physicsBody!.friction = 1.0
        
        // Making platform #2
        platformNode = SKSpriteNode(imageNamed: "platform")
        platformNode.size = CGSize(width: 150, height: 22.5)
        platformNode.anchorPoint = CGPoint(x: 0, y: 0)
        platformNode.position = CGPoint(x: 100, y: (Int(arc4random_uniform(600)) - 600))
        platformNode.zPosition = 99
        platformNode.name = "platform2"
        self.addChild(platformNode)
        let platformBody2 = CGRect(x: 0, y: 0, width: 150, height: 22.5)
        platformNode.physicsBody = SKPhysicsBody(edgeLoopFrom: platformBody2)
        platformNode.physicsBody!.friction = 1.0
        
        // Making platform #3
        platformNode = SKSpriteNode(imageNamed: "platform")
        platformNode.size = CGSize(width: 150, height: 22.5)
        platformNode.anchorPoint = CGPoint(x: 0, y: 0)
        platformNode.position = CGPoint(x: 550, y: (Int(arc4random_uniform(600)) - 600))
        platformNode.zPosition = 99
        platformNode.name = "platform3"
        self.addChild(platformNode)
        let platformBody3 = CGRect(x: 0, y: 0, width: 150, height: 22.5)
        platformNode.physicsBody = SKPhysicsBody(edgeLoopFrom: platformBody3)
        platformNode.physicsBody!.friction = 1.0
        
        // Making platform #4
        platformNode = SKSpriteNode(imageNamed: "platform")
        platformNode.size = CGSize(width: 150, height: 22.5)
        platformNode.anchorPoint = CGPoint(x: 0, y: 0)
        platformNode.position = CGPoint(x: 1000, y: (Int(arc4random_uniform(600)) - 600))
        platformNode.zPosition = 99
        platformNode.name = "platform4"
        self.addChild(platformNode)
        let platformBody4 = CGRect(x: 0, y: 0, width: 150, height: 22.5)
        platformNode.physicsBody = SKPhysicsBody(edgeLoopFrom: platformBody4)
        platformNode.physicsBody!.friction = 1.0
        
        // Making platform #5
        platformNode = SKSpriteNode(imageNamed: "platform")
        platformNode.size = CGSize(width: 150, height: 22.5)
        platformNode.anchorPoint = CGPoint(x: 0, y: 0)
        platformNode.position = CGPoint(x: 1450, y: (Int(arc4random_uniform(600)) - 600))
        platformNode.zPosition = 99
        platformNode.name = "platform5"
        self.addChild(platformNode)
        let platformBody5 = CGRect(x: 0, y: 0, width: 150, height: 22.5)
        platformNode.physicsBody = SKPhysicsBody(edgeLoopFrom: platformBody5)
        platformNode.physicsBody!.friction = 1.0
        
        // Making platform #6
        platformNode = SKSpriteNode(imageNamed: "platform")
        platformNode.size = CGSize(width: 150, height: 22.5)
        platformNode.anchorPoint = CGPoint(x: 0, y: 0)
        platformNode.position = CGPoint(x: 1900, y: (Int(arc4random_uniform(600)) - 600))
        platformNode.zPosition = 99
        platformNode.name = "platform6"
        self.addChild(platformNode)
        let platformBody6 = CGRect(x: 0, y: 0, width: 150, height: 22.5)
        platformNode.physicsBody = SKPhysicsBody(edgeLoopFrom: platformBody6)
        platformNode.physicsBody!.friction = 1.0
        
        // Making platform #7
        platformNode = SKSpriteNode(imageNamed: "platform")
        platformNode.size = CGSize(width: 150, height: 22.5)
        platformNode.anchorPoint = CGPoint(x: 0, y: 0)
        platformNode.position = CGPoint(x: 2350, y: (Int(arc4random_uniform(600)) - 600))
        platformNode.zPosition = 99
        platformNode.name = "platform7"
        self.addChild(platformNode)
        let platformBody7 = CGRect(x: 0, y: 0, width: 150, height: 22.5)
        platformNode.physicsBody = SKPhysicsBody(edgeLoopFrom: platformBody7)
        platformNode.physicsBody!.friction = 1.0
        
        // Making platform #8
        platformNode = SKSpriteNode(imageNamed: "platform")
        platformNode.size = CGSize(width: 150, height: 22.5)
        platformNode.anchorPoint = CGPoint(x: 0, y: 0)
        platformNode.position = CGPoint(x: 2800, y: (Int(arc4random_uniform(600)) - 600))
        platformNode.zPosition = 99
        platformNode.name = "platform8"
        self.addChild(platformNode)
        let platformBody8 = CGRect(x: 0, y: 0, width: 150, height: 22.5)
        platformNode.physicsBody = SKPhysicsBody(edgeLoopFrom: platformBody8)
        platformNode.physicsBody!.friction = 1.0
        
        // Making platform #9
        platformNode = SKSpriteNode(imageNamed: "platform")
        platformNode.size = CGSize(width: 150, height: 22.5)
        platformNode.anchorPoint = CGPoint(x: 0, y: 0)
        platformNode.position = CGPoint(x: 3250, y: (Int(arc4random_uniform(600)) - 600))
        platformNode.zPosition = 99
        platformNode.name = "platform9"
        self.addChild(platformNode)
        let platformBody9 = CGRect(x: 0, y: 0, width: 150, height: 22.5)
        platformNode.physicsBody = SKPhysicsBody(edgeLoopFrom: platformBody9)
        platformNode.physicsBody!.friction = 1.0
        
        // Making platform #10
        platformNode = SKSpriteNode(imageNamed: "platform")
        platformNode.size = CGSize(width: 150, height: 22.5)
        platformNode.anchorPoint = CGPoint(x: 0, y: 0)
        platformNode.position = CGPoint(x: 3700, y: (Int(arc4random_uniform(600)) - 600))
        platformNode.zPosition = 99
        platformNode.name = "platform10"
        self.addChild(platformNode)
        let platformBody10 = CGRect(x: 0, y: 0, width: 150, height: 22.5)
        platformNode.physicsBody = SKPhysicsBody(edgeLoopFrom: platformBody10)
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
        
        
        
    }
    
    // Testing to make sure touch is registered (noticed)
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let touch = touches.first else {
            return
        }
        
        // Track touch location
        let touchLocation = touch.location(in: self)
        
        // Create value for distance from character to touch
        let dX = touchLocation.x - karateKidNode.position.x
        let dY = touchLocation.y - karateKidNode.position.y
        
        // Apply an impulse in direction towards touch
        
        if touchCount == score {
            if let body = karateKidNode.physicsBody {
            body.applyImpulse(CGVector(dx: (dX), dy: (dY)*2.2))
            }
            
            touchCount = touchCount + 1
        }
        
        didJump = true
        
    }
}
