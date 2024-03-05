//
//  ShortcutManager.swift
//  WinMan
//
//  Created by Felipe Rivera on 3/4/24.
//

import Foundation
import KeyboardShortcuts

extension KeyboardShortcuts.Name {
    static let windowTitle = Self("windowTitle")
}

// gets call in the app init()
func setUpShortcutEvents() {
    KeyboardShortcuts.onKeyUp(for: .windowTitle) {
        let windowManager = WindowManager()
        windowManager.listAllWindowsTitles()
    }
}
