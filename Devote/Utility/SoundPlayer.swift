//
//  SoundPlayer.swift
//  Devote
//
//  Created by Soro on 2022-10-12.
//

import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String){
    if let path = Bundle.main.path(forResource: sound, ofType: type){
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path)
            )
            audioPlayer?.play()
        }catch{
            print("Could not find and play sound file. \(sound)")
        }
    }
}
