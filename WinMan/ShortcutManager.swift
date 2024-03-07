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

// gets call in the app init()
func setUpShortcutEvents() {
    
    let keyEventMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.keyDown, .keyUp]) { event in
        handleKeyEvent(event: event, isActive: event.type == .keyDown)
    }
    
    let flagsChangedMonitor = NSEvent.addGlobalMonitorForEvents(matching: .flagsChanged) { event in
        handleFlagsChanged(event: event)
    }
    
    
    if let keyEventMonitor = keyEventMonitor, let flagsChangedMonitor = flagsChangedMonitor {
        eventMonitors.append(contentsOf: [keyEventMonitor, flagsChangedMonitor])
    }
}

func activateSuperShortcut() {
    isSuperShortcut = true
}


var isModifiedFlagActive = false
var isShortcutKeyActive = false
let modifiers: [NSEvent.ModifierFlags] = [.shift, .control, .command]
let shortcutKey: UInt16 = 0x0E // E

func handleFlagsChanged(event: NSEvent) {
    // This function handles changes in the state of modifier keys
    let flags = event.modifierFlags.intersection(.deviceIndependentFlagsMask)
    print("Flags changed: \(flags)")
    
    if flags == [.shift, .control, .command] {
        print("shifty")
        isModifiedFlagActive = true
    } else {
        isModifiedFlagActive = false
    }
}



func handleKeyEvent(event: NSEvent, isActive: Bool) {
    
    if event.keyCode == shortcutKey && isShortcutKeyActive != isActive {
        isShortcutKeyActive = isActive
        print("Shortcut Key: \(isShortcutKeyActive)")
    }
    
    if isModifiedFlagActive && isShortcutKeyActive && !isSuperShortcut {
        isSuperShortcut = true
        print("super shortcut active")
        
    } else if (!isModifiedFlagActive || !isShortcutKeyActive) && isSuperShortcut {
        isSuperShortcut = false
        print("super shortcut deactivate")
    } else if isSuperShortcut {
        if event.type == .keyDown {
            handleArrowKeys(event: event)
        }
    }
}

func handleArrowKeys(event: NSEvent) {
    switch event.keyCode {
    case 0x7B:
        print("move preview left")
    case 0x7c:
        print("move preview right")
    case 0x7D:
        print("move preview down")
    case 0x7E:
        print("move preview up")
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
