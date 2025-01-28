//
//  ButtonsView.swift
//  AccessibilityDemoApp
//
//  Created by Jan Stusio on 21/01/2025.
//

import SwiftUI

/// Inaccessable UX
/// * moving elements
/// * no tags on buttons
/// * the text is not showed entirely
struct ButtonsView: View {
    @State private var isTextShown: Bool = false
    
    
    var body: some View {
        // VoiceOver reads it as "show! image" 
        CustomButton(sysImageTitle: "eye.fill", action: toggleText())
        
        if isTextShown {
            SongText()
        }
    }
    
    private func toggleText() -> () -> Void {
        return {
            self.isTextShown.toggle()
        }
    }
}

#Preview {
    ButtonsView()
}
