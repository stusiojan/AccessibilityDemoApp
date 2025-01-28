//
//  AudioManager.swift
//  AccessibilityDemoApp
//
//  Created by Jan Stusio on 26/01/2025.
//

import Foundation
import AVFoundation
import AudioManager

extension AudioManager {
    func playVenusSound(trackNumber: Int = 1, type: AudioFormat) {
        AudioManager.shared.playOrStopAudio(audioFileName: "venus\(trackNumber)", audioFileType: type.rawValue)
    }
    
    func playShortDesription(_ name: String, type: AudioFormat = .m4a) {
        AudioManager.shared.playOrStopAudio(audioFileName: "\(name)2", audioFileType: type.rawValue)
    }
}

enum AudioFormat: String {
    case wav, mp3, m4a
}
