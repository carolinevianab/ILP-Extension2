//
//  GameScene.swift
//  ILP-Extension2
//
//  Created by Caroline Viana on 27/07/20.
//  Copyright © 2020 Caroline Viana. All rights reserved.
//

import SpriteKit

enum CollisionType: UInt32{
    case ground = 1
    case pinclet = 2
    case box = 4
}

struct wordlist {
    var word: String
    var letterNumber: Int
}


class GameScene: SKScene, SKPhysicsContactDelegate {
    
//    let alfabeto = [1: "a",
//                    2: "b",
//                    2: "b",
//                     2: "b",
//                     2: "b",
//                     2: "b",
//                     2: "b",
//                     2: "b",
//                     2: "b",
//                     2: "b",
//                     2: "b",
//                     2: "b",
//                     2: "b",
//                     2: "b",
//                     2: "b",
//                     2: "b",
//                     2: "b",
//                     2: "b",
//                     2: "b",
//                     2: "b",
//    ]
    
    var backgroundScene: SKSpriteNode!
    var lblword: SKLabelNode!
    var hangman: SKSpriteNode!
    let pinclet = SKSpriteNode(imageNamed: "pinclet")
    
    var lblbnt1: SKLabelNode!
    var lblbnt2: SKLabelNode!
    var lblbnt3: SKLabelNode!
    var lblbnt4: SKLabelNode!
    var lblbnt5: SKLabelNode!
    var lblbnt6: SKLabelNode!
    
    var bnt1: SKSpriteNode!
    var bnt2: SKSpriteNode!
    var bnt3: SKSpriteNode!
    var bnt4: SKSpriteNode!
    var bnt5: SKSpriteNode!
    var bnt6: SKSpriteNode!
    
    var touchLocal = CGPoint(x: 0, y: 0)

    var data: [wordlist]!
    var choice: Int!

    // MARK: didMove
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        
        backgroundScene = (self.childNode(withName: "background") as! SKSpriteNode)
        lblword = (self.childNode(withName: "word") as! SKLabelNode)
        hangman = (self.childNode(withName: "hangman") as! SKSpriteNode)
        lblbnt1 = (self.childNode(withName: "lblbnt1") as! SKLabelNode)
        lblbnt2 = (self.childNode(withName: "lblbnt2") as! SKLabelNode)
        lblbnt3 = (self.childNode(withName: "lblbnt3") as! SKLabelNode)
        lblbnt4 = (self.childNode(withName: "lblbnt4") as! SKLabelNode)
        lblbnt5 = (self.childNode(withName: "lblbnt5") as! SKLabelNode)
        lblbnt6 = (self.childNode(withName: "lblbnt6") as! SKLabelNode)
        
