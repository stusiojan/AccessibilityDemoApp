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
    @State private var isPlayingFirst = false
    @State private var isPlayingSecond = false
    
    var body: some View {
        Text("Venus wiki!").font(.largeTitle)
        
        Button {
            isPlayingFirst.toggle()
            if isPlayingSecond {
                isPlayingSecond.toggle()
                AudioManager.shared.playVenusSound(
                    trackNumber: 3,
                    type: .mp3
                )
            }
            AudioManager.shared.playVenusSound(
                trackNumber: 1,
                type: .mp3
            )
        } label: {
            Label(
                isPlayingFirst ? "Stop" : "Hear first trivia",
                systemImage: isPlayingFirst ? "stop.fill" : "play.fill"
            )
        }
        .largeStyle(backgroundColor: isPlayingFirst ? .pink : .blue)
        
        Button {
            isPlayingSecond.toggle()
            if isPlayingFirst {
                isPlayingFirst.toggle()
                AudioManager.shared.playVenusSound(
                    trackNumber: 1,
                    type: .mp3
                )
            }
            AudioManager.shared.playVenusSound(
                trackNumber: 3,
                type: .mp3
            )
        } label: {
            Label(
                isPlayingSecond ? "Stop" : "Hear second trivia",
                systemImage: isPlayingSecond ? "stop.fill" : "play.fill"
            )
        }
        .largeStyle(backgroundColor: isPlayingSecond ? .pink : .blue)
    }
}

#Preview {
    VenusWikiView()
}
