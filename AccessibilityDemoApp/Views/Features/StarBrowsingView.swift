//
//  StarBrowsingView.swift
//  AccessibilityDemoApp
//
//  Created by Jan Stusio on 25/01/2025.
//

import SwiftUI

struct StarBrowsingView: View {
    var body: some View {
        Text("Explore sky")
        ARSceneView(mode: .exploration)
    }
}


#Preview {
    StarBrowsingView()
}
