//
//  HapticsLibraryView.swift
//  AccessibilityDemoApp
//
//  Created by Jan Stusio on 26/01/2025.
//

import SwiftUI

struct HapticsLibraryView: View {
    var body: some View {
        Button {
            HapticsManager.shared.playHapticsFile(named: "AHAP/Sparkle")
        } label: {
            Label("Sparkle", systemImage: "wave.3.right")
        }
        .largeStyle()

        Button {
            HapticsManager.shared.playHapticsFile(named: "AHAP/Boing")
        } label: {
            Label("Boing", systemImage: "wave.3.right")
        }
        .largeStyle()
        
        Button {
            HapticsManager.shared.playHapticsFile(named: "AHAP/Heartbeats")
        } label: {
            Label("Heartbeats", systemImage: "wave.3.right")
        }
        .largeStyle()
        
        Button {
            HapticsManager.shared.playHapticsFile(named: "AHAP/Drums")
        } label: {
            Label("drums", systemImage: "speaker.wave.3")
        }
        .largeStyle()
        
        Button {
            HapticsManager.shared.playCustomHaptic()
        } label: {
            Label("Custom", systemImage: "wave.3.right")
        }
        .largeStyle()
        
    }
}

#Preview {
    HapticsLibraryView()
}
