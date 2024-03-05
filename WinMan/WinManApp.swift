//
//  WinManApp.swift
//  WinMan
//
//  Created by Felipe Rivera on 3/3/24.
//

import SwiftUI
import Cocoa

@main
struct WinManApp: App {

    init() {
        requestAccessibilityPermissions()
        let windowManager = WindowManager()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    func requestAccessibilityPermissions() {
        let options = [kAXTrustedCheckOptionPrompt.takeRetainedValue() as NSString: true]
        let accessEnabled = AXIsProcessTrustedWithOptions(options as CFDictionary)

        if !accessEnabled {
            print("Accessibility access is not enabled, Please grant access.")
        } else {
            print("Accessibility is ENABLED!")
        }
    }
}
