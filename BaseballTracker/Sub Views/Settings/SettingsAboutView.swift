//
//  SettingsAboutView.swift
//  BaseballTracker
//
//  Created by Michael Peters on 3/9/25.
//

import SwiftUI

struct SettingsAboutView: View {
    
    // MARK: AppStorage variables
    @AppStorage("selectedColorScheme") private var selectedColorScheme = "System"
    
    // MARK: @State variables
    
    // MARK: Body
    var body: some View {
        NavigationStack {
            List {
                Section("App Information") {
                    LabeledContent("Version") {
                        Text(Constants.appVersionBuildString)
                    }
                }
                Section("Help") {
                    NavigationLink {
                        SettingsReleaseNotesView()
                            .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        Label("Release Notes", systemImage: "book")
                    }
                    Link(destination: URL(string: ConstantsSettings.settingsAboutHelpPrivacyPolicyURL)!) {
                        Label("Privacy Policy", systemImage: "safari")
                    }
                }
                .tint(.secondary)
                Section("Feedback") {
                    Link(destination: URL(string: "mailto:\(ConstantsSettings.settingsAboutFeedbackContactEmailAddress)?subject=\(ConstantsSettings.settingsAboutFeedbackContactSubjectLine)&body=\(ConstantsSettings.settingsAboutFeedbackContactBody)")!) {
                        Label("Contact", systemImage: "envelope")
                    }
                    Button {
                        UIApplication.shared.open(URL(string : ConstantsSettings.settingsAboutFeedbackRateAppURL)!)
                    } label: {
                        Label("Rate App", systemImage: "star")
                    }
                    ShareLink(item: URL(string: ConstantsSettings.settingsAboutFeedbackShareAppURL)!) {
                        Label("Share App", systemImage: "square.and.arrow.up")
                    }
                }
                .tint(.secondary)
                Section() {
                    LabeledContent("Developed By") {
                        HStack {
                            Text("Michael Peters")
                            Divider()
                            Link("GitHub", destination: URL(string: ConstantsSettings.settingsAboutAcknowledgementsDeveloperGitHubURL)!)
                                .buttonStyle(.borderless)
                        }
                    }
                    LabeledContent("Pitching Guidelines") {
                        Link(ConstantsSettings.settingsAboutAcknowledgementsPitchingGuidelinesWebsite, destination: URL(string: ConstantsSettings.settingsAboutAcknowledgementsPitchingGuidelinesURL)!)
                            .buttonStyle(.borderless)
                    }
                } header: {
                    Text("Acknowledgments")
                } footer: {
                    Text("Maximum pitches per age group as well as required days rest provided by \(ConstantsSettings.settingsAboutAcknowledgementsPitchingGuidelinesWebsite).")
                }
            }
        }
        .navigationTitle("About")
        .preferredColorScheme(selectedColorScheme == "System" ? nil : selectedColorScheme == "Dark" ? .dark : .light)
        .interactiveDismissDisabled(true)
    }
}

// MARK: Preview
#Preview {
    SettingsAboutView()
}
