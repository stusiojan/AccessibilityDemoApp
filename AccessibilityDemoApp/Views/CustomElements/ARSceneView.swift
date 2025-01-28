//
//  ARSceneView.swift
//  AccessibilityDemoApp
//
//  Created by Jan Stusio on 27/01/2025.
//

import AudioManager
import SwiftUI

enum Mode {
    case exploration, tracking
}

struct ARSceneView: View {
    let mode: Mode
    @State private var nearestDistance: Float = 0
    @State private var screenSpaceDistance: CGFloat = 0
    @State private var trackedEntityDistance: CGFloat = -1
    @State private var lastDetectedObject: String = ""
    @State private var selectedEntity: String = "moon"
    
    @State private var currentlyDetectedEntities: Set<String> = []
    @State private var entityDetectionTimer: Timer?
    @State private var detectionStartTime: Date?
    @State private var isSoundPlaying: Bool = false
    
    @State private var counter: Int = 0
    
    init (mode: Mode) {
        self.mode = mode
        if mode == .tracking {
            do {
                // Low frequecy, because more people hear them
                try AudioEngine.shared.playTone(frequency: 196)
                AudioEngine.shared.setVolume(0.1)
            } catch {
                print("Error in playing audio: \(error)")
            }
        }
    }
    
    var body: some View {
        ZStack {
            CustomARView(
                nearestDistance: $nearestDistance,
                screenSpaceDistance: $screenSpaceDistance,
                trackedEntityName: selectedEntity,
                onObjectClose: { entityName in
                    objectCloseFunction(entityName: entityName)
                },
                onObjectLeave: { entityName in
                    objectLeaveFunction(entityName: entityName)
                },
                onTrackedEntityUpdate: { distance in
                    trackedEntityDistance = distance
                    updateTrackingSignal(distance)
                }
            )
            
            CrosshairView()
            
//            VStack {
//                Spacer()
//                
//                VStack {
//                    Text(String(format: "Real Distance: %.2f m", nearestDistance))
//                    Text(String(format: "Screen Distance: %.0f px", screenSpaceDistance))
//                    Text("\(selectedEntity.capitalized) Distance: \(Int(trackedEntityDistance)) px")
//                        .foregroundColor(.yellow)
//                }
//                .padding()
//                .background(Color.black.opacity(0.7))
//                .foregroundColor(.white)
//                .cornerRadius(8)
//                .padding(.bottom, 20)
//            }
        }
        .clipShape(.rect(cornerRadius: 15.0))
        .onChange(of: trackedEntityDistance) {
//            print(trackedEntityDistance)
        }
        .onDisappear {
            entityDetectionTimer?.invalidate()
            AudioEngine.shared.stop()
            AudioManager.shared.stopAllAudios()
        }
    }
    
    private func handleDetection(_ cellestialBody: String) {
        guard mode == .exploration else { return }
        lastDetectedObject = cellestialBody
        HapticsManager.shared.playHapticsFile(named: "AHAP/Boing")
        // TODO: Play sound
    }
    
    private func updateTrackingSignal(_ distance: CGFloat) {
        guard mode == .tracking else { return }
        
        counter += 1
        
        if counter == 10 {
            
            let norm_dist = Float(
                distance.normalize(
                    min: 0,
                    max: 3000,
                    from: 1900,
                    to: -2440
                )
            )
            print("Dist: \(distance)Hz | Pitch: \(norm_dist)Hz")
            AudioEngine.shared.setPitch(norm_dist)
            
            if distance < 50 {
                HapticsManager.shared.playHapticsFile(named: "AHAP/Boing")
            }
            
            counter = 0
        }
    }
    
//    private func normalizeDistance(_ distance: CGFloat) -> Float {
//        let inputMin: CGFloat = 0
//        let inputMax: CGFloat = 5000
//        
//        let outputMin: CGFloat = -2440
//        let outputMax: CGFloat = 2440
//        
//        let normalized = outputMin + (distance - inputMin) * (outputMax - outputMin) / (inputMax - inputMin)
//        
//        return Float(min(max(normalized, outputMin), outputMax))
//    }
    
    //
    func objectCloseFunction(entityName: String) {
        guard mode == .exploration else { return }
        
        lastDetectedObject = entityName
        
        if !currentlyDetectedEntities.contains(entityName) {
            playHaptic()
            currentlyDetectedEntities.insert(entityName)
        }
        handleSoundLogic(for: entityName)
    }
    
    func objectLeaveFunction(entityName: String) {
        guard mode == .exploration else { return }
        
        currentlyDetectedEntities.remove(entityName)
        if entityName == lastDetectedObject {
            resetDetection()
        }
    }
    
    private func handleSoundLogic(for entityName: String) {
        guard !isSoundPlaying else { return }
        
        if detectionStartTime == nil {
            detectionStartTime = Date()
            
            entityDetectionTimer?.invalidate()
            entityDetectionTimer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                guard let startTime = detectionStartTime else {
                    timer.invalidate()
                    return
                }
                
                let duration = Date().timeIntervalSince(startTime)
                if duration >= 3.0 {
                    playSound(entityName)
                    isSoundPlaying = true
                    
                    timer.invalidate()
                    detectionStartTime = nil
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        isSoundPlaying = false
                    }
                }
            }
        }
    }
    
    func resetDetection() {
        entityDetectionTimer?.invalidate()
        entityDetectionTimer = nil
        detectionStartTime = nil
    }
    
    func playHaptic() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
    }
    
    func playSound(_ enityName: String) {
        AudioManager.shared.stopAllAudios()
        AudioManager.shared.playShortDesription(enityName)
    }
}
