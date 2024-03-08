//
//  previewWindow.swift
//  WinMan
//
//  Created by Felipe Rivera on 3/6/24.
//

import Foundation
import SwiftUI

struct GridLocation {
    var numRow = 0
    var numCol = 0
    var originRow = 0
    var originCol = 0
    
    var endRow: Int {
        return self.originRow + self.numRow
    }
    var endCol: Int {
        return self.originCol + self.numCol
    }
    
    var size: CGSize {
        return CGSize(width: self.numCol * TileManager.shared.cellWidth, height: self.numRow * TileManager.shared.cellHeight)
    }
    var pos: CGPoint {
        return CGPoint(x: self.originCol * TileManager.shared.cellWidth, y: self.originRow * TileManager.shared.cellHeight)
    }
    
    var hasSize: Bool {
        return self.numRow > 0 || self.numCol > 0
    }
}
enum PreviewState {
    case outOfGrid
    case insideGrid
}

class PreviewWindowManager: ObservableObject {
    static let shared = PreviewWindowManager()
    @Published var gridLocation = GridLocation()
    
    var pos: CGPoint = CGPoint()
    var size: CGSize = CGSize()
    var state = PreviewState.outOfGrid
    
    var isTouchingLeftEdge: Bool {
        return self.gridLocation.originCol == 0
    }
    var isTouchingRightEdge: Bool {
        return self.gridLocation.endCol == TileManager.shared.cols
    }
    var isTouchingTopEdge: Bool {
        return self.gridLocation.originRow == 0
    }
    var isTouchingBottomEdge: Bool {
        return self.gridLocation.endRow == TileManager.shared.rows
    }
    func start(_ window: Window?) {
//        TODO: check if the window is already managed by the TileManager
        if let window = window {
            self.pos = window.position
            self.size = window.size
        }
        
        
        PreviewWindowToggleController.shared.toggleOverlayOn()
//        calcRowsColsNeeded(window)
//        print(self.gridLocation.numCol, self.gridLocation.numCol)
    }
    
    func insertLeft(_ window: Window) {
        calcRowsColsNeeded(window)
        self.state = .insideGrid
    }
    
    func moveRight() {
        if self.isTouchingRightEdge {return}
        gridLocation.originCol += 1
    }
    func moveLeft() {
        if self.isTouchingLeftEdge {return}
        gridLocation.originCol -= 1
    }
    func moveDown() {
        if self.isTouchingBottomEdge {return}
        gridLocation.originRow += 1
    }
    func moveUp() {
        if self.isTouchingTopEdge {return}
        gridLocation.originRow -= 1
    }
    
    func calcRowsColsNeeded(_ window: Window) {
        self.gridLocation.numCol = Int(window.size.width) / TileManager.shared.cellWidth
        self.gridLocation.numRow = Int(window.size.height) / TileManager.shared.cellHeight
    }
    
    func end() {
        PreviewWindowToggleController.shared.toggleOverlayOff()
        if gridLocation.hasSize {
            let window = WindowManager.frontmostWindow()
            window?.setSize(size: self.gridLocation.size)
            window?.setPosition(position: self.gridLocation.pos)
        }
        self.gridLocation = GridLocation()
        self.state = .outOfGrid
    }
    
}

struct PreviewWindowView: View {
    @ObservedObject private var preWinMan = PreviewWindowManager.shared
    
    private var size: CGSize {
        return preWinMan.gridLocation.hasSize ? preWinMan.gridLocation.size : preWinMan.size
    }
    private var pos: CGPoint {
        return preWinMan.gridLocation.hasSize ? preWinMan.gridLocation.pos : preWinMan.pos
    }
    
    var body: some View {
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.orange, lineWidth: 3)
                .fill(Color.black.opacity(0.4))
                .frame(width: size.width, height: size.height)
                .offset(x: pos.x, y: pos.y)
//                .position(x: preRect.origin.x, y: preRect.origin.y)
        }
    }
}

class PreviewWindowToggleController: ObservableObject {
    static let shared = PreviewWindowToggleController()
    let previewController = PreviewController()
    
    func toggleOverlay() {
        if previewController.isOpen {
            previewController.close()
        } else {
            previewController.open(screen: NSScreen.main!, view: PreviewWindowView())
        }

    }
    func toggleOverlayOn() {
        previewController.open(screen: NSScreen.main!, view: PreviewWindowView())
    }
    func toggleOverlayOff() {
        previewController.close()
    }
}
