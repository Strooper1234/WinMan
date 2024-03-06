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
    
    static func moveWindowLeft() {
        guard let frontmostApp = NSWorkspace.shared.frontmostApplication else {
            print("No frontmost application found.")
            return
        }
        
        let appRef = AXUIElementCreateApplication(frontmostApp.processIdentifier)
        guard let windowRef = getFocusedWindowElement(from: appRef) else {
            print("Failed to get focused window of the frontmost application.")
            return
        }
        adjustWindowPosition(window: windowRef, xOffset: -100)
    }
    static func moveWindowRight() {
        guard let frontmostApp = NSWorkspace.shared.frontmostApplication else {
            print("No frontmost application found.")
            return
        }
        
        let appRef = AXUIElementCreateApplication(frontmostApp.processIdentifier)
        guard let windowRef = getFocusedWindowElement(from: appRef) else {
            print("Failed to get focused window of the frontmost application.")
            return
        }
        var sizeRef: CFTypeRef?
//        let value = windowRef.getValue(.size)
        let sizeResult = AXUIElementCopyAttributeValue(windowRef, kAXSizeAttribute as CFString, &sizeRef)
        guard sizeResult == .success, let sizeValue = sizeRef else {
            print("Unable to get size")
            return
        }
        print(sizeValue)
        print(sizeValue.values)
        
        
        adjustWindowPosition(window: windowRef, xOffset: 100)
    }
    
    private static func getFocusedWindowElement(from app: AXUIElement) -> AXUIElement? {
        var value: AnyObject?
        let result = AXUIElementCopyAttributeValue(app, kAXFocusedWindowAttribute as CFString, &value)
        if result == .success, let windowElement = value as! AXUIElement? {
           return windowElement
        } else {
           return nil
        }
    }
    
    private static func adjustWindowPosition(window: AXUIElement, xOffset: CGFloat) {
        var positionRef: CFTypeRef?
        let positionResult = AXUIElementCopyAttributeValue(window, kAXPositionAttribute as CFString, &positionRef)
        
        guard positionResult == .success, let positionValue = positionRef else {
            print("Unable to get window position.")
            return
        }
        
        var point = CGPoint()
        if AXValueGetTypeID() == CFGetTypeID(positionValue),
           AXValueGetValue(positionValue as! AXValue, .cgPoint, &point) {
            point.x += xOffset
            
            if let newPositionValue = AXValueCreate(.cgPoint, &point) {
                AXUIElementSetAttributeValue(window, kAXPositionAttribute as CFString, newPositionValue)
            }
        }
    }
}
