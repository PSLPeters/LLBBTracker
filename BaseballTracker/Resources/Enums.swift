//
//  Enums.swift
//  BaseballTracker
//
//  Created by Michael Peters on 3/9/25.
//

import Foundation

// MARK: General Constants
enum Constants {
    static let appName = "LLBB Tracker©"
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    static let appBuild = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    static let appVersionBuildString = "\(Constants.appVersion!) (\(Constants.appBuild!))"
}

// MARK: Settings Constants
enum ConstantsSettings {
    static let settingsAboutHelpContactEmailAddress = "mpappshelp@icloud.com"
    static let settingsAboutHelpContactSubjectLine = "\(Constants.appName.replacingOccurrences(of: "©", with: "")) Feedback"
    static let settingsAboutHelpContactBody = "\n\nBuild: \(Constants.appVersionBuildString)"
    static let settingsAboutHelpPrivacyPolicyURL = "https://www.privacypolicies.com/live/d1790d80-dcb5-4be4-8a50-832566a0a2cb"
    
    static let settingsAboutAcknowledgementsDeveloperGitHubURL = "https://github.com/PSLPeters"
    static let settingsAboutAcknowledgementsPitchingGuidelinesWebsite = "littleleague.org"
    static let settingsAboutAcknowledgementsPitchingGuidelinesURL = "https://www.littleleague.org/playing-rules/pitch-count/#baseball"
}

// MARK: Alert Constants
enum ConstantsAlerts {
    static let cancelAddPitcherAlertTitle = "Close Pitcher?"
    static let cancelAddPitcherAlertMessage = "Pitcher information has been entered.\n\nAre you sure you would like to close this Pitcher and lose this unsaved information?"
    static let cancelAddPitcherAlertConfirmButtonTitle = "Yes"
    
    static let cancelAddGameAlertTitle = "Close Game?"
    static let cancelAddGameAlertMessage = "Game information has been entered.\n\nAre you sure you would like to close this Game and lose this unsaved information?"
    static let cancelAddGameAlertConfirmButtonTitle = "Yes"
}

// MARK: Focus Constants
enum FocusedField {
    case teamName
    case pitcherName
    case gameOpponent
    case gameAwayScore
    case gameHomeScore
}
