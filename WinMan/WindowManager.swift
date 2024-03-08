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
//        PreviewWindowManager.shared.insertLeft(window)
//        TileManager.shared.insertWindowToLeft(window)
//        window.setPosition(position: CGPoint(x: 0, y: 500))
    }
    static func moveWindowRight() {
//        guard let window = frontmostWindow(), let screenSize = NSScreen.main?.frame.size  else {
//            print("Failed to get the frontmost window")
//            return
//        }
        if PreviewWindowManager.shared.state == .insideGrid {
            PreviewWindowManager.shared.adjustGridLocation(direction: .right, mode: .move)
        }
//        let newX = screenSize.width - window.size.width
//        window.setPosition(position: CGPoint(x: newX, y: 400))
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
