//
//  ButtonsAccView.swift
//  AccessibilityDemoApp
//
//  Created by Jan Stusio on 21/01/2025.
//

import SwiftUI

/// Accessible UX
struct ButtonsAccView: View {
    var body: some View {
        NavigationStack {
//            NavigationLink("Welcome view", destination: ContentView())
//                .accessibilityLabel(Text("Welcome view"))
            
            Button {
                // do something
            } label: {
                Label("Do nothing", systemImage: "scribble")
            }

        }
    }
}

#Preview {
    ButtonsAccView()
}
