//
//  HudNode.swift
//  Jetpack Joe
//
//  Created by Trystian Offerman on 19/05/2019.
//  Copyright © 2019 Trystian Offerman. All rights reserved.
//

import SpriteKit

class HudNode : SKNode {
    
    private let scoreKey = "JETPACK_JOE_HIGHSCORE"
    private let scoreNode = SKLabelNode(fontNamed: "BalooBhai-Regular")
    private let livesNode = SKLabelNode(fontNamed: "BalooBhai-Regular");
    static var score = 0
    private var highScore : Int = 0
    private var worldSize = CGSize();
    
    private var lives : Int = 3;
    
    public func setup(size: CGSize) {
        let defaults = UserDefaults.standard
        highScore = defaults.integer(forKey: scoreKey)
        scoreNode.position = CGPoint(x: size.width / 2, y: size.height - 100);
        updateScoreboard();
        scoreNode.fontSize = 50
        scoreNode.zPosition = 1
        scoreNode.color = SKColor.white
        addChild(scoreNode)
        
        worldSize = size;
        let livesNodeHeight = size.height - (size.height - 100);
    
        livesNode.position = CGPoint(x: size.width / 2, y: livesNodeHeight);
        livesNode.fontSize = 50
        livesNode.zPosition = 1
        livesNode.color = SKColor.white
        addChild(livesNode);
        let live = SKSpriteNode(imageNamed: "jetpack_joe_2");
        live.size = CGSize(width: 30, height: 40)
        let liveNodeY = size.height - (size.height - 120);
        let liveNodeX = size.width / 2 - 50;
        live.position = CGPoint(x: liveNodeX, y: liveNodeY);
        addChild(live);
        
        
    }
 
    public func updateScore(points: Int) {
        HudNode.score += points
        updateScoreboard();
        if (HudNode.score > highScore) {
            let defaults = UserDefaults.standard
            defaults.set(HudNode.score, forKey: scoreKey)
        }
    }
    
    public func getLives() -> Int {
        return GameProperties.shared.getLives();
    }
  
    public func decreaseLives() {
        GameProperties.shared.decreaseLives();
        updateScoreboard();
    }
 
    public func updateScoreboard() {
        scoreNode.text = "Distance: \(HudNode.score)"
        livesNode.text = "x \(GameProperties.shared.getLives())"
    }
    
}
