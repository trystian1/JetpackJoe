//
//  GameOverScreen.swift
//  Jetpack Joe
//
//  Created by Trystian Offerman on 22/05/2019.
//  Copyright © 2019 Trystian Offerman. All rights reserved.
//

import SpriteKit

class GameOverScreen : SKScene {
    var gameOverText = SKLabelNode(fontNamed: "BalooBhai-Regular")
    var scoreText = SKLabelNode(fontNamed: "BalooBhai-Regular")
    let menuButtonTexture = SKTexture(imageNamed: "main_menu-2")
    var menuButton : SKSpriteNode! = nil
    
    let jetpackJoeDeathTexture = SKTexture(imageNamed: "joe_death")
    var jetpackJoeDeath : SKSpriteNode! = nil
    
    override func sceneDidLoad() {
        menuButton = SKSpriteNode(texture: menuButtonTexture);
        menuButton.position = CGPoint(x: size.width / 2, y: size.height - 320)
        addChild(menuButton);
        
        jetpackJoeDeath = SKSpriteNode(texture: jetpackJoeDeathTexture);
        jetpackJoeDeath.position = CGPoint(x: size.width / 2, y: size.height - 600)
        addChild(jetpackJoeDeath);

        
        backgroundColor = UIColor(red: 0.9255, green: 0.9412, blue: 0.9451, alpha: 1.0);
        gameOverText.text = "Game over";
        gameOverText.fontColor = SKColor(red:0.34, green:0.39, blue:0.47, alpha:1.0);
        gameOverText.position = CGPoint(x: size.width / 2, y: size.height - 110);
        gameOverText.fontSize = 50;
        addChild(gameOverText);
        
        
        scoreText.text = "Score: \(HudNode.score)";
        scoreText.fontSize = 50;
        scoreText.fontColor =  SKColor(red:0.34, green:0.39, blue:0.47, alpha:1.0);
        scoreText.position = CGPoint(x: size.width / 2, y: size.height - 170);
        addChild(scoreText);
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if (menuButton.contains(touch.location(in: self))) {
                HudNode.score = 0;
                let transition = SKTransition.reveal(with: .right, duration: 0.75)
                let gameMenu = GameMenu(size: size)
                view?.presentScene(gameMenu, transition: transition)
            }
            
        }
        
    }
}
