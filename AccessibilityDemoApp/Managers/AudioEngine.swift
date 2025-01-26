//
//  AudioEngine.swift
//  AccessibilityDemoApp
//
//  Created by Jan Stusio on 26/01/2025.
//

import Foundation
import AVKit

public class AudioEngine {
    public static let shared = AudioEngine()
    
    private init() {}
    
    private let engine = AVAudioEngine()
    private let speedControl = AVAudioUnitVarispeed()
    private let pitchControl = AVAudioUnitTimePitch()
    
    public func play(_ name: String) throws {
        // 0: prepare URL
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            print("No url for \(name).mp3")
            return
        }
        
        // 1: load the file
        let file = try AVAudioFile(forReading: url)

        // 2: create the audio player
        let audioPlayer = AVAudioPlayerNode()

        // 3: connect the components to our playback engine
        engine.attach(audioPlayer)
        engine.attach(pitchControl)
        engine.attach(speedControl)

        // 4: arrange the parts so that output from one is input to another
        engine.connect(audioPlayer, to: speedControl, format: nil)
        engine.connect(speedControl, to: pitchControl, format: nil)
        engine.connect(pitchControl, to: engine.mainMixerNode, format: nil)

        // 5: prepare the player to play its file from the beginning
        audioPlayer.scheduleFile(file, at: nil)

        // 6: start the engine and player
        try engine.start()
        audioPlayer.play()
    }
    
    public func setPitch(_ value: Float) {
        pitchControl.pitch = value
    }
    
    public func setSpeed(_ value: Float) {
        speedControl.rate = value
    }
}
