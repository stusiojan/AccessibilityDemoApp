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
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            print("No url for \(name).mp3")
            return
        }
        
        let file = try AVAudioFile(forReading: url)
        let audioPlayer = AVAudioPlayerNode()

        engine.attach(audioPlayer)
        engine.attach(pitchControl)
        engine.attach(speedControl)

        engine.connect(audioPlayer, to: speedControl, format: nil)
        engine.connect(speedControl, to: pitchControl, format: nil)
        engine.connect(pitchControl, to: engine.mainMixerNode, format: nil)

        audioPlayer.scheduleFile(file, at: nil)

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
