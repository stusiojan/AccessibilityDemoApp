//
//  WelcomeView.swift
//  AccessibilityDemoApp
//
//  Created by Jan Stusio on 21/01/2025.
//

import SwiftUI

struct FeatureView: View {
    var body: some View {
        NavigationStack{
            NavigationLink(destination: StarBrowsingView()) {
                Label("Browse stars", systemImage: "sparkles")
                    .labelStyle(.titleAndIcon)
            }
            .largeStyle()
            NavigationLink(destination: StarTracingView()) {
                Label("Find moon", systemImage: "moon.stars.fill")
                    .labelStyle(.titleAndIcon)
            }
            .largeStyle()
            NavigationLink(destination: VenusWikiView()) {
                Label("Learn about Venus", systemImage: "microphone")
                    .labelStyle(.titleAndIcon)
            }
            .largeStyle()
            NavigationLink(destination: HapticsLibraryView()) {
                Label("Check haptics", systemImage: "water.waves")
                    .labelStyle(.titleAndIcon)
            }
            .largeStyle()
        }
    }
}

#Preview {
    FeatureView()
}
