//
//  TileManager.swift
//  WinMan
//
//  Created by Felipe Rivera on 3/4/24.
//

import Foundation
import Cocoa
import SwiftUI

struct TileCell {
    var row: Int
    var col: Int
}

class TileManager: ObservableObject {
    
    static let shared = TileManager()
    
    let rows: Int
    let cols: Int
    let cellWidth: Int
    let cellHeight: Int
    
    var grid: [[TileCell]]
    
    init() {
        guard let screen = NSScreen.main else {
            fatalError("Main Screen is nil")
        }
        let screenSize = screen.frame.size
        
        self.rows = 3
        self.cols = 6
        
        self.cellWidth = Int(screenSize.width) / cols
        self.cellHeight = Int(screenSize.height) / rows
        
        self.grid = []
        for r in 0..<rows {
            var row: [TileCell] = []
            for c in 0..<cols {
                row.append(TileCell(row: r, col: c))
            }
            self.grid.append(row)
        }
        
        print(grid)
        
    }
}



struct GridView: View {
    @ObservedObject var tileManager = TileManager.shared
    
    var body: some View {
        GeometryReader { geometry in
            // Use ForEach for iteration in SwiftUI
            ForEach(0..<tileManager.rows, id: \.self) { rowIndex in
                ForEach(0..<tileManager.cols, id: \.self) { colIndex in
                    // Access the cell using row and column indices
                    let cell = tileManager.grid[rowIndex][colIndex]
                    
                    let padding: CGFloat = 20
                    let cellWidth = CGFloat(tileManager.cellWidth) - padding  // Convert to CGFloat
                    let cellHeight = CGFloat(tileManager.cellHeight) - padding // Convert to CGFloat
                    
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.mint.opacity(0.9), lineWidth: 3)
                        .fill(Color.mint.opacity(0.1))
                        .frame(width: cellWidth, height: cellHeight)
                        .overlay(
                            Text("\(cell.row), \(cell.col)")
                                .foregroundColor(.black)
                                
                        )
                        .position(x: CGFloat(cell.col) * CGFloat(tileManager.cellWidth) + CGFloat(tileManager.cellWidth)/2,
                                  y: CGFloat(cell.row) * CGFloat(tileManager.cellHeight) + CGFloat(tileManager.cellHeight)/2)
//                    Text("\(cell.row), \(cell.col)")
//                        .frame(width: cellWidth, height: cellHeight)
//                        .background(Color.gray.opacity(0.3))
//                        .border(Color.black, width: 1)
//                        .position(x: CGFloat(cell.col) * cellWidth + cellWidth / 2,
//                                  y: CGFloat(cell.row) * cellHeight + cellHeight / 2)
                }
            }
        }
    }
}

#Preview {
    GridView()
}
