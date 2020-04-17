//
//  BackgroundSprite.swift
//  Jetpack Joe
//
//  Created by Trystian Offerman on 19/05/2019.
//  Copyright © 2019 Trystian Offerman. All rights reserved.
//

import Foundation
import SpriteKit

public class BackgroundSprite : SKNode {
    
    var skyNode = SKSpriteNode();
    var colorizeToRed = SKAction();
    // (red:0.38, green:0.60, blue:0.65, alpha:1.0)
    var red = CGFloat(0.38);
    var green = CGFloat(0.60);
    var blue = CGFloat(0.65);
    var percentage = Double(0);
    var worldSize : CGSize = CGSize();
    var rain : SKEmitterNode = SKEmitterNode();
    var snow : SKEmitterNode = SKEmitterNode();

    
    
    public func setup(size: CGSize){
        skyNode = SKSpriteNode(color: SKColor(red: red, green: green, blue: blue, alpha: alpha), size: size)
        skyNode.position = CGPoint(x: size.width / 2, y: size.height / 2)
        skyNode.zPosition = 0
        worldSize = size;
   
        addChild(skyNode)

    }
    
    public func addRain() {
        snow.removeFromParent()
        rain = newEmitter(name: "rain.sks")!;
        rain.targetNode = skyNode;
        rain.zPosition = 1;
        rain.position = CGPoint(x: 0, y: worldSize.height / 2)
        skyNode.addChild(rain);
    }
    
    
    public func removeRain() {
        rain.removeFromParent()
    }
    
    public func removeSnow() {
        snow.removeFromParent()
    }
    
    public func addSnow() {
        let snow = newEmitter(name: "rainy.sks")!;
        snow.targetNode = skyNode;
        snow.zPosition = 2;
        snow.position = CGPoint(x: 0, y: worldSize.height / 2)
        skyNode.addChild(snow);
    }
    
    public func adjustColor() {
        percentage = percentage + 0.01;
        red =  getNewColor(color: red)
        green = getNewColor(color: green)
        blue = getNewColor(color: blue)

        colorizeToRed = SKAction.colorize(with: SKColor(red: red, green: green, blue: blue, alpha: alpha), colorBlendFactor: 1.0, duration: 2.0)
        skyNode.run(colorizeToRed);
    }
    
    func newEmitter(name: String) -> SKEmitterNode? {
        return SKEmitterNode(fileNamed: name)
    }
    
    private func getNewColor(color: CGFloat) -> CGFloat {
        let calculationPercentage = Double(-1 * abs(percentage));
        let newColor = CGFloat(min(Double(color) + calculationPercentage/100, 1.0))
        if (newColor < -1) {
            alpha = 0.5;
        }
        return newColor > -1 ? newColor : color;
    }
}
