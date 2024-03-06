//
//  ShortcutManager.swift
//  WinMan
//
//  Created by Felipe Rivera on 3/4/24.
//

import Foundation
import KeyboardShortcuts

extension KeyboardShortcuts.Name {
    static let toggleTileOverlay = Self("toggleTileOverlay")
    static let moveWindowLeft = Self("moveWindowLeft")
    static let moveWindowRight = Self("moveWindowRight")
}

// gets call in the app init()
func setUpShortcutEvents() {
    KeyboardShortcuts.onKeyUp(for: .toggleTileOverlay) {
//        let windowManager = WindowManager()
//        windowManager.listAllWindowsTitles()
        PreviewToggleController.shared.toggleOverlay()
    }
    KeyboardShortcuts.onKeyUp(for: .moveWindowLeft) {
        print("Move Left")
        WindowManager.moveWindowLeft()
    }
    KeyboardShortcuts.onKeyUp(for: .moveWindowRight) {
        print("Move Right")
        WindowManager.moveWindowRight()
    }
}
