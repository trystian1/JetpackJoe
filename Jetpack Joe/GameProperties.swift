//
//  GameProperties.swift
//  Jetpack Joe
//
//  Created by Trystian Offerman on 05/04/2020.
//  Copyright © 2020 Trystian Offerman. All rights reserved.
//

import Foundation

class GameProperties {
    
    static let shared = GameProperties()
    private var score = 0;
    private var gameMode = "NORMAL";
    private var lives = 3;
   
    public func getLives() -> Int {
        return lives;
    }
    
    public func decreaseLives() {
        lives-=1;
    }
    
    public func setLives(new: Int) {
        lives = new;
    }
    
    public func setGameMode(mode: String) {
        gameMode = mode;
    }
    
    public func getLeaderBoardId() -> String {
        switch(gameMode) {
            case "NORMAL":
                return "jetpackjoeleaderboard"
            case "HARDCORE":
                return "jetpackjoe_hardcore_leaderboard"
            default:
                return "jetpackjoeleaderboard";
            
        }
    }
    
    

}

