//
//  StarTracingView.swift
//  AccessibilityDemoApp
//
//  Created by Jan Stusio on 25/01/2025.
//

import AudioManager
import SwiftUI

struct StarTracingView: View {
    @State private var distance: Float = 0.0
    
    var body: some View {
        VStack{
            Text("Find moon!").font(.largeTitle)
            Text("Changing distance will affect track pitch")
            
            Slider(value: $distance, in: -2400...2400).padding()
            Text("Distance: \(distance)")
        }
        .onAppear() {
            do {
                try AudioEngine.shared.play("Venus1")
            } catch {
                print("Error in playing audio: \(error)")
            }
            
        }
        .onChange(of: distance) {
            print("pitch changed to \(distance)")
            AudioEngine.shared.setPitch(distance)
        }
    }
}

#Preview {
    StarTracingView()
}
