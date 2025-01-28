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
    
    private let engine = AVAudioEngine()
    private let speedControl = AVAudioUnitVarispeed()
    private let pitchControl = AVAudioUnitTimePitch()
    private let volumeNode = AVAudioMixerNode()
    private var audioPlayer: AVAudioPlayerNode?
    private var toneSourceNode: AVAudioSourceNode?
    
    private let sampleRate: Double = 44100
    private var frequency: Double = 440
    private var phase: Double = 0
    
    private init() {
        engine.attach(volumeNode)
        volumeNode.volume = 0.5
    }
    
    public func play(_ name: String) throws {
        stop()
        
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
        engine.connect(volumeNode, to: engine.mainMixerNode, format: nil)
        
        audioPlayer.scheduleFile(file, at: nil)
        
        try engine.start()
        audioPlayer.play()
    }
    
    public func playTone(frequency: Double = 440) throws {
        stop()
        
        self.frequency = frequency
        let format = AVAudioFormat(standardFormatWithSampleRate: sampleRate, channels: 1)!
        
        toneSourceNode = AVAudioSourceNode { [weak self] _, _, frameCount, audioBufferList -> OSStatus in
            guard let self = self else { return noErr }
            
            let ablPointer = UnsafeMutableAudioBufferListPointer(audioBufferList)
            let buffer = ablPointer[0]
            let ptr = buffer.mData?.assumingMemoryBound(to: Float.self)
            
            for frame in 0..<Int(frameCount) {
                let value = sin(2.0 * .pi * self.frequency * self.phase / self.sampleRate)
                ptr?[frame] = Float(value) + self.volumeNode.volume
                self.phase += 1.0
                if self.phase >= self.sampleRate {
                    self.phase -= self.sampleRate
                }
            }
            
            return noErr
        }
        
        if let toneSourceNode = toneSourceNode {
            engine.attach(toneSourceNode)
            engine.attach(pitchControl)
            engine.attach(speedControl)
            
            engine.connect(toneSourceNode, to: speedControl, format: format)
            engine.connect(speedControl, to: pitchControl, format: format)
            engine.connect(pitchControl, to: engine.mainMixerNode, format: format)
//            engine.connect(volumeNode, to: engine.mainMixerNode, format: format)
            
            try engine.start()
        }
    }
    
    public func stop() {
        if let audioPlayer = audioPlayer {
            audioPlayer.stop()
            engine.detach(audioPlayer)
            self.audioPlayer = nil
        }
        
        if let toneSourceNode = toneSourceNode {
            engine.detach(toneSourceNode)
            self.toneSourceNode = nil
        }
        
        engine.stop()
        phase = 0
    }
    
    public func setPitch(_ value: Float) {
        pitchControl.pitch = value
    }
    
    public func setSpeed(_ value: Float) {
        speedControl.rate = value
    }
    
    public func setToneFrequency(_ frequency: Double) {
        self.frequency = frequency
    }
    
    public func setVolume(_ value: Float) {
        let clampedValue = max(0.0, min(1.0, value))
        volumeNode.volume = clampedValue
    }
}
