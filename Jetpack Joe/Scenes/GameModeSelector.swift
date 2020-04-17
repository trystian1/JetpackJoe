
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

class GameModeSelector : SKScene {
    let backBtn : SKSpriteNode! = nil
    let selectedColor = UIColor(red:0.16, green:0.50, blue:0.73, alpha:1.00);
    let blueColor = UIColor(red:0.20, green:0.60, blue:0.86, alpha:1.00);
    let disabledColor = UIColor(red:0.50, green:0.55, blue:0.55, alpha:1.00);
    let beerLink = SKLabelNode(fontNamed: "BalooBhai-Regular")
    let restore = SKLabelNode(fontNamed: "BalooBhai-Regular")
    let backButton = SKLabelNode(fontNamed: "BalooBhai-Regular")
    
    @objc func startNormalMode() {
        let transition = SKTransition.reveal(with: .down, duration: 0.75)
        GameProperties.shared.setGameMode(mode: "NORMAL")
        GameProperties.shared.setLives(new: 3)
        let gameScene = GameScene(size: size)
        view?.presentScene(gameScene, transition: transition)
    }
    
    @objc func startHardcoreMode() {
        if (defaults.bool(forKey: "hardcore_mode")) {
            let transition = SKTransition.reveal(with: .down, duration: 0.75)
            GameProperties.shared.setGameMode(mode: "HARDCORE")
            GameProperties.shared.setLives(new: 1)
            let gameScene = GameScene(size: size)
            view?.presentScene(gameScene, transition: transition)
        } else {
            IAPHandler.shared.purchaseMyProduct(index: 1)
        }

    }
    
    var isAuthorizedForPayments: Bool {
     return SKPaymentQueue.canMakePayments()
    }
    
    override func sceneDidLoad() {
        backButton.text = "< back"
        backButton.position = CGPoint(x: 80, y: self.size.height - 50)
        backButton.fontSize = 30
        backButton.verticalAlignmentMode = .top
        backButton.fontColor = blueColor
        backgroundColor = UIColor(red: 0.9255, green: 0.9412, blue: 0.9451, alpha: 1.0) /* #ecf0f1 */
        addChild(backButton)
        
        let title = SKLabelNode(fontNamed: "BalooBhai-Regular")
        title.text = "Choose a game mode!"
        title.position = CGPoint(x: self.size.width / 2, y: self.size.height - 100)
        title.fontSize = 30
        title.verticalAlignmentMode = .top
        title.fontColor = UIColor(red: 0.1725, green: 0.2431, blue: 0.3137, alpha: 1.0) /* #2c3e50 */
        backgroundColor = UIColor(red: 0.9255, green: 0.9412, blue: 0.9451, alpha: 1.0) /* #ecf0f1 */
        
        let regularModeText = SKLabelNode(fontNamed: "BalooBhai-Regular")
        regularModeText.text = "Play Jetpack Joe with 3 lives"
        regularModeText.position = CGPoint(x: self.size.width / 2, y: self.size.height - 160)
        regularModeText.fontSize = 20
        regularModeText.verticalAlignmentMode = .top
        regularModeText.fontColor = UIColor(red: 0.1725, green: 0.2431, blue: 0.3137, alpha: 1.0) /* #2c3e50 */
        
        let regularModeText2 = SKLabelNode(fontNamed: "BalooBhai-Regular")
        regularModeText2.text = "(Regular Leaderboard)"
        regularModeText2.position = CGPoint(x: self.size.width / 2, y: self.size.height - 190)
        regularModeText2.fontSize = 20
        regularModeText2.verticalAlignmentMode = .top
        regularModeText2.fontColor = UIColor(red: 0.1725, green: 0.2431, blue: 0.3137, alpha: 1.0)
    
        let regularMode = FTButtonNode(normalColor: blueColor, selectedColor: selectedColor, disabledColor: SKColor.gray)
        regularMode.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(GameModeSelector.startNormalMode))
        regularMode.position = CGPoint(x: self.size.width / 2, y: self.size.height - 260)
        regularMode.setButtonLabel(title: "Play Regular", font: "BalooBhai-Regular", fontSize: 30)
        regularMode.zPosition = 1
        regularMode.name = "backBtn"
        
