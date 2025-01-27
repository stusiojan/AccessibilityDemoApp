//
//  ContentView.swift
//  AccessibilityDemoApp
//
//  Created by Jan Stusio on 21/01/2025.
//

import SwiftUI

struct ContentView: View {

    @Bindable var navigator: Navigator
    
    var body: some View {
        TabView(selection: $navigator.selectedTab){
///            Will be deporiciated in future in benefit of Tab()
///            Without accessibilityLabel it would be missread by VoiceOver
//            FeatureView()
//                .accessibilityLabel("Welcome Page")
//                .tabItem {
//                    Image(systemName: "house")
//                    Text("Welcome")
//                }
            
            Tab("Accessible buttons", systemImage: "accessibility.fill", value: 0) {
                ButtonsAccView()
            }
            .badge(5)   // TODO: How it is voiced over?
            
            Tab("Inaccesible buttons", systemImage: "circle.dashed", value: 1) {
                ButtonsView()
            }
            .badge("!")
            
            Tab("Features", systemImage: "hammer.circle", value: 2) {
                FeatureView()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView(navigator: Navigator.shared)
}
