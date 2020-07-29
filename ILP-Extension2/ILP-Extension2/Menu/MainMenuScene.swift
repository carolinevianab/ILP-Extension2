//
//  MainMenuScene.swift
//  ILP-Extension2
//
//  Created by Caroline Viana on 28/07/20.
//  Copyright © 2020 Caroline Viana. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {
    let defalts = UserDefaults.standard
    
    var bntStart: SKLabelNode!
    var bntButton: SKSpriteNode!
    var score: SKLabelNode!
    var touchLocal = CGPoint(x: 0, y: 0)
    
    override func didMove(to view: SKView) {
        bntStart = (self.childNode(withName: "StartGame") as! SKLabelNode)
        score = (self.childNode(withName: "Score") as! SKLabelNode)
        bntButton = (self.childNode(withName: "bntStartGame") as! SKSpriteNode)
        
        score.text = "Last Score: " + String(defalts.integer(forKey: "Score"))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        touchLocal = touch.location(in: self)
        
        if bntStart.contains(touchLocal) || bntButton.contains(touchLocal) {
            let transition = SKTransition.flipHorizontal(withDuration: 0.5)
            let intoGame = GameScene(fileNamed: "GameScene") ?? GameScene(size: self.size)
            self.view?.presentScene(intoGame, transition: transition)
        }
    }
}
