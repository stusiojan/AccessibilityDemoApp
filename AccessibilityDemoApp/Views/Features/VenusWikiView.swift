//
//  VenusWikiView.swift
//  AccessibilityDemoApp
//
//  Created by Jan Stusio on 25/01/2025.
//
/*
 TODO:
 - connect to python server
 - send sound
 - get audio answer
 */

import SwiftUI
import AudioManager

struct VenusWikiView: View {
    @State private var isPlaying = false
    
    var body: some View {
        Text("Venus wiki!").font(.largeTitle)
        
        Button {
            isPlaying.toggle()
            AudioManager.shared.playVenusSound(
                trackNumber: 1,
                type: .mp3
            )
        } label: {
            Label(
                isPlaying ? "Stop" : "Play",
                systemImage: isPlaying ? "stop.fill" : "play.fill"
            )
        }
        .largeStyle(backgroundColor: isPlaying ? .pink : .blue)
    }
}

#Preview {
    VenusWikiView()
}