        bnt1 = (self.childNode(withName: "bnt1") as! SKSpriteNode)
        bnt2 = (self.childNode(withName: "bnt2") as! SKSpriteNode)
        bnt3 = (self.childNode(withName: "bnt3") as! SKSpriteNode)
        bnt4 = (self.childNode(withName: "bnt4") as! SKSpriteNode)
        bnt5 = (self.childNode(withName: "bnt5") as! SKSpriteNode)
        bnt6 = (self.childNode(withName: "bnt6") as! SKSpriteNode)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame.inset(by: UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)))
        
        pinclet.size = CGSize(width: pinclet.size.width / 1.5, height: pinclet.size.height / 1.5)
        pinclet.position = CGPoint(x: 0, y: 0)
        pinclet.zPosition = 3
        pinclet.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: pinclet.size.width / 2, height: pinclet.size.height / 1.2))
        pinclet.physicsBody?.categoryBitMask = CollisionType.pinclet.rawValue
        pinclet.physicsBody?.collisionBitMask = CollisionType.box.rawValue
        pinclet.physicsBody?.contactTestBitMask = CollisionType.box.rawValue
        pinclet.physicsBody?.allowsRotation = false
        pinclet.name = "pinclet"
        pinclet.physicsBody?.mass = 1
        pinclet.physicsBody?.friction = 0.1
        addChild(pinclet)
        
        
         data = [wordlist(word: "BATATA", letterNumber: 6),
                 wordlist(word: "CENOURA", letterNumber: 7)
        ]
        
        setPhysics()
        
        setupGame()

       
        
    }
    
    //MARK: setPhysics
    func setPhysics(){
        bnt1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: bnt1.size.width, height: bnt1.size.height))
        bnt1.physicsBody?.categoryBitMask = CollisionType.box.rawValue
        bnt1.physicsBody?.collisionBitMask = CollisionType.pinclet.rawValue
        bnt1.physicsBody?.contactTestBitMask = CollisionType.pinclet.rawValue
        bnt1.physicsBody?.affectedByGravity = false
        bnt1.physicsBody?.isDynamic = false
        
        bnt2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: bnt1.size.width, height: bnt1.size.height))
        bnt2.physicsBody?.categoryBitMask = CollisionType.box.rawValue
        bnt2.physicsBody?.collisionBitMask = CollisionType.pinclet.rawValue
        bnt2.physicsBody?.contactTestBitMask = CollisionType.pinclet.rawValue
        bnt2.physicsBody?.affectedByGravity = false
        bnt2.physicsBody?.isDynamic = false
        
        bnt3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: bnt1.size.width, height: bnt1.size.height))
        bnt3.physicsBody?.categoryBitMask = CollisionType.box.rawValue
        bnt3.physicsBody?.collisionBitMask = CollisionType.pinclet.rawValue
        bnt3.physicsBody?.contactTestBitMask = CollisionType.pinclet.rawValue
        bnt3.physicsBody?.affectedByGravity = false
        bnt3.physicsBody?.isDynamic = false
        
        bnt4.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: bnt1.size.width, height: bnt1.size.height))
        bnt4.physicsBody?.categoryBitMask = CollisionType.box.rawValue
        bnt4.physicsBody?.collisionBitMask = CollisionType.pinclet.rawValue
        bnt4.physicsBody?.contactTestBitMask = CollisionType.pinclet.rawValue
        bnt4.physicsBody?.affectedByGravity = false
        bnt4.physicsBody?.isDynamic = false
        
        bnt5.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: bnt1.size.width, height: bnt1.size.height))
        bnt5.physicsBody?.categoryBitMask = CollisionType.box.rawValue
        bnt5.physicsBody?.collisionBitMask = CollisionType.pinclet.rawValue
        bnt5.physicsBody?.contactTestBitMask = CollisionType.pinclet.rawValue
        bnt5.physicsBody?.affectedByGravity = false
        bnt5.physicsBody?.isDynamic = false
        
        bnt6.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: bnt1.size.width, height: bnt1.size.height))
        bnt6.physicsBody?.categoryBitMask = CollisionType.box.rawValue
        bnt6.physicsBody?.collisionBitMask = CollisionType.pinclet.rawValue
        bnt6.physicsBody?.contactTestBitMask = CollisionType.pinclet.rawValue
        bnt6.physicsBody?.affectedByGravity = false
        bnt6.physicsBody?.isDynamic = false
    }
    
    // MARK: setupGame
    func setupGame(){
        lblword.text = ""
        let b = data.count
        choice = Int.random(in: 0...(b - 1))
        
        let a = data[choice].letterNumber
        
        var i = 0
        while i < a {
            lblword.text?.append("c")
            i+=1
        }
        
        lblbnt1.text = String(UnicodeScalar(Int.random(in: 65...90))!)
    }
    
    // MARK: touchesEnded
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchLocal = CGPoint(x: 0, y: 0)
    }
    
    
    // MARK: touchesBegan
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        touchLocal = touch.location(in: self)
        
        let const: CGFloat = 150
        
        if lblbnt1.contains(touchLocal) || bnt1.contains(touchLocal){
            let duration = abs(Double((lblbnt1.position.x - pinclet.position.x) / const))
            let run = SKAction.move(to: CGPoint(x: lblbnt1.position.x, y: pinclet.position.y), duration: duration)
            let jump = SKAction.applyImpulse(CGVector(dx: 0, dy: 600), duration: 0.1)
            pinclet.run(SKAction.sequence([run, jump]))
            
        }
        if lblbnt2.contains(touchLocal) || bnt2.contains(touchLocal){
            let duration = abs(Double((lblbnt2.position.x - pinclet.position.x) / const))
            let run = SKAction.move(to: CGPoint(x: lblbnt2.position.x, y: pinclet.position.y), duration: duration)
            let jump = SKAction.applyImpulse(CGVector(dx: 0, dy: 600), duration: 0.1)
            pinclet.run(SKAction.sequence([run, jump]))
        }
        if lblbnt3.contains(touchLocal) || bnt3.contains(touchLocal){
            let duration = abs(Double((lblbnt3.position.x - pinclet.position.x) / const))
            let run = SKAction.move(to: CGPoint(x: lblbnt3.position.x, y: pinclet.position.y), duration: duration)
            let jump = SKAction.applyImpulse(CGVector(dx: 0, dy: 600), duration: 0.1)
            pinclet.run(SKAction.sequence([run, jump]))
        }
        if lblbnt4.contains(touchLocal) || bnt4.contains(touchLocal){
            let duration = abs(Double((lblbnt4.position.x - pinclet.position.x) / const))
            let run = SKAction.move(to: CGPoint(x: lblbnt4.position.x, y: pinclet.position.y), duration: duration)
            let jump = SKAction.applyImpulse(CGVector(dx: 0, dy: 600), duration: 0.1)
            pinclet.run(SKAction.sequence([run, jump]))
        }
        if lblbnt5.contains(touchLocal) || bnt5.contains(touchLocal){
            let duration = abs(Double((lblbnt5.position.x - pinclet.position.x) / const))
            let run = SKAction.move(to: CGPoint(x: lblbnt5.position.x, y: pinclet.position.y), duration: duration)
            let jump = SKAction.applyImpulse(CGVector(dx: 0, dy: 600), duration: 0.1)
            pinclet.run(SKAction.sequence([run, jump]))
        }
        if lblbnt6.contains(touchLocal) || bnt6.contains(touchLocal){
            let duration = abs(Double((lblbnt6.position.x - pinclet.position.x) / const))
            let run = SKAction.move(to: CGPoint(x: lblbnt6.position.x, y: pinclet.position.y), duration: duration)
            let jump = SKAction.applyImpulse(CGVector(dx: 0, dy: 600), duration: 0.1)
            pinclet.run(SKAction.sequence([run, jump]))
        }
    }
    
    
    // MARK: update
    override func update(_ currentTime: TimeInterval) {
    
    }
    
    // MARK: didBegin
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else {return}
        guard let nodeB = contact.bodyB.node else {return}
        
        let sortedNodes = [nodeA, nodeB].sorted {$0.name ?? "" <  $1.name ?? ""}
        // Ordem alfabética:
        //Scene (literally)
        //bnts
        //pinclet
        //
        
        let firstNode = sortedNodes[0]
        let secondNode = sortedNodes[1]
        
        //print(firstNode.name ?? "nope" as String, secondNode.name ?? "nope" as String)
        
        if secondNode.name == "pinclet"{
            switch firstNode.name {
            case "bnt1":
                if data[choice].word.contains((lblbnt1.text?.first)!) {
                    print("vai filhao")
//                    let str = lblbnt1.text! as String
//                    let h = lblword.text?.firstIndex(of: (lblbnt1.text?.first)!)
//                    let aaaaa = lblword.text?.replacingOccurrences(of: "c", with: str)
//                    lblword.text?.replaceSubrange(h!...h!, with: str)
//                    lblword.text = aaaaa
                }
                else{
                    print("are ya winning son")
                }
                
                
                break
            case "bnt2":
                print(lblbnt2.text! as String)
                break
            case "bnt3":
                print(lblbnt3.text! as String)
                break
            case "bnt4":
                print(lblbnt4.text! as String)
                break
            case "bnt5":
                print(lblbnt5.text! as String)
                break
            case "bnt6":
                print(lblbnt6.text! as String)
                break
            default:
                break
            }
        }
        
    }
}
