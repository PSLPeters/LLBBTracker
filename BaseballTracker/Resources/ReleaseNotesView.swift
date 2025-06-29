//
//  ReleaseNotesView.swift
//  BaseballTracker
//
//  Created by Michael Peters on 3/13/25.
//

import SwiftUI

struct ReleaseNotesView: View {
    
    // MARK: AppStorage variables
    @AppStorage("selectedColorScheme") private var selectedColorScheme = "System"
    
    // MARK: ABody
    var body: some View {
        ScrollView {
            Text(
            """
            **Build 1.2 (0)**:
            - Welcome to iOS 26! Updated elements throughout the app to support Liquid Glass!
            - Changed Alerts to ConfirmationDialogs to utilize the iOS 26 design change making the selection easier for users.
            
            **Build 1.1 (1)**:
            - New icon added - "BaseBilly", courtesy of DabbleArt!
            - Added Rate App button to allow you to easily rate the app in the App Store.
            - Added Share App button to help you quickly share the app with your fellow parents, coaches and friends.
            
            **Build 1.0 (1)**:
            - \(Image(systemName: "baseball")) Initial release of \(Constants.appName.replacingOccurrences(of: "©", with: ""))!
            """)
            .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .padding()
        .preferredColorScheme(selectedColorScheme == "System" ? nil : selectedColorScheme == "Dark" ? .dark : .light)
    }
}

// MARK: Preview
#Preview {
    ReleaseNotesView()
}
