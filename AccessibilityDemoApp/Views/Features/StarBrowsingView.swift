//
//  StarBrowsingView.swift
//  AccessibilityDemoApp
//
//  Created by Jan Stusio on 25/01/2025.
//

import SwiftUI

struct StarBrowsingView: View {
    @State private var isShowingInstructions: Bool = false
    
    var body: some View {
        NavigationStack {
            Text("Explore sky").font(.title)
            ARSceneView(mode: .exploration)
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
                    InfoView(instructionMode: .explore)
                }
        }
    }
}


#Preview {
    StarBrowsingView()
}
