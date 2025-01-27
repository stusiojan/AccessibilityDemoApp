//
//  CrosshairView.swift
//  AccessibilityDemoApp
//
//  Created by Jan Stusio on 27/01/2025.
//

import SwiftUI

// Crosshair view
struct CrosshairView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .frame(width: 2, height: 20)
             
            Rectangle()
                .fill(Color.white)
                .frame(width: 20, height: 2)
        }
    }
}

#Preview {
    CrosshairView()
}
