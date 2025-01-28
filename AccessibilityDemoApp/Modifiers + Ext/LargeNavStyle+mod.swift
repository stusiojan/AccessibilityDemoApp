//
//  AccModifiers.swift
//  AccessibilityDemoApp
//
//  Created by Jan Stusio on 25/01/2025.
//
/*
 Modifier that uses:
 -user system accent color in case it should has more contrast than typically
 -system text sizes, so they could be scaled according to user sys. settings
 */


import SwiftUI

struct LargeNavigationStyle: ViewModifier {
    var backgroundColor: Color = .accentColor
    var foregroundColor: Color = .primary
    var horizontalPadding: CGFloat = 16
    
    func body(content: Content) -> some View {
        content
            .font(.title2)
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .clipShape(.capsule)
            .padding(.horizontal, horizontalPadding)
    }
}

extension Label {
    func largeStyle(
        backgroundColor: Color = .accentColor,
        foregroundColor: Color = .primary,
        horizontalPadding: CGFloat = 16
    ) -> some View {
        modifier(LargeNavigationStyle(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            horizontalPadding: horizontalPadding
        ))
    }
}

extension NavigationLink {
    func largeStyle(
        backgroundColor: Color = .accentColor,
        foregroundColor: Color = .primary,
        horizontalPadding: CGFloat = 16
    ) -> some View {
        modifier(LargeNavigationStyle(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            horizontalPadding: horizontalPadding
        ))
    }
}

extension Button {
    func largeStyle(
        backgroundColor: Color = .accentColor,
        foregroundColor: Color = .primary,
        horizontalPadding: CGFloat = 16
    ) -> some View {
        modifier(LargeNavigationStyle(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            horizontalPadding: horizontalPadding
        ))
    }
}

