//
//  InitialScene.swift
//  Hop Hop Hop
//
//  Created by Scott Blackwell on 2017-03-03.
//  Copyright © 2017 Scott Blackwell. All rights reserved.
//

import SpriteKit
import Foundation

class InitialScene: SKScene {
    
    override func didMove(to view: SKView) {
    
        let background = SKSpriteNode(imageNamed: "fortuneCookieBackground")
        background.position = CGPoint(x: self.size.height*0, y: self.frame.width*0)
        background.size = CGSize(width: self.frame.size.width*2.3, height: self.frame.size.height)
        self.addChild(background)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let myScene = GameScene(size: self.size)
        myScene.scaleMode = scaleMode
        let reveal = SKTransition.crossFade(withDuration: 1)
        self.view?.presentScene(myScene, transition: reveal)
        
        print("test")
    }
    
}
