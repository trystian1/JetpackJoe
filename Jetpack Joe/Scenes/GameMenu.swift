//
//  GameMenu.swift
//  Jetpack Joe
//
//  Created by Trystian Offerman on 22/05/2019.
//  Copyright © 2019 Trystian Offerman. All rights reserved.
//

import SpriteKit
import MediaPlayer;

class GameMenu : SKScene {
    let startButtonTexture = SKTexture(imageNamed: "start_button")
    let titleText = SKTexture(imageNamed: "splash")
    var startButton : SKSpriteNode! = nil
    var titleTextNode : SKSpriteNode! = nil
    private let scoreKey = "JETPACK_JOE_HIGHSCORE"
    let highScoreTextNode = SKLabelNode(fontNamed: "BalooBhai-Regular")
    let highScoreNode = SKLabelNode(fontNamed: "BalooBhai-Regular")
    
    override func sceneDidLoad() {
        backgroundColor = UIColor(red: 0.9255, green: 0.9412, blue: 0.9451, alpha: 1.0) /* #ecf0f1 */
        startButton = SKSpriteNode(texture: startButtonTexture);
        startButton.position = CGPoint(x: size.width / 2, y: size.height - 260);
        addChild(startButton);
        
        titleTextNode = SKSpriteNode(texture: titleText);
        titleTextNode.position = CGPoint(x: size.width / 2, y: size.height - 680)
        addChild(titleTextNode)

        
        //Set up high-score node
        let defaults = UserDefaults.standard
        
        let highScore = defaults.integer(forKey: scoreKey)
        
        highScoreTextNode.text = "Highscore:"
        highScoreTextNode.fontSize = 50
        highScoreTextNode.position = CGPoint(x: size.width / 2, y: size.height - 90)
        highScoreTextNode.zPosition = 1;
        highScoreTextNode.fontColor = UIColor(red: 0.1725, green: 0.2431, blue: 0.3137, alpha: 1.0) /* #2c3e50 */
        addChild(highScoreTextNode)
        
        highScoreNode.text = "\(highScore)"
        highScoreNode.fontSize = 50
        highScoreNode.verticalAlignmentMode = .top
        highScoreNode.fontColor = UIColor(red: 0.1725, green: 0.2431, blue: 0.3137, alpha: 1.0) /* #2c3e50 */
        highScoreNode.position = CGPoint(x: size.width / 2, y: size.height - 120)
        highScoreNode.zPosition = 1
        SoundController.sharedInstance.playSound(scene: "menu", index: 0);
        addChild(highScoreNode)
        
    }
      
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if (startButton.contains(touch.location(in: self))) {
                let transition = SKTransition.reveal(with: .down, duration: 0.75)
                let gameScene = GameScene(size: size)
                view?.presentScene(gameScene, transition: transition)
            }
            
        }
        
    }
    
}



