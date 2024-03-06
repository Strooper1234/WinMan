//
//  ContentView.swift
//  WinMan
//
//  Created by Felipe Rivera on 3/3/24.
//

import SwiftUI
import KeyboardShortcuts

struct ContentView: View {
    @State private var showPermissionsAlert = true
    let windowManager = WindowManager()
    
    var body: some View {
//        GridView()
        VStack {
            Text("Hello, world!").font(.title)
            
            Form {
                KeyboardShortcuts.Recorder("Toggle Tile Overlay", name: .toggleTileOverlay)
                KeyboardShortcuts.Recorder("Move Window Left", name: .moveWindowLeft)
                KeyboardShortcuts.Recorder("Move Window Right", name: .moveWindowRight)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
