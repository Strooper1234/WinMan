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
