//
//  PreviewController.swift
//  WinMan
//
//  Created by Felipe Rivera on 3/5/24.
//

import Foundation
import SwiftUI

class PreviewController {
    private var previewWindowController: NSWindowController?
    private var screen: NSScreen = NSScreen.screens.first ?? NSScreen()
    var isOpen = false
    
    func open(screen: NSScreen = NSScreen.main ?? NSScreen()) {
        if let windowController = previewWindowController {
            windowController.window?.orderFrontRegardless()
            return
        }
        self.screen = screen
        
        let panel = NSPanel(contentRect: .zero, 
                            styleMask: [.borderless, .nonactivatingPanel],
                            backing: .buffered,
                            defer: true,
                            screen: screen)
        panel.hasShadow = false
        panel.backgroundColor = NSColor.clear
        panel.level = NSWindow.Level(NSWindow.Level.screenSaver.rawValue - 1)
        panel.contentView = NSHostingView(rootView: GridView())
        panel.collectionBehavior = .canJoinAllSpaces
        panel.alphaValue = 0
        panel.ignoresMouseEvents = true
        panel.orderFrontRegardless()
        
        panel.setFrame(screen.frame, display: false)
        
        previewWindowController = NSWindowController(window: panel)
        
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 0.5
            panel.animator().alphaValue = 1
        })
        
        self.isOpen = true
    }
    
    func close() {
        guard let windowController = previewWindowController else { return }
        previewWindowController = nil

        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 0.5 // Adjust fade-out duration if needed
            windowController.window?.animator().alphaValue = 0
        }, completionHandler: {
            windowController.close()
        })
        self.isOpen = false
    }

    // Optional: Function to switch screens, might need adjustment based on your use case
    func setScreen(to screen: NSScreen) {
        guard let _ = previewWindowController, screen != self.screen else {
            return
        }
        self.close()
        self.open(screen: screen)
    }
}

class PreviewToggleController: ObservableObject {
    static let shared = PreviewToggleController()
    let previewController = PreviewController()
    
    func toggleOverlay() {
        if previewController.isOpen {
            previewController.close()
        } else {
            previewController.open(screen: NSScreen.main!)
        }

    }
}
