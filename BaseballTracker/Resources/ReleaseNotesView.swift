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
            **Build 1.1 (1)**:
            - New icon added - "BaseBilly"!
            - Added Rate App button to easily rate the app in the App Store.
            - Added Share App button to easily share the app with friends and family.
            
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
