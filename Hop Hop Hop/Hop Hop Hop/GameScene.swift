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
    
    override func didMove(to view: SKView) {
        
        let scoreLabelNode = SKLabelNode(fontNamed: "Futura")
        scoreLabelNode.text = "SCORE"
        scoreLabelNode.fontSize = 40
        scoreLabelNode.fontColor = SKColor.white
        scoreLabelNode.position = CGPoint(x: self.frame.size.width*0, y: self.frame.size.height*0.4)
        self.addChild(scoreLabelNode)
        
        let karateKidNode = SKSpriteNode(imageNamed: "karateKid")
        karateKidNode.size = CGSize(width: 180, height: 180)
        karateKidNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        karateKidNode.position = CGPoint(x: self.frame.size.width*0, y: self.frame.size.height*(-0.4))
        karateKidNode.zPosition = 100
        karateKidNode.name = "karateKid"
        self.addChild(karateKidNode)
            }
    }
