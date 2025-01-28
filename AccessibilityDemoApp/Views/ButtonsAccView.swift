//
//  ButtonsAccView.swift
//  AccessibilityDemoApp
//
//  Created by Jan Stusio on 21/01/2025.
//

import SwiftUI

/// Accessible UX
struct ButtonsAccView: View {
    @State private var isTextShown: Bool = false
    
    var body: some View {
        Button {
            isTextShown.toggle()
        } label: {
            Label(
                isTextShown
                ? "Hide song lyrics"
                : "Show song lyrics",
                systemImage: "eye.fill"
            )
            .largeStyle(
                backgroundColor:
                    isTextShown
                    ? .pink
                    : .blue,
                foregroundColor: .white
            )
        }
        Spacer()
        if isTextShown {
            ScrollView {
                SongText().padding()
            }
        }
    }
}

#Preview {
    ButtonsAccView()
}
