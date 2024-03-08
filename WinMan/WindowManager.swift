//
//  WindowManager.swift
//  WinMan
//
//  Created by Felipe Rivera on 3/4/24.
//

import Foundation
import Cocoa
import SwiftUI

class WindowManager {
    
    
    static func frontmostWindow() -> Window? {
        guard let frontmostApp = NSWorkspace.shared.frontmostApplication else {
            return nil
        }
        let appRef = AXUIElementCreateApplication(frontmostApp.processIdentifier)
        
        var value: AnyObject?
        let result = AXUIElementCopyAttributeValue(appRef, kAXFocusedWindowAttribute as CFString, &value)
        print(result)
        if result == .success {
            let windowElement = value as! AXUIElement
            return Window(windowElement)
        } else {
            return nil
        }
    }
    
    static func moveWindowLeft() {
        guard let window = frontmostWindow() else {
            print("Failed to get the frontmost window")
            return
        }
        print(window)
        switch PreviewWindowManager.shared.state {
        case .outOfGrid:
            PreviewWindowManager.shared.insertLeft(window)
        case .insideGrid:
            PreviewWindowManager.shared.adjustGridLocation(direction: .left, mode: .move)
        }
    }
    static func moveWindowRight() {
        if PreviewWindowManager.shared.state == .insideGrid {
            PreviewWindowManager.shared.adjustGridLocation(direction: .right, mode: .move)
        }
    }
    static func moveWindowDown() {
        if PreviewWindowManager.shared.state == .insideGrid {
            PreviewWindowManager.shared.adjustGridLocation(direction: .down, mode: .move)
        }
    }
    static func moveWindowUp() {
        if PreviewWindowManager.shared.state == .insideGrid {
            PreviewWindowManager.shared.adjustGridLocation(direction: .up, mode: .move)
        }
    }
    
}
