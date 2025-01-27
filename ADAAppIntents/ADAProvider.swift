//
//  ADAProvider.swift
//  ADAAppIntents
//
//  Created by Jan Stusio on 27/01/2025.
//

import AppIntents

struct ADAProvider: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: OpenVenusWikiIntent(),
            phrases: ["Open Venus Wiki in demo app"],
            shortTitle: "Open Venus Wiki",
            systemImageName: "globe"
        )
    }
}
