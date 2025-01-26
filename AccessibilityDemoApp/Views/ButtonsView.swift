//
//  ButtonsView.swift
//  AccessibilityDemoApp
//
//  Created by Jan Stusio on 21/01/2025.
//

import SwiftUI

struct ButtonsView: View {
    @State private var isTextShown: Bool = false
    private let text: String = """
    Hallo Bimmelbahn, es war vor deiner letzten Fahrt. Ich stand mit einem Mädchen am Bahnhof und wir sahen dich an.
    Sie sprang auf einen Wagen, da kam das Zeichen: Vorsicht, Bahnsteig frei. Die Bimmelbahn, sie zischte, mein Liebling rollte mit vorbei. ﻿

    Refrain: Und ich rief ihr nach: Laß mich doch bitte nicht allein. 2x Bye-bye!

    Hallo, Bimmelbahn, du wartest irgendwo am Abstellgleis. ich frage wo du stehst, doch keinen gibt es, der dein Ziel noch weiß.
    Mein Mädchen ist bei dir und ein Leben ohne sie, das will ich﻿ nicht. Ich habe große Angst, dass sie mich eines Tages vergisst.

    Refrain: Und ich rief ihr nach: Laß mich doch bitte nicht allein. 2x Bye-bye!

    Hallo Bimmelbahn, du bist die letzte﻿ Lok in deiner Art. Und ein Stück Romantik ist vorbei seit deiner Abschiedsfahrt.
    Auf dein langes Pfeifen und Stampfen wart’ ich jeden Augenblick. Hallo Bimmelbahn, bitte bring’ sie bald zu mir zurück.

    Refrain: Und ich rief ihr nach: Laß mich doch bitte nicht allein. 2x Bye-bye!
    """
    
    var body: some View {
        CustomButton(sysImageTitle: "eye.fill", action: toggleText())
        
        if isTextShown {
            Text(text)
                .padding()
        }
    }
    
    private func toggleText() -> () -> Void {
        return {
            self.isTextShown.toggle()
        }
    }
}

#Preview {
    ButtonsView()
}
