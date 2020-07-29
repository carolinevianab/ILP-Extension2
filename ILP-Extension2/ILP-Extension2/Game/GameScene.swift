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
    
    // Sprites
    var backgroundScene: SKSpriteNode!
    var hangman: SKSpriteNode!
    let pinclet = SKSpriteNode(imageNamed: "pinclet")
    let exitPortal = SKSpriteNode(imageNamed: "exitPortal")
    
    // labels
    var lblbnt1: SKLabelNode!
    var lblbnt2: SKLabelNode!
    var lblbnt3: SKLabelNode!
    var lblbnt4: SKLabelNode!
    var lblbnt5: SKLabelNode!
    var lblbnt6: SKLabelNode!
    var lblScore: SKLabelNode!
    var lblGuessed: SKLabelNode!
    
    // buttons
    var bnt1: SKSpriteNode!
    var bnt2: SKSpriteNode!
    var bnt3: SKSpriteNode!
    var bnt4: SKSpriteNode!
    var bnt5: SKSpriteNode!
    var bnt6: SKSpriteNode!
    
    var touchLocal = CGPoint(x: 0, y: 0)
    var score = 0
    var data: [wordlist]!
    var choice: Int!
    var guessedLetters: [String] = []
    var hangState = 0
    var portal = false
    
    let states = [SKTexture(imageNamed: "0"), SKTexture(imageNamed: "1"), SKTexture(imageNamed: "2"), SKTexture(imageNamed: "3"), SKTexture(imageNamed: "4"), SKTexture(imageNamed: "5"), SKTexture(imageNamed: "6")]
    

    // MARK: didMove
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        
        backgroundScene = (self.childNode(withName: "background") as! SKSpriteNode)
        hangman = (self.childNode(withName: "hangman") as! SKSpriteNode)
        lblbnt1 = (self.childNode(withName: "lblbnt1") as! SKLabelNode)
        lblbnt2 = (self.childNode(withName: "lblbnt2") as! SKLabelNode)
        lblbnt3 = (self.childNode(withName: "lblbnt3") as! SKLabelNode)
        lblbnt4 = (self.childNode(withName: "lblbnt4") as! SKLabelNode)
        lblbnt5 = (self.childNode(withName: "lblbnt5") as! SKLabelNode)
        lblbnt6 = (self.childNode(withName: "lblbnt6") as! SKLabelNode)
        lblScore = (self.childNode(withName: "lblScore") as! SKLabelNode)
        lblGuessed = (self.childNode(withName: "letterGuessed") as! SKLabelNode)
        
        bnt1 = (self.childNode(withName: "bnt1") as! SKSpriteNode)
        bnt2 = (self.childNode(withName: "bnt2") as! SKSpriteNode)
        bnt3 = (self.childNode(withName: "bnt3") as! SKSpriteNode)
        bnt4 = (self.childNode(withName: "bnt4") as! SKSpriteNode)
        bnt5 = (self.childNode(withName: "bnt5") as! SKSpriteNode)
        bnt6 = (self.childNode(withName: "bnt6") as! SKSpriteNode)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame.inset(by: UIEdgeInsets(top: 30, left: 0, bottom: frame.minY - 150, right: 0)))
        
        pinclet.size = CGSize(width: pinclet.size.width / 1.5, height: pinclet.size.height / 1.5)
        pinclet.position = CGPoint(x: 0, y: -115)
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
        
        
         data = [wordlist(word: "APARTMENT", letterNumber: 9),//1
                 wordlist(word: "AIRPLANE", letterNumber: 8),//2
                 wordlist(word: "RESTAURANT", letterNumber: 10),//3
                 wordlist(word: "SCHOOL", letterNumber: 6),//4
                 wordlist(word: "LIBRARY", letterNumber: 7),//5
                 wordlist(word: "HOSPITAL", letterNumber: 8),//6
                 wordlist(word: "ORANGE", letterNumber: 6),//7
                 wordlist(word: "APPLE", letterNumber: 5),//8
                 wordlist(word: "LEMON", letterNumber: 5),//9
                 wordlist(word: "KNIFE", letterNumber: 5),//10
                 wordlist(word: "BREAKFAST", letterNumber: 9),//11
                 wordlist(word: "NEIGHBOR", letterNumber: 8),//12
                 wordlist(word: "BATHROOM", letterNumber: 8),//13
                 wordlist(word: "CEILING", letterNumber: 7),//14
                 wordlist(word: "TELEPHONE", letterNumber: 9),//15
                 wordlist(word: "NEEDLE", letterNumber: 6),//16
                 wordlist(word: "TELEVISION", letterNumber: 10),//17
                 wordlist(word: "SEPTEMBER", letterNumber: 9),//18
                 wordlist(word: "AWKWARD", letterNumber: 7),//19
                 wordlist(word: "CYCLE", letterNumber: 5),//20
                 wordlist(word: "GALAXY", letterNumber: 6),//21
                 wordlist(word: "MICROWAVE", letterNumber: 9),//22
                 wordlist(word: "KEYHOLE", letterNumber: 7),//23
                 wordlist(word: "AVENUE", letterNumber: 6),//24
                 wordlist(word: "FOX", letterNumber: 3),//25
                 wordlist(word: "PLAY", letterNumber: 4),//26
                 wordlist(word: "NOTEBOOK", letterNumber: 8),//27
                 wordlist(word: "PINEAPPLE", letterNumber: 9),//28
                 wordlist(word: "CAKE", letterNumber: 4),//29
                 wordlist(word: "TABLE", letterNumber: 5),//30
            
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
        let b = data.count
        choice = Int.random(in: 0...(b - 1))
        
        let a = data[choice].letterNumber
        
        var i = 0
        var position = CGPoint(x: -375, y: 81)
        var h = data[choice].word.startIndex
        while i < a {
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
        
        defineLetters()
        
    }
    
    
    //MARK: ChangeChoices
    func changeChoices(){
        lblbnt1.text = "."
        lblbnt2.text = "."
        lblbnt3.text = "."
        lblbnt4.text = "."
        lblbnt5.text = "."
        lblbnt6.text = "."
        
        defineLetters()
    }
    
    //MARK: defineLetters
    func defineLetters(){
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
        
        if lblbnt1.contains(touchLocal) || bnt1.contains(touchLocal){
            movePinclet(lblbnt1)
        }
        if lblbnt2.contains(touchLocal) || bnt2.contains(touchLocal){
            movePinclet(lblbnt2)
        }
        if lblbnt3.contains(touchLocal) || bnt3.contains(touchLocal){
            movePinclet(lblbnt3)
        }
        if lblbnt4.contains(touchLocal) || bnt4.contains(touchLocal){
            movePinclet(lblbnt4)
        }
        if lblbnt5.contains(touchLocal) || bnt5.contains(touchLocal){
            movePinclet(lblbnt5)
        }
        if lblbnt6.contains(touchLocal) || bnt6.contains(touchLocal){
            movePinclet(lblbnt6)
        }
        if exitPortal.contains(touchLocal){
            let duration = abs(Double((exitPortal.position.x - pinclet.position.x) / 170))
            let run = SKAction.move(to: CGPoint(x: exitPortal.position.x, y: pinclet.position.y), duration: duration)
            pinclet.run(run)
        }
    }
    
    // MARK: movePinclet
    func movePinclet(_ moveToLbl: SKLabelNode){
        let duration = abs(Double((moveToLbl.position.x - pinclet.position.x) / 170))
        let run = SKAction.move(to: CGPoint(x: moveToLbl.position.x, y: pinclet.position.y), duration: duration)
        let jump = SKAction.applyImpulse(CGVector(dx: 0, dy: 600), duration: 0.1)
        pinclet.run(SKAction.sequence([run, jump]))
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
        //bntX
        //lblbntX
        //pinclet
        
        let firstNode = sortedNodes[0]
        let secondNode = sortedNodes[1]
        
        if secondNode.name == "pinclet"{
            if !portal {
                switch firstNode.name {
                case "bnt1":
                    evaluate(lblbnt1)
                    break
                case "bnt2":
                    evaluate(lblbnt2)
                    break
                case "bnt3":
                    evaluate(lblbnt3)
                    break
                case "bnt4":
                    evaluate(lblbnt4)
                    break
                case "bnt5":
                    evaluate(lblbnt5)
                    break
                case "bnt6":
                    evaluate(lblbnt6)
                    break
                default:
                    break
                }
            }
            
            if firstNode.name == "exit" && hangState != 6 {
                endGame("You won!")
            }
            else if firstNode.name == "exit" && hangState == 6 {
                endGame("You lost")
            }
        }
        
    }
    
    //MARK: evaluate
    func evaluate(_ contacted: SKLabelNode){
        if data[choice].word.contains((contacted.text?.first)!) {
            let str = contacted.text! as String
            while childNode(withName: str) != nil {
                let label = childNode(withName: str) as! SKLabelNode
                label.text = str + " "
                label.name = "0"
                score += 5
            }
            
            var index = 0
            var guessed = 0
            let allChildren = children
            while index < allChildren.count {
                if allChildren[index].name == "0" {
                    guessed += 1
                }
                index += 1
            }
            if data[choice].letterNumber == guessed && !portal {
                score += 10
                generatePortal()
                
                
            }
            else {
                guessedLetters.append(contacted.text!)
                changeChoices()
            }
        }
        else {
            hangState += 1
            hangman.texture = states[hangState]
            hangman.color = .white
            hangman.blendMode = .add
            hangman.colorBlendFactor = 0.9
            score -= 7
            if hangState == 6 && !portal{
                guessWord()
                generatePortal()
            }
            else {
                guessedLetters.append(contacted.text!)
                lblGuessed.text?.append(contacted.text!)
                lblGuessed.text?.append(" ,")
                changeChoices()
            }
            
        }
        
    }
    
    func guessWord(){
        let wordUsed = data[choice].word
        var index = wordUsed.startIndex
        while index != wordUsed.endIndex {
            let str = String(wordUsed[index])
            while (childNode(withName: str) != nil) {
                let label = childNode(withName: str) as! SKLabelNode
                label.text = str + " "
                label.name = "0"
            }
            index = wordUsed.index(after: index)
        }
        
        let explanation = SKLabelNode(text: "The word was")
        explanation.position = CGPoint(x: -200, y: frame.maxY - 50)
        explanation.fontSize = 40
        explanation.zPosition = 100
        addChild(explanation)
        
    }
    
    func generatePortal(){
        exitPortal.size = CGSize(width: exitPortal.size.width * 1.5, height: exitPortal.size.height * 1.5)
        exitPortal.position = CGPoint(x: frame.midX - 5, y: frame.maxY + 150)
        exitPortal.zPosition = 100
        exitPortal.name = "exit"
        exitPortal.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 20, height: 50))
        exitPortal.physicsBody?.categoryBitMask = CollisionType.box.rawValue
        exitPortal.physicsBody?.collisionBitMask = CollisionType.pinclet.rawValue
        exitPortal.physicsBody?.contactTestBitMask = CollisionType.pinclet.rawValue
        exitPortal.physicsBody?.affectedByGravity = false
        addChild(exitPortal)
        exitPortal.run(SKAction.move(to: CGPoint(x: frame.midX - 5, y: frame.minY + exitPortal.frame.height / 2), duration: 3))
        portal = true
    }
    
    //MARK: endGame
    func endGame(_ GameStatus: String){
        let label = SKLabelNode(text: GameStatus)
        label.position = CGPoint(x: 200, y: -100)
        label.zPosition = 100
        label.fontSize = 100
        label.fontName = "Helvetica Neue"
        label.name = "State"
        removeAllChildren()
        defalts.set(score, forKey: "Score")
        let transition = SKTransition.flipHorizontal(withDuration: 0.5)
        let intoGame = GameScene(fileNamed: "MainMenuScene") ?? GameScene(size: self.size)
        intoGame.addChild(label)
        self.view?.presentScene(intoGame, transition: transition)
    }
}
