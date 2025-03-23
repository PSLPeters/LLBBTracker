//
//  SettingsReleaseNotesView.swift
//  BaseballTracker
//
//  Created by Michael Peters on 3/13/25.
//

import SwiftUI

struct SettingsReleaseNotesView: View {
    
    // MARK: AppStorage variables
    @AppStorage("selectedColorScheme") private var selectedColorScheme = "System"
    
    // MARK: Body
    var body: some View {
        ReleaseNotesView()
        .navigationTitle("Release Notes")
        .preferredColorScheme(selectedColorScheme == "System" ? nil : selectedColorScheme == "Dark" ? .dark : .light)
    }
}

// MARK: Preview
#Preview {
    SettingsReleaseNotesView()
}
