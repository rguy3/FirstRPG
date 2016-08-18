//
//  Character.swift
//  RPG2-OOP
//
//  Created by Richard Guy on 8/17/16.
//  Copyright © 2016 Richard Guy. All rights reserved.
//

import Foundation

class Character {
    
    private var _name: String = "Character"
    private var _hp: Int = 120
    private var _atk: Int = 10

    
    var name: String {
        get {
            return _name
        }
    }
    
    var hp: Int {
        get {
            return _hp
        }
    }
    
    var atk: Int {
        get {
            return _atk
        }
    }
    
    var isDead: Bool {
        if hp <= 0 {
            return true
        } else {
            return false
        }
    }
    
    init(startName: String, startHp: Int, startAtk: Int) {
        self._name = startName
        self._hp = startHp
        self._atk = startAtk
    }
    
    func receivedAttack(startAtk: Int) -> Bool {
        
            self._hp -= startAtk
            return true

}

}