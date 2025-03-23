//
//  PickerData.swift
//  BaseballTracker
//
//  Created by Michael Peters on 3/9/25.
//

import Foundation
import SwiftUI

// MARK: Color Schemes
struct colorScheme : Identifiable {
    let id = UUID()
    let name : String
    let image : Image
}

let arrColorSchemes =
    [
        colorScheme(name: "System", image: Image(systemName: "lightbulb.led")),
        colorScheme(name: "Dark", image: Image(systemName: "lightbulb")),
        colorScheme(name: "Light", image: Image(systemName: "lightbulb.fill"))
    ]

// MARK: App Icons
struct appIcon : Identifiable {
    let id = UUID()
    let appIconName : String
    let imageName : String
    let description : String
}

let arrAppIcons =
    [
        appIcon(appIconName: "AppIcon1", imageName: "IconImage1", description: "Factory Fresh"),
        appIcon(appIconName: "AppIcon2", imageName: "IconImage2", description: "Clean-Up Hitter"),
        appIcon(appIconName: "AppIcon3", imageName: "IconImage3", description: "Home Run Derby"),
        appIcon(appIconName: "AppIcon4", imageName: "IconImage4", description: "Slugger"),
        appIcon(appIconName: "AppIcon5", imageName: "IconImage5", description: "Grand Slam"),
        appIcon(appIconName: "AppIcon6", imageName: "IconImage6", description: "Bases Loaded")
    ]

// MARK: App Tints
struct appTint : Identifiable {
    let id = UUID()
    let text : String
    let color : Color
}

let arrAppTints =
    [
        appTint(text: "Blue (Default)", color: .blue),
        appTint(text: "Brown", color: .brown),
        appTint(text: "Cyan", color: .cyan),
        appTint(text: "Gray", color: .gray),
        appTint(text: "Green", color: .green),
        appTint(text: "Indigo", color: .indigo),
        appTint(text: "Mint", color: .mint),
        appTint(text: "Orange", color: .orange),
        appTint(text: "Pink", color: .pink),
        appTint(text: "Purple", color: .purple),
        appTint(text: "Red", color: .red),
        appTint(text: "Teal", color: .teal),
        appTint(text: "White", color: .white),
        appTint(text: "Yellow", color: .yellow)
    ]

// MARK: Pitcher Ages
struct pitcherAge : Identifiable {
    let id = UUID()
    let age : String
    let pitchLimit : Int
}

let arrPitcherAges =
    [
        pitcherAge(age: "", pitchLimit: 0),
        pitcherAge(age: "6", pitchLimit: 50),
        pitcherAge(age: "7", pitchLimit: 50),
        pitcherAge(age: "8", pitchLimit: 50),
        pitcherAge(age: "9", pitchLimit: 75),
        pitcherAge(age: "10", pitchLimit: 75),
        pitcherAge(age: "11", pitchLimit: 85),
        pitcherAge(age: "12", pitchLimit: 85),
        pitcherAge(age: "13", pitchLimit: 95),
        pitcherAge(age: "14", pitchLimit: 95),
        pitcherAge(age: "15", pitchLimit: 95),
        pitcherAge(age: "16", pitchLimit: 95),
    ]

// MARK: Home/Away
struct gameHomeAway : Identifiable {
    let id = UUID()
    let text : String
}

let arrGameHomeAway =
    [
        gameHomeAway(text: "Away"),
        gameHomeAway(text: "Home")
    ]

// MARK: Pitchers View columns
struct pitcherColumn : Identifiable {
    let id = UUID()
    let name : String
    let image : Image
}

let arrPitcherColumns =
    [
        pitcherColumn(name: "Pitch Count", image: Image(systemName: "baseball")),
        pitcherColumn(name: "Age", image: Image(systemName: "birthday.cake")),
        pitcherColumn(name: "Maximum Pitches", image: Image(systemName: "gauge.open.with.lines.needle.84percent.exclamation")),
        pitcherColumn(name: "Days Rest", image: Image(systemName: "calendar.badge.exclamationmark")),
        pitcherColumn(name: "Rested Date", image: Image(systemName: "calendar.badge.checkmark")),
        pitcherColumn(name: "Percentage", image: Image(systemName: "gauge.open.with.lines.needle.67percent.and.arrowtriangle")),
    ]

// MARK: Games View columns
struct gameColumn : Identifiable {
    let id = UUID()
    let name : String
    let image : Image
}

let arrGameColumns =
    [
        gameColumn(name: "(W/L) Score", image: Image(systemName: "numbers.rectangle")),
        gameColumn(name: "Away/Home", image: Image(systemName: "location")),
        gameColumn(name: "Score", image: Image(systemName: "numbers")),
        gameColumn(name: "Team Runs", image: Image(systemName: "number.circle")),
        gameColumn(name: "Opponent Runs", image: Image(systemName: "number.circle.fill")),
        gameColumn(name: "Win/Loss", image: Image(systemName: "baseball.diamond.bases")),
    ]
