//
//  Navigator.swift
//  AccessibilityDemoApp
//
//  Created by Jan Stusio on 27/01/2025.
//

import Foundation
import SwiftUICore

@Observable
class Navigator {
    static let shared = Navigator()
    var selectedTab: Int = Tabs.accessibleButtons.rawValue
    
    private init() {}
    
    public func openTab(tab: Tabs) {
        selectedTab = Tabs.features.rawValue
    }
}

enum Tabs: Int {
    case accessibleButtons = 0
    case buttons = 1
    case features = 2
}
