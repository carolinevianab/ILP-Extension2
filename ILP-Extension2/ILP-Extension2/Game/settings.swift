//
//  settings.swift
//  ILP-Extension2
//
//  Created by Caroline Viana on 29/07/20.
//  Copyright © 2020 Caroline Viana. All rights reserved.
//

import SpriteKit

extension SKScene {
    enum Zpositions: CGFloat {
        case background = 0
        case hangStuff = 1
        case gameArea = 2
        case labels = 4
    }
    
    struct wordlist {
        var word: String
        var letterNumber: Int
    }
    
    enum CollisionType: UInt32{
        case ground = 1
        case pinclet = 2
        case box = 4
    }
}
