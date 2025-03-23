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
                
                // ***
                // This dynamic build number needs moved each time a new section is added!
                // ***
            """
            **Build \(Constants.appVersionBuildString)**:
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
