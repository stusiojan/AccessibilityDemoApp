//
//  ADAAppIntents.swift
//  ADAAppIntents
//
//  Created by Jan Stusio on 27/01/2025.
//

import AppIntents
import AudioManager

struct OpenVenusWikiIntent: AppIntent {
    static var title: LocalizedStringResource = "Open Venus Wiki"
    static var description = IntentDescription("Opens the app and goes to Venus wiki.")
    static var openAppWhenRun: Bool = true
    
    @MainActor
    func perform() async throws -> some IntentResult {
        Navigator.shared.openTab(tab: .features)
        return .result()
    }
}
