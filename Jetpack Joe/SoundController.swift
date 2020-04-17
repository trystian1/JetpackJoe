//
//  SoundController.swift
//  Jetpack Joe
//
//  Created by Trystian Offerman on 20/12/2019.
//  Copyright © 2019 Trystian Offerman. All rights reserved.
//

import AVFoundation
class SoundController : NSObject, AVAudioPlayerDelegate {
    static let sharedInstance = SoundController()
    var currentScene = "";
    var currentSoundIndex = 0;
    var audioPlayer : AVAudioPlayer?
    
    public func playSound(scene : String, index: Int) {
        
        if ((audioPlayer == nil || audioPlayer?.isPlaying == false) || currentScene != scene) {
            let soundToPlay = getSounds(scene: scene);
            if (index > soundToPlay.count - 1) {
                currentSoundIndex = 0;
            } else {
                currentSoundIndex = index;
            }
            
            let soundURL = Bundle.main.url(forResource: soundToPlay[currentSoundIndex], withExtension: "mp3")
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL!)
                audioPlayer?.delegate = self
            } catch {
                playSound(scene: scene, index: 0);
            }
            
            audioPlayer?.prepareToPlay()
            
            audioPlayer?.play()
        }
        
        currentScene = scene;
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playSound(scene: currentScene, index: currentSoundIndex + 1)
        
    }
    
    // sound from https://www.bensound.com/royalty-free-music/
    func getSounds(scene: String) -> [String] {
        switch(scene) {
            case "game":
                    return ["game", "game2"];
            case "menu":
                    return ["menu", "menu2"];
            case "gameover":
                    return ["gameover"];
            default:
                    return ["game", "game2"];
        }
    }
    
}
