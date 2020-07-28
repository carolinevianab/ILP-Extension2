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
    let defalts = UserDefaults.standard
    
    var backgroundScene: SKSpriteNode!
    var lblword: SKLabelNode!
    var hangman: SKSpriteNode!
    let pinclet = SKSpriteNode(imageNamed: "pinclet")
    var score = 0
    
    var lblbnt1: SKLabelNode!
    var lblbnt2: SKLabelNode!
    var lblbnt3: SKLabelNode!
    var lblbnt4: SKLabelNode!
    var lblbnt5: SKLabelNode!
    var lblbnt6: SKLabelNode!
    var lblScore: SKLabelNode!
    
    var bnt1: SKSpriteNode!
    var bnt2: SKSpriteNode!
    var bnt3: SKSpriteNode!
    var bnt4: SKSpriteNode!
    var bnt5: SKSpriteNode!
    var bnt6: SKSpriteNode!
    
    var touchLocal = CGPoint(x: 0, y: 0)

    var data: [wordlist]!
    var choice: Int!
    var guessedLetters: [String] = []
    let states = [SKTexture(imageNamed: "0"), SKTexture(imageNamed: "1"), SKTexture(imageNamed: "2"), SKTexture(imageNamed: "3"), SKTexture(imageNamed: "4"), SKTexture(imageNamed: "5"), SKTexture(imageNamed: "6")]
    var hangState = 0

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
        lblScore = (self.childNode(withName: "lblScore") as! SKLabelNode)
        
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
        lblword.text?.removeAll()
        let b = data.count
        choice = Int.random(in: 0...(b - 1))
        
        let a = data[choice].letterNumber
        
        var i = 0
        var position = CGPoint(x: -369, y: 81)
        var h = data[choice].word.startIndex
        while i < a {
            //lblword.text?.append("_ ")
            i+=1
            
            let label = SKLabelNode(text: "_ ")
            label.position = position
            label.zPosition = 100
            label.fontSize = 77
            label.name = String(data[choice].word[h])
            addChild(label)
            position = CGPoint(x: position.x + 50, y: position.y)
            h = data[choice].word.index(after: h)
        }
        
