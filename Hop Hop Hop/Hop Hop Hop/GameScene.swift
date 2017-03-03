//
//  GameScene.swift
//  Hop Hop Hop
//
//  Created by Scott Blackwell on 2017-02-13.
//  Copyright © 2017 Scott Blackwell. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // Variables
    var karateKidNode = SKSpriteNode()
    var actionJumpUp = SKAction()
    var actionJumpDown = SKAction()
    var actionJumpSequence = SKAction()
    
    //Initial functions
    override func didMove(to view: SKView) {
        
        // Creating physics effects
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
        
        // Creating physics boundries
        let sceneBody = SKPhysicsBody(edgeLoopFrom: self.frame.insetBy(dx: CGFloat(0), dy: CGFloat(80)))
        sceneBody.friction = 0
        self.physicsBody = sceneBody
        
        // Making background
        let background = SKSpriteNode(imageNamed: "fortuneCookieBackground")
        background.position = CGPoint(x: self.size.height*0, y: self.frame.width*0)
        background.size = CGSize(width: self.frame.size.width*2.3, height: self.frame.size.height)
        self.addChild(background)
        
        //Making score label
        let scoreLabelNode = SKLabelNode(fontNamed: "Futura")
        scoreLabelNode.text = "SCORE"
        scoreLabelNode.fontSize = 60
        scoreLabelNode.fontColor = SKColor.white
        scoreLabelNode.position = CGPoint(x: self.frame.size.width*0, y: self.frame.size.height*0.4)
        self.addChild(scoreLabelNode)
        
        // Making game character
        karateKidNode = SKSpriteNode(imageNamed: "karateKid")
        karateKidNode.size = CGSize(width: 180, height: 180)
        karateKidNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        karateKidNode.position = CGPoint(x: self.frame.size.width*(-0.4), y: self.frame.size.height*(-0.4))
        karateKidNode.zPosition = 100
        karateKidNode.name = "karateKid"
        self.addChild(karateKidNode)
        karateKidNode.physicsBody = SKPhysicsBody(circleOfRadius: CGFloat(10))

        
    }
    
    // When screen is touched...
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //karateKidNode.run(actionJumpSequence)
        if let body = karateKidNode.physicsBody {
            body.applyImpulse(CGVector(dx: 0, dy: 10))
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("test")
    }
}