        let hardcoreMode = FTButtonNode(normalColor: defaults.bool(forKey: "hardcore_mode") ? blueColor : SKColor.gray, selectedColor: selectedColor, disabledColor: SKColor.gray)
        let hardcoreText = SKLabelNode(fontNamed: "BalooBhai-Regular")
        hardcoreText.text = "Play Jetpack Joe with only one life"
        hardcoreText.position = CGPoint(x: self.size.width / 2, y: self.size.height - 360)
        hardcoreText.fontSize = 20
        hardcoreText.verticalAlignmentMode = .top
        hardcoreText.fontColor = UIColor(red: 0.1725, green: 0.2431, blue: 0.3137, alpha: 1.0) /* #2c3e50 */

        let hardcoreText3 = SKLabelNode(fontNamed: "BalooBhai-Regular")
        hardcoreText3.text = "(Hardcore Leaderboard)"
        hardcoreText3.position = CGPoint(x: self.size.width / 2, y: self.size.height - 390)
        hardcoreText3.fontSize = 20
        hardcoreText3.verticalAlignmentMode = .top
        hardcoreText3.fontColor = UIColor(red: 0.1725, green: 0.2431, blue: 0.3137, alpha: 1.0)

        hardcoreMode.setButtonAction(target: self, triggerEvent: .TouchUpInside, action: #selector(GameModeSelector.startHardcoreMode))
        hardcoreMode.position = CGPoint(x: self.size.width / 2, y: self.size.height - 460)
        
        hardcoreMode.zPosition = 1
        hardcoreMode.name = "backBtn"
        
        if (defaults.bool(forKey: "hardcore_mode")) {
           hardcoreMode.setButtonLabel(title: "Play Hardcore", font: "BalooBhai-Regular", fontSize: 30)
        } else {
            hardcoreMode.setButtonLabel(title: "Buy Hardcore 🔒", font: "BalooBhai-Regular", fontSize: 30)
        }
        
        IAPHandler.shared.purchaseStatusBlock = {[weak self] (type) in
                
             if type == .restored && defaults.bool(forKey: "hardcore_mode")  {
                hardcoreMode.setButtonLabel(title: "Play Hardcore", font: "BalooBhai-Regular", fontSize: 30)
                hardcoreMode.setColor(newColor: self?.blueColor ?? SKColor.blue)
            }
            
            
             if type == .purchased {
                hardcoreMode.setButtonLabel(title: "Play Hardcore", font: "BalooBhai-Regular", fontSize: 30)
                hardcoreMode.setColor(newColor: self?.blueColor ?? SKColor.blue)
                self?.beerLink.text = "Thank you! 🍻😎";
                self?.beerLink.fontColor = UIColor(red:0.09, green:0.63, blue:0.52, alpha:1.00);
             }
            
            if type == .disabled {
                let alert = UIAlertController(title: "Something went wrong", message: IAPHandler.shared.error, preferredStyle: UIAlertController.Style.alert);
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
            }
                        
         }
    
        if (isAuthorizedForPayments) {
            
            self.addChild(hardcoreText)
            self.addChild(hardcoreText3)
            self.addChild(hardcoreMode)
            
            beerLink.text = "Buy me a beer 🍺";
            beerLink.fontSize = 40;
            beerLink.fontColor =  UIColor(red:0.16, green:0.50, blue:0.73, alpha:1.00)
            beerLink.position = CGPoint(x: size.width / 2, y: size.height - 580)
            addChild(beerLink);
            
            restore.text = "Restore purchases";
            restore.fontSize = 25;
            restore.fontColor =  UIColor(red:0.16, green:0.50, blue:0.73, alpha:1.00)
            restore.position = CGPoint(x: size.width / 2, y: size.height - 640)
            addChild(restore);
        
        }
    
        
        self.addChild(regularModeText)
        self.addChild(regularModeText2)
        self.addChild(regularMode)

        self.addChild(title)
    }
    
   
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
          if let touch = touches.first {
              if (backButton.contains(touch.location(in: self))) {
                   let transition = SKTransition.reveal(with: .right, duration: 0.75)
                   let gameMenu = GameMenu(size: size)
                   view?.presentScene(gameMenu, transition: transition)
              }
            
                
            
             if (beerLink.contains(touch.location(in: self))) {
                 IAPHandler.shared.purchaseMyProduct(index: 0)
            }
            
            if (restore.contains(touch.location(in: self))) {
                IAPHandler.shared.restorePurchase();
            }
          
          }
          
      }

 
}
