//
//  ContentView.swift
//  AccessibilityDemoApp
//
//  Created by Jan Stusio on 21/01/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
///            Will be deporiciated in future in benefit of Tab()
///            Without accessibilityLabel it would be missread by VoiceOver
//            WelcomeView()
//                .accessibilityLabel("Welcome Page")
//                .tabItem {
//                    Image(systemName: "house")
//                    Text("Welcome")
//                }
            
            Tab("Accessible buttons", systemImage: "accessibility.fill") {
                ButtonsAccView()
            }
            .badge(5)   // TODO: How it is voiced over?
            
            Tab("Inaccesible buttons", systemImage: "circle.dashed") {
                ButtonsView()
            }
            .badge("!")
            
            Tab("Features", systemImage: "hammer.circle") {
                FeatureView()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
