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
        VStack {
            Text("Hello, world!").font(.title)
            
            Form {
                KeyboardShortcuts.Recorder("Toggle Tile Overlay", name: .toggleTileOverlay)
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
