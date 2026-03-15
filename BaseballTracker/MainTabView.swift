//
//  ContentView.swift
//  BaseballTracker
//
//  Created by Michael Peters on 3/9/25.
//

import SwiftUI

struct MainTabView: View {
    
    // MARK: AppStorage variables
    @AppStorage("selectedMainTab") private var selectedMainTab = ""
    
    // MARK: Body
    var body: some View {
        if #available(iOS 26.0, *) {
            StartTabView()
                .tabBarMinimizeBehavior(.onScrollDown)
        } else {
            StartTabView()
        }
    }
}

struct StartTabView: View {

    // MARK: AppStorage variables
    @AppStorage("selectedColorScheme") private var selectedColorScheme = "System"
    @AppStorage("selectedAppTintIndex") var selectedAppTintIndex = 0
    @AppStorage("selectedMainTab") private var selectedMainTab = ""
    @AppStorage("selectedDefaultTabIndex") private var selectedDefaultTabIndex = 0
    @AppStorage("doHaptics") private var doHaptics = true
    
    // MARK: Body
    var body: some View {
        
        // MARK: Calculated variables
        var hapticsIntensity: Double {
            doHaptics ? 1.0 : 0.0
        }
        
        var defaultMainTab: String {
            switch (arrDefaultTabs[selectedDefaultTabIndex].name) {
            case "Remember Selection":
                return selectedMainTab
            default:
                return arrDefaultTabs[selectedDefaultTabIndex].name
            }
        }
        
        TabView(selection: $selectedMainTab) {
            PitchersMainView()
                .tabItem {
                    Label("Pitchers", systemImage: "baseball")
                }
                .tag("Pitches")
            
            GamesMainView()
                .tabItem {
                    Label("Games", systemImage: "baseball.diamond.bases.outs.indicator")
                }
                .tag("Games")
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
                .tag("Settings")
        }
        .sensoryFeedback(.impact(flexibility: .solid, intensity: hapticsIntensity), trigger: selectedMainTab)
        .tint(arrAppTints[selectedAppTintIndex].color)
        .preferredColorScheme(selectedColorScheme == "System" ? nil : selectedColorScheme == "Dark" ? .dark : .light)
        .onAppear {
            selectedMainTab = defaultMainTab
        }
    }
}

// MARK: Preview
#Preview {
    MainTabView()
}
