//
//  GameCharacterSprite.swift
//  Jetpack Joe
//
//  Created by Trystian Offerman on 15/01/2019.
//  Copyright © 2019 Trystian Offerman. All rights reserved.
//

import Foundation
import SpriteKit

public class GameCharacter : SKSpriteNode {
    private var destination : CGPoint!
    private let easing : CGFloat = 0.1
    var smoke = SKEmitterNode();
    var fire = SKEmitterNode();
    var boom = SKEmitterNode();
    var boomFire = SKEmitterNode();
    var worldWidth : CGFloat = 0;
    
    public static func newInstance() -> GameCharacter {
        let gameCharacter = GameCharacter(imageNamed: "jetpack_joe_2");
        gameCharacter.physicsBody = SKPhysicsBody(circleOfRadius: gameCharacter.size.width / 2)
        gameCharacter.physicsBody?.isDynamic = false
        gameCharacter.physicsBody?.restitution = 0.9
        gameCharacter.physicsBody?.categoryBitMask = JoeCategory;
        gameCharacter.physicsBody?.contactTestBitMask = EnemyCategory;
        gameCharacter.zPosition = 2;
        
        return gameCharacter
    }
    
    public func addSmoke(width : CGFloat) {
        smoke = newSmokeEmitter(fileName: "Smoke.sks")!;
        smoke.targetNode = self;
        addChild(smoke);
        smoke.position = CGPoint(x: position.x / 2, y: position.y - size.height + 20);
        
        fire = newSmokeEmitter(fileName: "fire.sks")!;
        fire.targetNode = self;
        addChild(fire);
        fire.position = CGPoint(x: position.x / 2, y: position.y - size.height + 55);
        worldWidth = width;
    }
    
    public func addBoom() {
        boom.removeFromParent();
        boomFire.removeFromParent();
        boom = newSmokeEmitter(fileName: "boom_fire.sks")!;
        boom.targetNode = self;
        boomFire = newSmokeEmitter(fileName: "boom.sks")!;
        boomFire.targetNode = self;
        addChild(boom);
        addChild(boomFire);
    }
    
    public func removeBoom() {
        boom.removeFromParent();
        boomFire.removeFromParent();
    }
 
    func newSmokeEmitter(fileName: String) -> SKEmitterNode? {
        return SKEmitterNode(fileNamed: fileName)
    }
    
    
    public func updatePosition(point : CGPoint) {
        position = point
        destination = point
    }
    
    public func setDestination(destination : CGPoint) {
        self.destination = destination
    }
    
    public func setSmoke(direction: CGPoint) {

        if (CGFloat(destination.x) > CGFloat(worldWidth / 2)) {
            smoke.emissionAngle = -122 * CGFloat(Double.pi) / 180
            zRotation = 50;
        } else {
            smoke.emissionAngle = -50 * CGFloat(Double.pi) / 180
            zRotation = -50;
        }
        if (Int(position.x) == Int(destination.x)) {
            smoke.emissionAngle = -90 * CGFloat(Double.pi) / 180
            zRotation = 0;
        }
    
    }
        
    public func update(deltaTime : TimeInterval) {
        let distance = sqrt(pow((destination.x - position.x), 2) + pow((destination.y - position.y), 2))
        setSmoke(direction:  destination);
        
        
        if(distance > 1) {
            let directionX = (destination.x - position.x)
            let directionY = (destination.y - position.y)
            
            position.x += directionX * easing
            position.y += directionY * easing
            
        } else {
            position = destination;
        }
    }
}
