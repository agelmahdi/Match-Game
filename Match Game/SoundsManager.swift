//
//  SoundsManager.swift
//  Match Game
//
//  Created by Ahmed El-Mahdi on 8/9/19.
//  Copyright © 2019 Ahmed El-Mahdi. All rights reserved.
//

import Foundation
import AVFoundation

class SoundsManager  {
    
   static var audioPlayer : AVAudioPlayer?
    
    enum soundEffect {
        
        case flip
        case shuffle
        case match
        case nonmatch
        
    }
    
    static func playSound(_ effect: soundEffect) {
        
        var fileName = ""
        
        switch effect {
            
        case .flip:
            
            fileName = "cardflip"
            
        case .shuffle:
            
            fileName = "shuffle"
            
        case .match:
            
            fileName = "dingcorrect"
            
        case .nonmatch:
            
            fileName = "dingwrong"
            
        }
        
        let bundlePath = Bundle.main.path(forResource: fileName, ofType: "wav")
        
        guard bundlePath != nil else {
            
            print("coudn`t find sound file \(fileName) in the bundle")
            
            return
        }
        
        let soundUrl = URL(fileURLWithPath: bundlePath!)
        
        do{
            
            audioPlayer = try AVAudioPlayer(contentsOf: soundUrl)
            audioPlayer?.play()
            
        }
        catch{
            
            print("coudn`t play sound file \(fileName)")
        }
        
        
    }
}
