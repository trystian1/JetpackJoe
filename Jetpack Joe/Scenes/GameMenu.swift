//
//  GameMenu.swift
//  Jetpack Joe
//
//  Created by Trystian Offerman on 22/05/2019.
//  Copyright © 2019 Trystian Offerman. All rights reserved.
//

import SpriteKit
import MediaPlayer;
import GameKit;

class GameMenu : SKScene {
    let startButtonTexture = SKTexture(imageNamed: "start_button")
    let titleText = SKTexture(imageNamed: "splash")
    // var startButton : SKSpriteNode! = nil
    var titleTextNode : SKSpriteNode! = nil
    private let scoreKey = "JETPACK_JOE_HIGHSCORE"
    let highScoreTextNode = SKLabelNode(fontNamed: "BalooBhai-Regular")
    let highScoreNode = SKLabelNode(fontNamed: "BalooBhai-Regular")
    var highScoreLink = SKLabelNode(fontNamed: "BalooBhai-Regular")
    private var hudNode = HudNode()
    
    let selectedColor = UIColor(red:0.16, green:0.50, blue:0.73, alpha:1.00);
    let blueColor = UIColor(red:0.20, green:0.60, blue:0.86, alpha:1.00);
    let disabledColor = UIColor(red:0.50, green:0.55, blue:0.55, alpha:1.00);

    override func sceneDidLoad() {
        IAPHandler.shared.fetchAvailableProducts();
        backgroundColor = UIColor(red: 0.9255, green: 0.9412, blue: 0.9451, alpha: 1.0) /* #ecf0f1 */
        
        let startButton = FTButtonNode(normalColor: blueColor, selectedColor: selectedColor, disabledColor: SKColor.gray)
        startButton.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(GameMenu.startGame))
        startButton.position = CGPoint(x: self.size.width / 2, y: self.size.height - 220)
        startButton.setButtonLabel(title: "Play game!", font: "BalooBhai-Regular", fontSize: 40)
        startButton.zPosition = 1
        startButton.name = "start"
        addChild(startButton);

        titleTextNode = SKSpriteNode(texture: titleText);
        titleTextNode.position = CGPoint(x: size.width / 2, y: size.height - 720)
        addChild(titleTextNode)

        
        //Set up high-score node
        let defaults = UserDefaults.standard
        
        let highScore = defaults.integer(forKey: scoreKey)
        
        highScoreTextNode.text = "Highscore:"
        highScoreTextNode.fontSize = 40
        highScoreTextNode.position = CGPoint(x: size.width / 2, y: size.height - 80)
        highScoreTextNode.zPosition = 1;
        highScoreTextNode.fontColor = UIColor(red: 0.1725, green: 0.2431, blue: 0.3137, alpha: 1.0) /* #2c3e50 */
        addChild(highScoreTextNode)
        
        highScoreNode.text = "\(highScore)"
        highScoreNode.fontSize = 40
        highScoreNode.verticalAlignmentMode = .top
        highScoreNode.fontColor = UIColor(red: 0.1725, green: 0.2431, blue: 0.3137, alpha: 1.0) /* #2c3e50 */
        highScoreNode.position = CGPoint(x: size.width / 2, y: size.height - 100)
        highScoreNode.zPosition = 1
        SoundController.sharedInstance.playSound(scene: "menu", index: 0);
        addChild(highScoreNode)
        
       
        let highscoreButton = FTButtonNode(normalColor: UIColor(red:0.17, green:0.24, blue:0.31, alpha:1.00), selectedColor: selectedColor, disabledColor: SKColor.gray)
        highscoreButton.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(GameMenu.showHighScores))
        highscoreButton.position = CGPoint(x: self.size.width / 2, y: self.size.height - 320)
        highscoreButton.setButtonLabel(title: "Show Highscores", font: "BalooBhai-Regular", fontSize: 30)
        highscoreButton.zPosition = 1
        highscoreButton.name = "highscore"
        addChild(highscoreButton);
        
    }
    
    @objc func startGame () {
        let transition = SKTransition.reveal(with: .left, duration: 0.75)
        let gameModeSelector = GameModeSelector(size: size)
        view?.presentScene(gameModeSelector, transition: transition)
    }
    
    @objc func showHighScores () {
        let transition = SKTransition.reveal(with: .right, duration: 0.75)
        let highScore = HighScores(size: size)
        view?.presentScene(highScore, transition: transition)
    }
    
}



