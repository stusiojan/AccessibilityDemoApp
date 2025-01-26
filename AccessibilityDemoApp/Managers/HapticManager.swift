//
//  HapticManager.swift
//  AccessibilityDemoApp
//
//  Created by Jan Stusio on 26/01/2025.
//

import AVFoundation
import CoreHaptics
import SwiftUI

class HapticsManager {
    static let shared = HapticsManager()
    
    private var engine: CHHapticEngine? = nil
    private lazy var supportsHaptics: Bool = {
        CHHapticEngine.capabilitiesForHardware().supportsHaptics
    }()
    
    private init() {
        createEngine()
    }
    
//    private func prepareHapticEngine() {
//        guard supportsHaptics else {
//            print("Device does not support haptics")
//            return
//        }
//        
//        do {
//            engine = try CHHapticEngine()
//            try engine?.start()
//        } catch let error {
//            fatalError("Engine Creation Error: \(error)")
//        }
//    }
    
    private func createEngine() {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            engine = try CHHapticEngine(audioSession: audioSession)
        } catch let error {
            print("Engine Creation Error: \(error)")
        }
        
        guard let engine = engine else {
            print("Failed to create engine!")
            return
        }
        
        engine.stoppedHandler = { reason in
            print("The engine stopped for reason: \(reason.rawValue)")
            switch reason {
            case .audioSessionInterrupt:
                print("Audio session interrupt")
            case .applicationSuspended:
                print("Application suspended")
            case .idleTimeout:
                print("Idle timeout")
            case .systemError:
                print("System error")
            case .notifyWhenFinished:
                print("Playback finished")
            case .gameControllerDisconnect:
                print("Controller disconnected.")
            case .engineDestroyed:
                print("Engine destroyed.")
            @unknown default:
                print("Unknown error")
            }
        }
        
        engine.resetHandler = {
            print("The engine reset --> Restarting now!")
            do {
                try self.engine?.start()
            } catch {
                print("Failed to restart the engine: \(error)")
            }
        }
    }
    
    func playHapticsFile(named filename: String) {
        guard supportsHaptics else { return }
        
        guard let path = Bundle.main.path(forResource: filename, ofType: "ahap") else {
            return
        }
        
        do {
            try engine?.start()
            try engine?.playPattern(from: URL(fileURLWithPath: path))
        } catch {
            print("An error occured playing \(filename): \(error).")
        }
    }
    
    func playCustomHaptic() {
        guard supportsHaptics else { return }
        
        var events = [CHHapticEvent]()
        
        for i in stride(from: 0, to: 1, by: 0.3) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            
            events.append(event)
        }
        
        do {
            try engine?.start()
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)  // TODO: Do this work with my engine?
            try player?.start(atTime: .zero)
        } catch {
            print("There was an error playing the haptic pattern: \(error.localizedDescription)")
        }
    }
}
