//
//  CustomButton.swift
//  AccessibilityDemoApp
//
//  Created by Jan Stusio on 21/01/2025.
//

import SwiftUI

/// Custom Button implementation
///
/// without labeling, not easy for understanding
/// button purpuse in voiceover
struct CustomButton: View {
    var title: String?
    var sysImageTitle : String?
    var action: () -> Void
    var xSize: CGFloat
    var ySize: CGFloat
    
    init(title: String? = nil, sysImageTitle: String? = nil, action: @escaping () -> Void = { print("tapped!") }, xSize: CGFloat = 200, ySize: CGFloat = 50) {
        self.title = title
        self.sysImageTitle = sysImageTitle
        self.action = action
        self.xSize = xSize
        self.ySize = ySize
        
        if title == nil && sysImageTitle == nil {
            self.title = "set title or sysImageTitle"
        }
    }
    
    var body: some View {
        if let sysImageTitle = sysImageTitle {
            Image(systemName: sysImageTitle)
                .frame(width: xSize, height: ySize)
                .background(Color.blue)
                .clipShape(.capsule)
                .foregroundColor(.white)
                .onTapGesture(perform: action)
        }
        if let title = title {
            Text(title)
                .frame(width: xSize, height: ySize)
                .background(Color.blue)
                .clipShape(.capsule)
                .foregroundColor(.white)
                .onTapGesture(perform: action)
        }
    }
}

#Preview {
    CustomButton()
}
