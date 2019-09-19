//
//  GameScene.swift
//  Jetpack Joe
//
//  Created by Trystian Offerman on 15/01/2019.
//  Copyright © 2019 Trystian Offerman. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    private var lastUpdateTime : TimeInterval = 0
    private var gameCharacter = GameCharacter.newInstance();
    private var background = BackgroundSprite();
    private var hudNode = HudNode()
    let systemText = SKLabelNode(fontNamed: "BalooBhai-Regular")
    private var enemySpawned : TimeInterval = 0
    private var spawnTimer : TimeInterval = 1
    private var lives : Int = 3
    private var points : Int = 0
    private var EnemySpeed : Int = 3;
    private var gameStarted : Bool =  false;
    private var starsSpawned : Bool = false;
    private var gameOver: Bool = false;
    
    override func sceneDidLoad() {
        // spawn character
        var worldFrame = frame
        worldFrame.origin.x -= 100
        worldFrame.origin.y -= 100
        worldFrame.size.height += 200
        worldFrame.size.width += 200
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: worldFrame)
        self.physicsBody?.categoryBitMask = WorldCategory
        self.physicsWorld.contactDelegate = self
        
        self.lastUpdateTime = 0;
        addChild(gameCharacter);
        gameCharacter.addSmoke(width: size.width);
        background.setup(size: size);
        addChild(background);
        background.addSnow();
        hudNode.setup(size: size);
        addChild(hudNode);
        systemText.fontSize = 80;
        systemText.position = CGPoint(x: size.width / 2, y: size.height / 2);
        systemText.text = "Ready ??"
        systemText.zPosition = 8;
        addChild(systemText);
        gameCharacter.updatePosition(point: CGPoint(x: frame.midX, y: frame.midY))
        
        _ = setTimeout(3) {
            self.gameStarted = true
            self.systemText.removeFromParent()
        }
    }
    
    func setTimeout(_ delay:TimeInterval, block:@escaping ()->Void) -> Timer {
        return Timer.scheduledTimer(timeInterval: delay, target: BlockOperation(block: block), selector: #selector(Operation.main), userInfo: nil, repeats: false)
    }
    
    public func hitByEnemy() {
        gameCharacter.run(SKAction.fadeAlpha(to: 0.5, duration: 0.5));
        gameCharacter.addBoom();
        _ = setTimeout(0.8) {
            if (!self.gameOver) {
                self.gameCharacter.run(SKAction.fadeAlpha(to: 1, duration: 0.5));
                self.gameCharacter.removeBoom();
            }
            
        }
    }
    
    func newEmitter(name: String) -> SKEmitterNode? {
        return SKEmitterNode(fileNamed: name)
    }
    
    func addCircle(){
        
        let number = CGFloat.random(in: 5 ..< 30)
        
        let circle = SKShapeNode(circleOfRadius: number)
        circle.physicsBody = SKPhysicsBody(circleOfRadius: number)
          //touch location passed from touchesBegan.
 
        circle.glowWidth = 1.0
        circle.fillColor = UIColor(red: 0.898, green: 0.2824, blue: 0, alpha: 1.0)
        // circle.physicsBody = SKPhysicsBody(polygonFrom: circle.path!);
        circle.physicsBody?.categoryBitMask = EnemyCategory;
        circle.physicsBody?.contactTestBitMask = JoeCategory | WorldCategory;
        circle.physicsBody?.isDynamic = true;
        
        let smoke = newEmitter(name: "fire_meteor.sks")!;
        smoke.particleBirthRate = number * 6
        smoke.targetNode = circle;
        smoke.zPosition = 2;
        circle.addChild(smoke);
        
        let xPosition = CGFloat(arc4random()).truncatingRemainder(dividingBy: size.width);
        let yPosition = CGFloat(size.height + 50);
        circle.zPosition = 3;

        circle.physicsBody?.angularDamping = CGFloat.random(in: 0.2 ..< 1);

        circle.position = CGPoint(x: xPosition, y: yPosition)
        
        addChild(circle)
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        
        if let point = touchPoint {
            gameCharacter.setDestination(destination: point)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchPoint = touches.first?.location(in: self)
        
        if let point = touchPoint {
            gameCharacter.setDestination(destination: point)
        }

    }
    
    func decreaseLives() {
        hitByEnemy();
        if (hudNode.getLives() > 1) {
            hudNode.decreaseLives()
        } else {
            gameOver = true;
            self.physicsWorld.speed = 0;
            systemText.fontSize = 50;
            systemText.position = CGPoint(x: size.width / 2, y: size.height / 2);
            systemText.text = "GAME OVER"
            systemText.zPosition = 8;
            background.removeSnow()
            background.removeRain()
            addChild(systemText);
            _ = setTimeout(1.0) {
                let transition = SKTransition.reveal(with: .down, duration: 0.75)
                let gameOverScreen = GameOverScreen(size: self.size)
                self.view?.presentScene(gameOverScreen, transition: transition)
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        if contact.bodyA.categoryBitMask == JoeCategory {
            decreaseLives()
            if (!gameOver) {
                contact.bodyB.node?.removeFromParent()
                contact.bodyB.node?.physicsBody = nil
                contact.bodyB.node?.removeAllActions()
            }
            
        } else if contact.bodyB.categoryBitMask == JoeCategory {
            decreaseLives()
            if (!gameOver) {
                contact.bodyA.node?.removeFromParent()
                contact.bodyA.node?.physicsBody = nil
                contact.bodyA.node?.removeAllActions()
            }

        }
        
        if (contact.bodyA.categoryBitMask == WorldCategory) {
            contact.bodyB.node?.removeFromParent()
            contact.bodyB.node?.physicsBody = nil
            contact.bodyB.node?.removeAllActions()
        } else if (contact.bodyB.categoryBitMask == WorldCategory) {
            contact.bodyA.node?.removeFromParent()
            contact.bodyA.node?.physicsBody = nil
            contact.bodyA.node?.removeAllActions()
        }
            

    }
    
    
    override func update(_ currentTime: TimeInterval) {
        if (!gameStarted || gameOver) {
            return;
        }
        // Update the Spawn Timer'
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        enemySpawned += dt
        gameCharacter.update(deltaTime: dt)

        if enemySpawned > spawnTimer {
            enemySpawned = 0
            addCircle();
            spawnTimer -= 0.01
            if (spawnTimer < 0.1) {
                spawnTimer = 0.3;
            }
            hudNode.updateScore(points: 1);
            background.adjustColor();
            if (HudNode.score > 60 && !starsSpawned) {
                starsSpawned = true;
                background.removeSnow()
                background.addRain()
            }
        }
        
        self.lastUpdateTime = currentTime
        
    }
}
