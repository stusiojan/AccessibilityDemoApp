//
//  StarTracingView.swift
//  AccessibilityDemoApp
//
//  Created by Jan Stusio on 25/01/2025.
//

import AudioManager
import SwiftUI

struct StarTracingView: View {
    @State private var isShowingInstructions: Bool = false
    
    var body: some View {
        NavigationStack {
            Text("Find moon").font(.title)
            ARSceneView(mode: .tracking)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            isShowingInstructions = true
                        } label: {
                            Label("Show instruction", systemImage: "info.circle")
                                .labelStyle(.iconOnly)
                        }
                    }
                }
                .sheet(isPresented: $isShowingInstructions) {
                    InfoView(instructionMode: .find)
                }
        }
    }
}

#Preview {
    StarTracingView()
}
