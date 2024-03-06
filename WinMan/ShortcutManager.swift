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
}

// gets call in the app init()
func setUpShortcutEvents() {
    KeyboardShortcuts.onKeyUp(for: .toggleTileOverlay) {
//        let windowManager = WindowManager()
//        windowManager.listAllWindowsTitles()
        PreviewToggleController.shared.toggleOverlay()
    }
}
