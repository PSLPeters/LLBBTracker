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
    static let appAppStoreID = "6743416831"
}

// MARK: Settings Constants
enum ConstantsSettings {
    static let settingsAboutHelpPrivacyPolicyURL = "https://www.privacypolicies.com/live/d1790d80-dcb5-4be4-8a50-832566a0a2cb"
    
    static let settingsAboutFeedbackContactEmailAddress = "mpappshelp@icloud.com"
    static let settingsAboutFeedbackContactSubjectLine = "\(Constants.appName.replacingOccurrences(of: "©", with: "")) Feedback"
    static let settingsAboutFeedbackContactBody = "\n\nBuild: \(Constants.appVersionBuildString)"
    
    static let settingsAboutFeedbackRateAppURL = "itms-apps://itunes.apple.com/app/id\(Constants.appAppStoreID)?mt=8&action=write-review"
    static let settingsAboutFeedbackShareAppURL = "https://apps.apple.com/us/app/llbb-tracker/id\(Constants.appAppStoreID)"
    
    static let settingsAboutAcknowledgementsDeveloperGitHubURL = "https://github.com/PSLPeters"
    static let settingsAboutAcknowledgementsPitchingGuidelinesWebsite = "littleleague.org"
    static let settingsAboutAcknowledgementsPitchingGuidelinesURL = "https://www.littleleague.org/playing-rules/pitch-count/#baseball"
}

// MARK: Alert Constants
enum ConstantsConfirmationDialogs {
    static let cancelAddPitcherConfirmationDialogMessage = "Pitcher information has been entered.\n\nAre you sure you would like to close this Pitcher and lose this unsaved information?"
    static let cancelAddPitcherConfirmationDialogConfirmButtonTitle = "Yes"
    
    static let cancelAddGameConfirmationDialogMessage = "Game information has been entered.\n\nAre you sure you would like to close this Game and lose this unsaved information?"
    static let cancelAddGameConfirmationDialogConfirmButtonTitle = "Yes"
}

// MARK: Focus Constants
enum FocusedField {
    case teamName
    case pitcherName
    case gameOpponent
    case gameAwayScore
    case gameHomeScore
}
