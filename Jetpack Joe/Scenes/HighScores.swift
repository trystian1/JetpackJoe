//
//  File.swift
//  Jetpack Joe
//
//  Created by Trystian Offerman on 26/03/2020.
//  Copyright © 2020 Trystian Offerman. All rights reserved.
//

//
//  GameOverScreen.swift
//  Jetpack Joe
//
//  Created by Trystian Offerman on 22/05/2019.
//  Copyright © 2019 Trystian Offerman. All rights reserved.
//

import SpriteKit
import GameKit
import StoreKit

class HighScores : SKScene {
    var gameOverText = SKLabelNode(fontNamed: "BalooBhai-Regular")
    let menuButtonTexture = SKTexture(imageNamed: "main_menu-2")
    var menuButton : SKSpriteNode! = nil
    let selectedColor = UIColor(red:0.16, green:0.50, blue:0.73, alpha:1.00);
    let blueColor = UIColor(red:0.20, green:0.60, blue:0.86, alpha:1.00);
    let disabledColor = UIColor(red:0.50, green:0.55, blue:0.55, alpha:1.00);
    let regularModeHighscores = SKLabelNode(fontNamed: "BalooBhai-Regular")
    let hardcoreModeHighscores = SKLabelNode(fontNamed: "BalooBhai-Regular")
    
    let colorActive = UIColor(red:0.09, green:0.63, blue:0.52, alpha:1.00)
    let colorLink = UIColor(red:0.16, green:0.50, blue:0.73, alpha:1.00)
    let scoreNode = SKNode();
    
    override func sceneDidLoad() {
        retrieveTopTenScores();
        backgroundColor = UIColor(red: 0.9255, green: 0.9412, blue: 0.9451, alpha: 1.0);
        let highScoreText = SKLabelNode(fontNamed: "BalooBhai-Regular")
        highScoreText.text = "Top 10 Highscores!"
        highScoreText.position = CGPoint(x: self.size.width / 2, y: self.size.height - 60)
        highScoreText.fontSize = 40
        highScoreText.verticalAlignmentMode = .top
        highScoreText.fontColor = UIColor(red: 0.1725, green: 0.2431, blue: 0.3137, alpha: 1.0) /* #2c3e50 */
        
        regularModeHighscores.text = "Regular";
        regularModeHighscores.fontSize = 30;
        regularModeHighscores.fontColor =  UIColor(red:0.16, green:0.50, blue:0.73, alpha:1.00)
        regularModeHighscores.position = CGPoint(x: 110, y: size.height - 140)
        addChild(regularModeHighscores);
        
        hardcoreModeHighscores.text = "Hardcore";
        hardcoreModeHighscores.fontSize = 30;
        hardcoreModeHighscores.fontColor =  UIColor(red:0.16, green:0.50, blue:0.73, alpha:1.00)
        hardcoreModeHighscores.position = CGPoint(x: (size.width / 2) + 80, y: size.height - 140)
        addChild(hardcoreModeHighscores);
        
        menuButton = SKSpriteNode(texture: menuButtonTexture);
        menuButton.position = CGPoint(x: size.width / 2, y: size.height - (size.height - 80))
        addChild(menuButton);
        addChild(highScoreText);
        
        setActiveItem();
        
        addChild(scoreNode);
    }
    
    
    func setActiveItem() {
        print(GameProperties.shared.getLeaderBoardId())
        switch(GameProperties.shared.getLeaderBoardId()) {
        case "jetpackjoe_hardcore_leaderboard":
            setHardcoreActive();
            break;
        case "jetpackjoeleaderboard":
            setRegularActive()
            break;
        default:
            setRegularActive()
            break;
        }
    }
    
    func setRegularActive() {
        regularModeHighscores.fontSize = 40;
        regularModeHighscores.fontColor = colorActive
        hardcoreModeHighscores.fontSize = 30;
        hardcoreModeHighscores.fontColor = colorLink
    }
    
    func setHardcoreActive() {
        hardcoreModeHighscores.fontSize = 40;
        regularModeHighscores.fontSize = 30;
        hardcoreModeHighscores.fontColor = colorActive
        regularModeHighscores.fontColor = colorLink
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if (menuButton.contains(touch.location(in: self))) {
                HudNode.score = 0;
                let transition = SKTransition.reveal(with: .left, duration: 0.75)
                let gameMenu = GameMenu(size: size)
                view?.presentScene(gameMenu, transition: transition)
            }
            
            if (hardcoreModeHighscores.contains(touch.location(in: self))) {
                GameProperties.shared.setGameMode(mode: "HARDCORE")
                retrieveTopTenScores();
                setActiveItem();
            }
            
            if (regularModeHighscores.contains(touch.location(in: self))) {
                GameProperties.shared.setGameMode(mode: "NORMAL")
                retrieveTopTenScores();
                setActiveItem();
            }
        }
    }

    func retrieveTopTenScores() {
        
        scoreNode.removeAllChildren();
        let leaderboard = GKLeaderboard()
        leaderboard.identifier = GameProperties.shared.getLeaderBoardId()
        leaderboard.playerScope = GKLeaderboard.PlayerScope.global
        leaderboard.timeScope = GKLeaderboard.TimeScope.allTime
        leaderboard.range = NSRange(location: 1, length: 10);
        var intPosition : Int32 = 10;
        print(leaderboard)
        leaderboard.loadScores { scores, error in
            guard let scores = scores else {return}
            print(scores)
            for score in scores {
                
                let scoreText = SKLabelNode(fontNamed: "BalooBhai-Regular")
                let yPosition = CGFloat(intPosition)

                scoreText.text = "\(score.rank):  \(score.player.displayName)   \(score.value)"
                scoreText.position = CGPoint(x: self.size.width / 2, y: self.size.height - (160 + yPosition))
                scoreText.fontSize = 30
                scoreText.verticalAlignmentMode = .top
                scoreText.fontColor = UIColor(red: 0.1725, green: 0.2431, blue: 0.3137, alpha: 1.0) /* #2c3e50 */
                self.scoreNode.addChild(scoreText);
                intPosition += 40;
            }
            
        }
        
    }

    //shows leaderboard screen
    func showLeader() {
        let viewControllerVar = self.view?.window?.rootViewController
        let gKGCViewController = GKGameCenterViewController()
        gKGCViewController.gameCenterDelegate = self as? GKGameCenterControllerDelegate
        viewControllerVar?.present(gKGCViewController, animated: true, completion: nil)
    }
    
    func gameCenterViewControllerDidFinish(gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
    }
}
