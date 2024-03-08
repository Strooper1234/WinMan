//
//  ShortcutManager.swift
//  WinMan
//
//  Created by Felipe Rivera on 3/4/24.
//

import Foundation
import Cocoa

var isSuperShortcut = false
var eventMonitors = [Any]()

var isModifiedFlagActive = false
var isShortcutKeyActive = false
//let modifiers: [NSEvent.ModifierFlags] = [.shift, .control, .command]
let modifiers: NSEvent.ModifierFlags = .command //let shortcutKey: UInt16 = 0x0E // E
let shortcutKey = "e"

// gets call in the app init()
func setUpShortcutEvents() {
    let eventMask = (1 << CGEventType.keyDown.rawValue) | (1 << CGEventType.flagsChanged.rawValue) |  (1 << CGEventType.keyUp.rawValue)
    guard let eventTap = CGEvent.tapCreate(tap: .cgSessionEventTap,
                      place: .headInsertEventTap,
                      options: .defaultTap,
                      eventsOfInterest: CGEventMask(eventMask),
                      callback: { (proxy, type, event, refcon) -> Unmanaged<CGEvent>? in
                            handleEventTap(proxy: proxy, type: type, event: event, refcon: refcon)
                        },
                                           userInfo: nil) else {
        print("Failed to create event Tap for keybindings")
        return
    }
    
    let runLoopSource = CFMachPortCreateRunLoopSource(kCFAllocatorDefault, eventTap, 0)
    CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, .commonModes)
    CGEvent.tapEnable(tap: eventTap, enable: true)
    
    
}

func handleEventTap(proxy: CGEventTapProxy, type: CGEventType, event: CGEvent, refcon: UnsafeMutableRawPointer?) -> Unmanaged<CGEvent>? {
    guard let newEvent = NSEvent(cgEvent: event) else {return Unmanaged.passRetained(event)}
    if type == .keyDown {
        if handleKeyEvent(event: newEvent, isActive: true) {return nil}
    } else if type == .keyUp {
        if handleKeyEvent(event: newEvent, isActive: false) {return nil}
    } else if type == .flagsChanged {
        if handleFlagsChanged(event: newEvent) {return Unmanaged.passRetained(event)}
    }
    
    return Unmanaged.passRetained(event)
}

func handleFlagsChanged(event: NSEvent) -> Bool {
    // This function handles changes in the state of modifier keys
    let flags = event.modifierFlags.intersection(.deviceIndependentFlagsMask)
//    let flags = event.getIntegerValueField(.keyboardEventKeycode)
//    let command = 55
    print("Flags changed: \(flags)")
    
    if flags == modifiers {
        print("commands active")
        isModifiedFlagActive = true
    } else {
        print("commands inactive")
        isModifiedFlagActive = false
    }
    
    return false
}



func handleKeyEvent(event: NSEvent, isActive: Bool) -> Bool{
    
    if event.characters == shortcutKey && isShortcutKeyActive != isActive {
        isShortcutKeyActive = isActive
        print("Shortcut Key: \(isShortcutKeyActive)")
    }
    
    if isModifiedFlagActive && isShortcutKeyActive && !isSuperShortcut {
        isSuperShortcut = true
        PreviewWindowManager.shared.start(WindowManager.frontmostWindow())
        print("super shortcut active")
        return true
    } else if (!isModifiedFlagActive || !isShortcutKeyActive) && isSuperShortcut {
        isSuperShortcut = false
        TileManager.shared.assignPreviewToRealWindow()
        PreviewWindowManager.shared.end()
        print("super shortcut deactivate")
        return true
    } else if isSuperShortcut {
        if event.type == .keyDown {
            print("hello")
            handleArrowKeys(event: event)
        }
        return true
    }
    return false
}

func handleArrowKeys(event: NSEvent) {
    print("==CHecking arrows")
    switch event.characters {
    case "j":
        print("move preview left")
        WindowManager.moveWindowLeft()
    case "l":
        print("move preview right")
        WindowManager.moveWindowRight()
    case "k":
        print("move preview down")
        WindowManager.moveWindowDown()
    case "i":
        print("move preview up")
        WindowManager.moveWindowUp()
    default:
        break
    }
}

func deactivateSuperShortcut() {
    isSuperShortcut = false
    
//    for monitor in eventMonitors {
//        NSEvent.removeMonitor(monitor)
//    }
//    eventMonitors.removeAll()
    print("deactivate super shortcut")
}
