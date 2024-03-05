//
//  WindowManager.swift
//  WinMan
//
//  Created by Felipe Rivera on 3/4/24.
//

import Foundation
import Cocoa

class WindowManager {
    func listAllWindowsTitles() {
        print("HEY there")
        let windows = NSWorkspace.shared.runningApplications
//        print(windows)
        
        let window = NSWorkspace.shared.frontmostApplication
        print(window)
        
//        for window in windows {
//            print(window.title)
//        }
    }
}
