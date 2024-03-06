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
    
    
    func frontmostWindow() -> Window? {
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
    
    func moveWindowLeft() {
        guard let window = frontmostWindow() else {
            print("Failed to get the frontmost window")
            return
        }
        print(window)
        window.setPosition(position: CGPoint(x: 0, y: 500))
    }
    func moveWindowRight() {
        guard let window = frontmostWindow(), let screenSize = NSScreen.main?.frame.size  else {
            print("Failed to get the frontmost window")
            return
        }
        let newX = screenSize.width - window.size.width
        window.setPosition(position: CGPoint(x: newX, y: 400))
    }
    
}