//        var usedLetters: [Int] = []
//        var allRight = false
//
//        var random: Int!
//        while !allRight {
//            random = Int.random(in: 65...90)
//            if usedLetters.contains(random) || guessedLetters.contains(String(UnicodeScalar(random)!)){
//                continue
//            }
//
//            else {
//                if lblbnt1.text == "." {
//                    lblbnt1.text = String(UnicodeScalar(random)!)
//                    usedLetters.append(random)
//                }
//                else if lblbnt2.text == "." {
//                    lblbnt2.text = String(UnicodeScalar(random)!)
//                    usedLetters.append(random)
//                }
//                else if lblbnt3.text == "." {
//                    lblbnt3.text = String(UnicodeScalar(random)!)
//                    usedLetters.append(random)
//                }
//                else if lblbnt4.text == "." {
//                    lblbnt4.text = String(UnicodeScalar(random)!)
//                    usedLetters.append(random)
//                }
//                else if lblbnt5.text == "." {
//                    lblbnt5.text = String(UnicodeScalar(random)!)
//                    usedLetters.append(random)
//                }
//                else if lblbnt6.text == "." {
//                    lblbnt6.text = String(UnicodeScalar(random)!)
//                    usedLetters.append(random)
//                }
//                else {
//                    allRight = true
//                }
//            }
//        }
        
        logistics()
        
        
    }
    
    
    //MARK: ChangeChoices
    func changeChoices(){
        lblbnt1.text = "."
        lblbnt2.text = "."
        lblbnt3.text = "."
        lblbnt4.text = "."
        lblbnt5.text = "."
        lblbnt6.text = "."
        
//        var usedLetters: [Int] = []
//        var allRight = false
//
//        var random: Int!
//        var wordDoesHave = false
//        while !allRight {
//            random = Int.random(in: 65...90)
//            if usedLetters.contains(random) || guessedLetters.contains(String(UnicodeScalar(random)!)){
//                continue
//            }
//
//            else {
//                if lblbnt1.text == "." {
//                    lblbnt1.text = String(UnicodeScalar(random)!)
//                    usedLetters.append(random)
//                    if data[choice].word.contains(lblbnt1.text! as String){
//                        wordDoesHave = true
//                    }
//                }
//                else if lblbnt2.text == "." {
//                    lblbnt2.text = String(UnicodeScalar(random)!)
//                    usedLetters.append(random)
//                    if data[choice].word.contains(lblbnt2.text! as String){
//                        wordDoesHave = true
//                    }
//                }
//                else if lblbnt3.text == "." {
//                    lblbnt3.text = String(UnicodeScalar(random)!)
//                    usedLetters.append(random)
//                    if data[choice].word.contains(lblbnt3.text! as String){
//                        wordDoesHave = true
//                    }
//                }
//                else if lblbnt4.text == "." {
//                    lblbnt4.text = String(UnicodeScalar(random)!)
//                    usedLetters.append(random)
//                    if data[choice].word.contains(lblbnt4.text! as String){
//                        wordDoesHave = true
//                    }
//                }
//                else if lblbnt5.text == "." {
//                    lblbnt5.text = String(UnicodeScalar(random)!)
//                    usedLetters.append(random)
//                    if data[choice].word.contains(lblbnt5.text! as String){
//                        wordDoesHave = true
//                    }
//                }
//                else if lblbnt6.text == "." {
//                    lblbnt6.text = String(UnicodeScalar(random)!)
//                    usedLetters.append(random)
//                    if data[choice].word.contains(lblbnt6.text! as String){
//                        wordDoesHave = true
//                    }
//                }
//                else {
//                    allRight = true
//                }
//                if !wordDoesHave && (lblbnt1.text != "." && lblbnt2.text != "." && lblbnt3.text != "." && lblbnt4.text != "." && lblbnt5.text != "." && lblbnt6.text != "."){
//                    let a = data[choice].word.randomElement()
//                    let batata = Int.random(in: 1...6)
//                    switch batata {
//                    case 1:
//                        lblbnt1.text = String(a!)
//                        break
//                    case 2:
//                        lblbnt2.text = String(a!)
//                        break
//                    case 3:
//                        lblbnt3.text = String(a!)
//                        break
//                    case 4:
//                        lblbnt4.text = String(a!)
//                        break
//                    case 5:
//                        lblbnt5.text = String(a!)
//                        break
//                    case 6:
//                        lblbnt6.text = String(a!)
//                        break
//                    default:
//                        break
//                    }
//                    guessedLetters.append(String(a!))
//                }
//            }
//        }
        logistics()
    }
    
    func logistics(){
        var usedLetters: [Int] = []
        var allRight = false
        
        var random: Int!
        var wordDoesHave = false
        while !allRight {
            random = Int.random(in: 65...90)
            if usedLetters.contains(random) || guessedLetters.contains(String(UnicodeScalar(random)!)){
                continue
            }
            else if  !usedLetters.contains(random) || !guessedLetters.contains(String(UnicodeScalar(random)!)) {
                if lblbnt1.text == "." {
                    lblbnt1.text = String(UnicodeScalar(random)!)
                    usedLetters.append(random)
                    if data[choice].word.contains(lblbnt1.text! as String){
                        wordDoesHave = true
                    }
                }
                else if lblbnt2.text == "." {
                    lblbnt2.text = String(UnicodeScalar(random)!)
                    usedLetters.append(random)
                    if data[choice].word.contains(lblbnt2.text! as String){
                        wordDoesHave = true
                    }
                }
                else if lblbnt3.text == "." {
                    lblbnt3.text = String(UnicodeScalar(random)!)
                    usedLetters.append(random)
                    if data[choice].word.contains(lblbnt3.text! as String){
                        wordDoesHave = true
                    }
                }
                else if lblbnt4.text == "." {
                    lblbnt4.text = String(UnicodeScalar(random)!)
                    usedLetters.append(random)
                    if data[choice].word.contains(lblbnt4.text! as String){
                        wordDoesHave = true
                    }
                }
                else if lblbnt5.text == "." {
                    lblbnt5.text = String(UnicodeScalar(random)!)
                    usedLetters.append(random)
                    if data[choice].word.contains(lblbnt5.text! as String){
                        wordDoesHave = true
                    }
                }
                else if lblbnt6.text == "." {
                    lblbnt6.text = String(UnicodeScalar(random)!)
                    usedLetters.append(random)
                    if data[choice].word.contains(lblbnt6.text! as String){
                        wordDoesHave = true
                    }
                }
                else {
                    allRight = true
                }
                while !wordDoesHave && (lblbnt1.text != "." && lblbnt2.text != "." && lblbnt3.text != "." && lblbnt4.text != "." && lblbnt5.text != "." && lblbnt6.text != "."){
                    let a = data[choice].word.randomElement()
                    let batata = Int.random(in: 1...6)
                    
                    if !guessedLetters.contains(String(a!)) {
                        switch batata {
                        case 1:
                            lblbnt1.text = String(a!)
                            break
                        case 2:
                            lblbnt2.text = String(a!)
                            break
                        case 3:
                            lblbnt3.text = String(a!)
                            break
                        case 4:
                            lblbnt4.text = String(a!)
                            break
                        case 5:
                            lblbnt5.text = String(a!)
                            break
                        case 6:
                            lblbnt6.text = String(a!)
                            break
                        default:
                            break
                        }
                        wordDoesHave = true
                    }
                
                    allRight = true
                }
            }
        }
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
        lblScore.text = "Score: " + String(score)
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
        
        if secondNode.name == "pinclet"{
            switch firstNode.name {
            case "bnt1":
                doShit(lblbnt1)
//                guessedLetters.append(lblbnt1.text!)
//                changeChoices()
                break
            case "bnt2":
                doShit(lblbnt2)
//                guessedLetters.append(lblbnt2.text!)
//                changeChoices()
                break
            case "bnt3":
                doShit(lblbnt3)
//                guessedLetters.append(lblbnt3.text!)
//                changeChoices()
                break
            case "bnt4":
                doShit(lblbnt4)
//                guessedLetters.append(lblbnt4.text!)
//                changeChoices()
                break
            case "bnt5":
                doShit(lblbnt5)
//                guessedLetters.append(lblbnt5.text!)
//                changeChoices()
                break
            case "bnt6":
                doShit(lblbnt6)
//                guessedLetters.append(lblbnt6.text!)
//                changeChoices()
                break
            default:
                break
            }
            
        }
        
    }
    
    func doShit(_ contacted: SKLabelNode){
        if data[choice].word.contains((contacted.text?.first)!) {
            print("vai filhao")
            let str = contacted.text! as String
            while childNode(withName: str) != nil {
                let label = childNode(withName: str) as! SKLabelNode
                label.text = str + " "
                label.name = "0"
                score += 5
            }
            
            var i = 0
            var cor = 0
            let t = children
            while i < t.count {
                
                if t[i].name == "0" {
                    cor += 1
                }
                i += 1
            }
            
            if data[choice].letterNumber == cor {
                let label = SKLabelNode(text: "you win")
                label.position = CGPoint(x: 0, y: 0)
                label.zPosition = 100
                label.fontSize = 100
                label.name = "winner"
                removeAllChildren()
                
                defalts.set(score, forKey: "Score")
                score += 10
                
                let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                let intoGame = GameScene(fileNamed: "MainMenuScene") ?? GameScene(size: self.size)
                intoGame.addChild(label)
                self.view?.presentScene(intoGame, transition: transition)
            }
            else {
                guessedLetters.append(contacted.text!)
                changeChoices()
            }
        }
        else{
            print("are ya winning son")
            hangState += 1
            hangman.texture = states[hangState]
            score -= 7
            
            if hangState == 6 {
                let label = SKLabelNode(text: "you lost")
                label.position = CGPoint(x: 0, y: 0)
                label.zPosition = 100
                label.fontSize = 100
                label.name = "loser"
                removeAllChildren()
                defalts.set(score, forKey: "Score")
                let transition = SKTransition.flipHorizontal(withDuration: 0.5)
                let intoGame = GameScene(fileNamed: "MainMenuScene") ?? GameScene(size: self.size)
                intoGame.addChild(label)
                self.view?.presentScene(intoGame, transition: transition)
                
                
            }
            else{
                guessedLetters.append(contacted.text!)
                changeChoices()
            }
            
        }
        //guessedLetters.append(contacted.text!)
        
    }
}
