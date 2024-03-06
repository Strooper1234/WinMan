//
//  Window.swift
//  WinMan
//
//  Created by Felipe Rivera on 3/5/24.
//

import Foundation
import Cocoa

class Window {
    private var windowElement: AXUIElement
    var tileCells: [TileCell] = []
    
    init(_ windowElement: AXUIElement) {
        self.windowElement = windowElement
    }
    
    var position: CGPoint? {
        var positionRef: CFTypeRef?
        let result = AXUIElementCopyAttributeValue(self.windowElement, kAXPositionAttribute as CFString, &positionRef)
        
        guard result == .success, let positionValue = positionRef else {
            return CGPoint()
        }
        
        var point = CGPoint()
        AXValueGetValue(positionValue as! AXValue, .cgPoint, &point)
        return point
        
    }
    
    func setPosition(position: CGPoint?) {
        guard var newPoint = position, let newPositionValue = AXValueCreate(.cgPoint, &newPoint) else {return}
        AXUIElementSetAttributeValue(self.windowElement, kAXPositionAttribute as CFString, newPositionValue)
    }
    
    var size: CGSize {
        var sizeRef: CFTypeRef?
        let result = AXUIElementCopyAttributeValue(self.windowElement, kAXSizeAttribute as CFString, &sizeRef)
        
        guard result == .success, let sizeValue = sizeRef else {
            return CGSize()
        }
        
        var size = CGSize()
        AXValueGetValue(sizeValue as! AXValue, .cgSize, &size)
        return size
    }
    
    func setSize(size: CGSize?) {
        guard var newSize = size, let newSizeValue = AXValueCreate(.cgSize, &newSize) else {return}
        AXUIElementSetAttributeValue(self.windowElement, kAXSizeAttribute as CFString, newSizeValue)
    }
}
