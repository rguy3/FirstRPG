//
//  ViewController.swift
//  RPG2-OOP
//
//  Created by Richard Guy on 8/17/16.
//  Copyright © 2016 Richard Guy. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var playerLbl: UILabel!
    @IBOutlet weak var enemyLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var playerOneHp: UILabel!
    @IBOutlet weak var playerTwoHp: UILabel!
    @IBOutlet weak var playerBtn: UIButton!
    @IBOutlet weak var enemyBtn: UIButton!
    @IBOutlet weak var restartBtn: UIButton!
    @IBOutlet weak var spartanImg: UIImageView!
    @IBOutlet weak var trollImg: UIImageView!
    
    var swordSound: AVAudioPlayer! //Creates a variable thats going to hold a sound
    var maceSound: AVAudioPlayer!
    
    var playerOne: Character! //Create two players with the Character Class
    var playerTwo: Character!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let sword = NSBundle.mainBundle().pathForResource("sword", ofType: "wav") //Pulls sounds from file
        let mace = NSBundle.mainBundle().pathForResource("mace", ofType: "wav")
        
        let swordURL = NSURL(fileURLWithPath: sword!) //Gives sounds a URL
        let maceURL = NSURL(fileURLWithPath: mace!)
        
        do {
            try swordSound = AVAudioPlayer(contentsOfURL: swordURL) //Gives variable the sound URL
            try maceSound = AVAudioPlayer(contentsOfURL: maceURL)
            maceSound.prepareToPlay() //Prep to call it
            swordSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        setChars() //Sets the stage of the characters (needed to create own function for Restart
    }
    
    func setChars() { //Starting variables of both players
        playerOne = Character(startName: "Spartan", startHp: 120, startAtk: 5)
        playerOneHp.text = "\(playerOne.hp) HP"
        
        playerTwo = Character(startName: "Troll Master", startHp: 120, startAtk: 5)
        playerTwoHp.text = "\(playerTwo.hp) HP"
    }
    
    func showHidePlayerButton() { //Function to call out buttons after timer
        playerBtn.hidden = false
        playerLbl.text = "ATTACK"
    }
    
    func showHideEnemyButton() {
        enemyBtn.hidden = false
        enemyLbl.text = "ATTACK"
    }

    
    
    @IBAction func playerAttackPressed(sender: AnyObject) {
        
        swordSound.play()
        playerHit(playerTwo, attack: playerOne)
        playerTwoHp.text = "\(playerTwo.hp) HP"
        playerBtn.hidden = true
        playerLbl.text = "WAIT"
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(showHidePlayerButton), userInfo: nil, repeats: false)
    }
    
    @IBAction func enemyAttackPressed(sender: AnyObject) {
        
        maceSound.play()
        playerHit(playerOne, attack: playerTwo)
        playerOneHp.text = "\(playerOne.hp) HP"
        enemyBtn.hidden = true
        enemyLbl.text = "WAIT"
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(showHideEnemyButton), userInfo: nil, repeats: false)
    }
    
    @IBAction func restartPressed(sender: AnyObject) {
        aGame(false)
        statusLbl.text = "Fight!"
    }
    
    func playerHit(defend: Character, attack: Character) { //Function for when player attacks other player
        let randhit = Int(arc4random_uniform(2)) //50% chance of missing
        
        if randhit == 1 { //If hit was successful
            defend.receivedAttack(attack.atk) //Defender's HP gets deducted by other player's attack power
            statusLbl.text = "\(attack.name) striked with +\(attack.atk)!"
        } else { //If hit was a miss
            defend.receivedAttack(0) //Defender's HP gets deducted by nothing
            statusLbl.text = "\(attack.name) has missed an attack!"
        }
        
        if defend.isDead == true { //If the strike kills the defender
            aGame(true)
            statusLbl.text = "\(attack.name) has won the match!"
        }
    }
    
    func aGame(new: Bool) { //Function if game is over or needs to reset. Returns a bool
        playerBtn.hidden = new
        playerLbl.hidden = new
        enemyBtn.hidden = new
        enemyLbl.hidden = new
        spartanImg.hidden = new
        trollImg.hidden = new

        setChars() //Resets characters
        
        if new == true {
            restartBtn.hidden = false
        } else {
            restartBtn.hidden = true
        }
    }
    
    
    

}

