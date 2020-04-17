//
//  GameOverScreen.swift
//  Jetpack Joe
//
//  Created by Trystian Offerman on 22/05/2019.
//  Copyright © 2019 Trystian Offerman. All rights reserved.
//

import SpriteKit
import GameKit

class GameOverScreen : SKScene {
    var gameOverText = SKLabelNode(fontNamed: "BalooBhai-Regular")
    var scoreText = SKLabelNode(fontNamed: "BalooBhai-Regular")
    var highScoreLink = SKLabelNode(fontNamed: "BalooBhai-Regular")
    
    let selectedColor = UIColor(red:0.16, green:0.50, blue:0.73, alpha:1.00);
    let blueColor = UIColor(red:0.20, green:0.60, blue:0.86, alpha:1.00);
    let disabledColor = UIColor(red:0.50, green:0.55, blue:0.55, alpha:1.00);
    
    let jetpackJoeDeathTexture = SKTexture(imageNamed: "joe_death")
    var jetpackJoeDeath : SKSpriteNode! = nil
    
    override func sceneDidLoad() {
        
        SoundController.sharedInstance.playSound(scene: "gameover", index: 0);
 
        jetpackJoeDeath = SKSpriteNode(texture: jetpackJoeDeathTexture);
        jetpackJoeDeath.position = CGPoint(x: size.width / 2, y: size.height - 530)
        addChild(jetpackJoeDeath);

        backgroundColor = UIColor(red: 0.9255, green: 0.9412, blue: 0.9451, alpha: 1.0);
        gameOverText.text = "Game over";
        gameOverText.fontColor = SKColor(red:0.34, green:0.39, blue:0.47, alpha:1.0);
        gameOverText.position = CGPoint(x: size.width / 2, y: size.height - 80)
        gameOverText.fontSize = 40;
        addChild(gameOverText);
        
        let highscoreButton = FTButtonNode(normalColor: UIColor(red:0.17, green:0.24, blue:0.31, alpha:1.00), selectedColor: selectedColor, disabledColor: SKColor.gray)
        highscoreButton.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(GameOverScreen.showHighScores))
        highscoreButton.position = CGPoint(x: self.size.width / 2, y: self.size.height - 320)
        highscoreButton.setButtonLabel(title: "Show Highscores", font: "BalooBhai-Regular", fontSize: 30)
        highscoreButton.zPosition = 1
        highscoreButton.name = "highscore"
        addChild(highscoreButton);
        
        let menuButton = FTButtonNode(normalColor: blueColor, selectedColor: selectedColor, disabledColor: SKColor.gray)
       menuButton.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(GameOverScreen.backToMenu))
       menuButton.position = CGPoint(x: self.size.width / 2, y: self.size.height - 220)
       menuButton.setButtonLabel(title: "Menu", font: "BalooBhai-Regular", fontSize: 30)
       menuButton.zPosition = 1
       menuButton.name = "menu"
       addChild(menuButton);
        
        
        scoreText.text = "Score: \(HudNode.score)";
        scoreText.fontSize = 40;
        scoreText.fontColor =  SKColor(red:0.34, green:0.39, blue:0.47, alpha:1.0);
        scoreText.position = CGPoint(x: size.width / 2, y: size.height - 120)
        addChild(scoreText);
        
    }
    
    @objc func showHighScores () {
        let transition = SKTransition.reveal(with: .right, duration: 0.75)
        let highScore = HighScores(size: size)
        view?.presentScene(highScore, transition: transition)
    }
    
    @objc func backToMenu () {
       HudNode.score = 0;
       let transition = SKTransition.reveal(with: .right, duration: 0.75)
       let gameMenu = GameMenu(size: size)
       view?.presentScene(gameMenu, transition: transition)
    }

}
