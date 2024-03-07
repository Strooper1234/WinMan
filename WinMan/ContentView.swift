//
//  ContentView.swift
//  WinMan
//
//  Created by Felipe Rivera on 3/3/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showPermissionsAlert = true
    let windowManager = WindowManager()
    
    var body: some View {
//        GridView()
        VStack {
            Text("Hello, world!").font(.title)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
