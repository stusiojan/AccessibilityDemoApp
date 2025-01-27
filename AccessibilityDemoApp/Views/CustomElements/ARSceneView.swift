//
//  ARSceneView.swift
//  AccessibilityDemoApp
//
//  Created by Jan Stusio on 27/01/2025.
//

import SwiftUI

// Main view that combines AR view with overlay
struct ARSceneView: View {
    @State private var nearestDistance: Float = 0
    @State private var lastDetectedObject: String = ""
     
    var body: some View {
        ZStack {
            // AR View
            CustomARView(nearestDistance: $nearestDistance) {body in
                myFunction(body)
            }
            
            // Crosshair overlay
            CrosshairView()
            
            // Distance indicator
            VStack {
                Spacer()
                VStack {
                    Text(String(format: "Distance: %.2f m", nearestDistance))
                    if !lastDetectedObject.isEmpty {
                        Text("Last detected: \(lastDetectedObject)")
                    }
                }
                .padding()
                .background(Color.black.opacity(0.7))
                .foregroundColor(.white)
                .cornerRadius(8)
                .padding(.bottom, 20)
            }
        }
        .padding(5)
        .clipShape(.capsule)
//        .edgesIgnoringSafeArea(.all)
    }
     
    func myFunction(_ cellestialBody: String) {
        print("Object \(cellestialBody) is close and centered!")
        lastDetectedObject = cellestialBody
        // TODO: Add haptic feedback
        // TODO: Play sound
    }
}
