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
    
    var scoreNode = SKLabelNode()
    var score = 0
    
    
    
    //Initial functions
    override func didMove(to view: SKView) {
        
        // Creating physics effects
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
        
        // Creating physics boundries
        let sceneBody = SKPhysicsBody(edgeLoopFrom: self.frame.insetBy(dx: CGFloat(30), dy: CGFloat(70)))
        sceneBody.friction = 0.9
        self.physicsBody = sceneBody
        
        // Making background
        let background = SKSpriteNode(imageNamed: "fortuneCookieBackground")
        background.position = CGPoint(x: self.size.height*0, y: self.frame.width*0)
        background.size = CGSize(width: self.frame.size.width*2.3, height: self.frame.size.height)
        background.zPosition = -1
        self.addChild(background)
        
        // Making score label
        let scoreLabelNode = SKLabelNode(fontNamed: "Futura")
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
        karateKidNode.size = CGSize(width: 180, height: 180)
        karateKidNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        karateKidNode.position = CGPoint(x: self.frame.size.width*(-0.4), y: self.frame.size.height*(-0.4))
        karateKidNode.zPosition = 100
        karateKidNode.name = "karateKid"
        self.addChild(karateKidNode)
        karateKidNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 150, height: 150))
        
        // Making platform
        platformNode = SKSpriteNode(imageNamed: "platform")
        platformNode.size = CGSize(width: 100, height: 15)
        platformNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        platformNode.position = CGPoint(x: 0, y: 0)
        platformNode.zPosition = 99
        platformNode.name = "platform"
        self.addChild(platformNode)
        
        let platformBody = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        platformNode.physicsBody = SKPhysicsBody(edgeLoopFrom: platformBody)
        
//        platformNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 15))
//        platformNode.physicsBody?.affectedByGravity = false
        
    }
    
    func updateScore(){
        
        scoreNode.text = String(score)
        
    }
    
    // When screen is touched...
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        // Count touches
        score = score + 1
        updateScore()
        
        // Track touch location
        let touchLocation = touch.location(in: self)
        
        // Create value for distance from character to touch
        let dX = touchLocation.x - karateKidNode.position.x
        let dY = touchLocation.y - karateKidNode.position.y
        
        // Apply an impulse in direction towards touch
        if let body = karateKidNode.physicsBody {
            body.applyImpulse(CGVector(dx: (dX), dy: (dY)*1.9))
        }
    }
    
    // Testing to make sure touch is registered (noticed)
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("test")
        print(score)
    }
}
