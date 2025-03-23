//
//  BaseballTrackerApp.swift
//  BaseballTracker
//
//  Created by Michael Peters on 3/9/25.
//

import SwiftUI
import SwiftData

@main
struct BaseballTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            MainTabView()
        }
        .modelContainer(for: [modelPitcher.self, modelGame.self])
    }
}
