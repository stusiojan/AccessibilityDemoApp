//
//  InfoView.swift
//  AccessibilityDemoApp
//
//  Created by Jan Stusio on 28/01/2025.
//

import SwiftUI

enum InstructionType {
    case explore, find
}

struct InfoView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let instructionMode: InstructionType
    @State private var info: String = "No instructions available"
    
    let exploreInfo: String = """
This is an Augmented Reality feature. Move around your phone to find out where Mars, Venus and Moon are. If your phone will point at any of these celestial bodies it will vibrate. 

If you want to find out what exactly it is, keep the phone pointed in this direction and the audio message will be played.
"""
    
    let findInfo: String = """
This is an Augmented Reality feature. Low sound should be player. The closer you are to pointing your phone to the moon, the higher it gets. When you locate moon, the phone will start to vibrate.

For this feature to work correctly, ensure your phone is not muted and its volume is not turned down to minimum.
"""
    
    var body: some View {
        NavigationStack {
            Text(info).padding()
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Label("Close instructions", systemImage: "chevron.left")
                        }
                    }
                }
        }
        .onAppear() {
            if instructionMode == .explore {
                info = exploreInfo
            } else if instructionMode == .find {
                info = findInfo
            } else {
                print("Error in getting instruction mode.")
            }
        }
    }
}

#Preview {
    InfoView(instructionMode: .explore)
}
