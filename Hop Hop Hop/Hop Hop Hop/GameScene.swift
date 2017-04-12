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
    var restartNode = SKLabelNode()
    var playJumpSound = SKAction()
    var instructionsNode = SKLabelNode()
    var instructionsNode2 = SKLabelNode()
    var oneBlockAtaTimeNode = SKLabelNode()
    var jumpFartherNode = SKLabelNode()
    
    let cameraNode = SKCameraNode()

    var score = 0
    
    var touchCount = 0
    
    var didJump = false
    
    var gameOverCount = 0
    
    // Update function
    override func update(_ currentTime: TimeInterval) {
       
        // Print statements
        print("-----------")
        print("score: ", score)
        print("touches: ", touchCount)
        print("gameOver: ", gameOverCount)
        
        // Score increaser
        if karateKidNode.physicsBody!.velocity.dx == 0 && didJump == true && karateKidNode.position.y >= -600 && Int(karateKidNode.position.x)+250 > (touchCount*450)-150 {
           
            didJump = false
            
            score = score + 1
            updateScore()
        }
        
        // If player doesn't jump far enough
        if Int((karateKidNode.position.x)+250) < ((touchCount*450)-150) && karateKidNode.physicsBody!.velocity.dx == 0 && touchCount >= 1 && karateKidNode.position.y > -700 {
            
            gameOverCount = gameOverCount + 1
            jumpFartherNode.zPosition = 200
            jumpFartherNode.position = CGPoint(x: cameraNode.position.x, y: cameraNode.position.y-60)
        }
        
        // If player jumps too far
        if Int((karateKidNode.position.x)+250) > ((touchCount*450)+150) && karateKidNode.physicsBody!.velocity.dx == 0 && touchCount >= 1 {
            
            gameOverCount = gameOverCount + 1
            oneBlockAtaTimeNode.zPosition = 200
            oneBlockAtaTimeNode.position = CGPoint(x: cameraNode.position.x, y: cameraNode.position.y-60)
        }
        
        // If player falls too low, end the game
        if Int(karateKidNode.position.y) < -1000 {
            
            gameOverCount = gameOverCount + 1
        }
        
        // Showing GAME OVER node
        gameOverNode.zPosition = -5
        
        // If game is over
        if gameOverCount >= 1 {
            
            gameOverNode.zPosition = 200
            gameOverNode.position = CGPoint(x: cameraNode.position.x, y: cameraNode.position.y)
            
            restartNode.zPosition = 200
            restartNode.position = CGPoint(x: cameraNode.position.x, y: cameraNode.position.y - 450)
        }
        
        // Showing YOU WIN node
        youWinNode.zPosition = -5
        
        // If player reaches end of game (10th chopstick)
        if karateKidNode.position.x > 3600 && karateKidNode.position.y >= -600 && karateKidNode.physicsBody!.velocity.dx == 0 {
            youWinNode.zPosition = 200
            youWinNode.position = CGPoint(x: cameraNode.position.x, y: cameraNode.position.y)
            
            restartNode.zPosition = 200
            restartNode.position = CGPoint(x: cameraNode.position.x, y: cameraNode.position.y - 450)
        }
        
        // Set camera location
        cameraNode.position = CGPoint(x: karateKidNode.position.x + 200, y: (karateKidNode.position.y + 300) - karateKidNode.position.y*0.2)
        
        // Set location of score to camera location
        scoreLabelNode.position = CGPoint(x: cameraNode.position.x, y: cameraNode.position.y + 560)
        scoreNode.position = CGPoint(x: cameraNode.position.x, y: cameraNode.position.y + 510)
        background.position = CGPoint(x: (cameraNode.position.x)-0.1*(karateKidNode.position.x), y: (cameraNode.position.y)-0.1*(karateKidNode.position.y) + 560)
        
    }
    
    //Initial functions
    override func didMove(to view: SKView) {
        
        // Initializing sound effect
        playJumpSound = SKAction.playSoundFileNamed("jump.wav", waitForCompletion: false)
        
        // Creating physics effects
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -7.8)
        
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
        
        // Making ONE BLOCK AT A TIME label
        oneBlockAtaTimeNode = SKLabelNode(fontNamed: "Futura Bold")
        oneBlockAtaTimeNode.text = String("ONE BLOCK AT A TIME!")
        oneBlockAtaTimeNode.fontSize = 45
        oneBlockAtaTimeNode.fontColor = SKColor.brown
        oneBlockAtaTimeNode.position = CGPoint(x: self.frame.size.width*0, y: gameOverNode.position.y)
        oneBlockAtaTimeNode.zPosition = -5
        self.addChild(oneBlockAtaTimeNode)
        
        // Making JUMP FARTHER label
        jumpFartherNode = SKLabelNode(fontNamed: "Futura Bold")
        jumpFartherNode.text = String("JUMP FARTHER!")
        jumpFartherNode.fontSize = 45
        jumpFartherNode.fontColor = SKColor.brown
        jumpFartherNode.position = CGPoint(x: self.frame.size.width*0, y: gameOverNode.position.y)
        jumpFartherNode.zPosition = -6
        self.addChild(jumpFartherNode)
        
        // Making RESTART button
        restartNode = SKLabelNode(fontNamed: "Futura Bold")
        restartNode.text = String("CLICK TO RESTART")
        restartNode.fontSize = 60
        restartNode.fontColor = SKColor.gray
        restartNode.position = CGPoint(x: self.frame.size.width*0, y: self.frame.size.height*0)
        restartNode.zPosition = -5
        self.addChild(restartNode)
        
        // Making YOU WIN label
        youWinNode = SKLabelNode(fontNamed: "Futura Bold")
        youWinNode.text = String("YOU WIN!")
        youWinNode.fontSize = 100
        youWinNode.fontColor = SKColor.white
        youWinNode.position = CGPoint(x: self.frame.size.width*0, y: self.frame.size.height*0)
        youWinNode.zPosition = -5
        self.addChild(youWinNode)
        
        // Making Instructions
        instructionsNode = SKLabelNode(fontNamed: "Futura Bold")
        instructionsNode.text = String("TAP THE SCREEN TO JUMP,")
        instructionsNode.fontSize = 20
        instructionsNode.fontColor = SKColor.gray
        instructionsNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        instructionsNode.position = CGPoint(x: -350, y: -650)
        instructionsNode.zPosition = 200
        self.addChild(instructionsNode)
        
        // Making Instructions
        instructionsNode2 = SKLabelNode(fontNamed: "Futura Bold")
        instructionsNode2.text = String("THE FARTHER YOU TAP - THE FARTHER THE JUMP!")
        instructionsNode2.fontSize = 20
        instructionsNode2.fontColor = SKColor.gray
        instructionsNode2.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.left
        instructionsNode2.position = CGPoint(x: -350, y: -680)
        instructionsNode2.zPosition = 200
        self.addChild(instructionsNode2)
        
        // Making game character
        karateKidNode = SKSpriteNode(imageNamed: "karateKid")
        karateKidNode.size = CGSize(width: 130, height: 130)
        karateKidNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        karateKidNode.position = CGPoint(x: -270, y: 100)
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
        platformNode.position = CGPoint(x: 100, y: (Int(arc4random_uniform(100)) - 600))
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
        platformNode.position = CGPoint(x: 550, y: (Int(arc4random_uniform(200)) - 600))
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
        platformNode.position = CGPoint(x: 1000, y: (Int(arc4random_uniform(300)) - 600))
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
        platformNode.position = CGPoint(x: 1450, y: (Int(arc4random_uniform(300)) - 600))
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
        platformNode.position = CGPoint(x: 1900, y: (Int(arc4random_uniform(400)) - 600))
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
        platformNode.position = CGPoint(x: 2350, y: (Int(arc4random_uniform(400)) - 600))
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
        platformNode.position = CGPoint(x: 2800, y: (Int(arc4random_uniform(500)) - 600))
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
        
        // Adding camera node
        addChild(cameraNode)
        camera = cameraNode
        cameraNode.position = CGPoint(x: size.width/2, y: size.height/2)
    }
    
    // Function that is always updating
    func updateScore(){
        scoreNode.text = String(score)
        
    }
    
    // When screen is touched...
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    // When touch ends
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
            body.applyImpulse(CGVector(dx: (dX), dy: (dY)*1.5))
            }
            
            print("test")
            touchCount = touchCount + 1
            
            self.run(playJumpSound)
            
        }
        
        // Restarting game when screen is tapped
        if touchCount == score + 1 && restartNode.zPosition == 200 {
            self.removeAllChildren()
            self.removeAllActions()
            
            let gameScene = GameScene(size: self.size)
            let transition = SKTransition.crossFade(withDuration: 0.3)
            gameScene.scaleMode = SKSceneScaleMode.aspectFill
            self.scene!.view?.presentScene(gameScene, transition: transition)
            
        }
        
        didJump = true
        
    }
}
