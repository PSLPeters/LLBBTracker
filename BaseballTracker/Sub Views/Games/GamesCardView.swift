//
//  GamesCardView.swift
//  BaseballTracker
//
//  Created by Michael Peters on 3/14/25.
//

import SwiftUI

struct GamesCardView: View {
    
    // MARK: AppStorage variables
    @AppStorage("selectedColorScheme") private var selectedColorScheme = "System"
    @AppStorage("selectedAppTintIndex") var selectedAppTintIndex = 0
    @AppStorage("doHaptics") private var doHaptics = true
    @AppStorage("globalTeamName") private var globalTeamName = "My Team Name"
    @AppStorage("isExpandedGameInfo") private var isExpandedGameInfo = true
    @AppStorage("isExpandedScoreboard") private var isExpandedScoreboard = true
    @AppStorage("isExpandedOutcome") private var isExpandedOutcome = true
    @AppStorage("doGameAddView") private var doGameAddView = false

    // MARK: @State variables
    
    // MARK: Other variables
    @Binding var gameHomeAwaySelectedIndex: Int
    @Binding var gameDate: Date
    @Binding var gameOpponent: String
    @Binding var gameAwayScore: String
    @Binding var gameHomeScore: String
    @Binding var gameWinLossString: String
    @Binding var gameAtVersusString: String
    
    @FocusState private var focusedField: FocusedField?
    
    // MARK: Body
    var body: some View {
        
        // MARK: Calculated variables
        var hapticsIntensity: Double {
            doHaptics ? 1.0 : 0.0
        }
        
        var doShowGameScoreboardSection: Bool {
            gameOpponent != ""
        }
        
        var doShowGameOutcomeSection: Bool {
            gameAwayScore != "" && gameHomeScore != ""
        }
        
        var allData : String {
            [
                gameHomeAwaySelectedIndex.description,
                gameDate.description,
                gameOpponent,
                gameAwayScore,
                gameHomeScore,
                gameWinLossString
            ].joined(separator: "")
        }
        
        let awayScore = gameAwayScore.isEmpty ? "0" : gameAwayScore
        let homeScore = gameHomeScore.isEmpty ? "0" : gameHomeScore
        var winLossString: String {
            if(awayScore == homeScore) {
                "Tie"
            } else {
                if gameHomeAwaySelectedIndex == 0 {
                    Int(awayScore)! > Int(homeScore)! ? "Win" : "Loss"
                } else {
                    Int(homeScore)! > Int(awayScore)! ? "Win" : "Loss"
                }
            }
        }
        
        let myTeam = !globalTeamName.isEmpty ? globalTeamName : "My Team Name"
        let opponentTeam = !gameOpponent.isEmpty ? gameOpponent : "<Enter Opponent Above>"
        
        let awayTeam = gameHomeAwaySelectedIndex == 0 ? myTeam : opponentTeam
        let homeTeam = gameHomeAwaySelectedIndex == 0 ? opponentTeam : myTeam
        
        let atVersusString = gameHomeAwaySelectedIndex == 0 ? "@" : ""
        
        VStack {
            List {
                Section("Game Information \(Image(systemName: "info.circle"))", isExpanded: $isExpandedGameInfo) {
                    if #available(iOS 26.0, *) {
                        Picker("HomeAway", selection: $gameHomeAwaySelectedIndex) {
                            ForEach(arrGameHomeAway.indices, id:\.self) { index in
                                let activeText = arrGameHomeAway[index]
                                Text(activeText.text)
                            }
                        }
                        .pickerStyle(.segmented)
                        .glassEffect(.regular.interactive())
                    } else {
                        Picker("HomeAway", selection: $gameHomeAwaySelectedIndex) {
                            ForEach(arrGameHomeAway.indices, id:\.self) { index in
                                let activeText = arrGameHomeAway[index]
                                Text(activeText.text)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    DatePicker("Date - [\(gameDate.getDayOfWeek())]", selection: $gameDate, displayedComponents: .date)
                    LabeledContent("Opponent:") {
                        TextField("Enter here", text: $gameOpponent)
                            .textInputAutocapitalization(.words)
                            .focused($focusedField, equals: .gameOpponent)
                            .submitLabel(.next)
                            .onSubmit {
                                focusedField = .gameAwayScore
                            }
                    }
                }
                .sensoryFeedback(.impact(flexibility: .soft, intensity: hapticsIntensity), trigger: isExpandedGameInfo)
                if (doShowGameScoreboardSection) {
                    Section("Scoreboard \(Image(systemName: "numbers.rectangle"))", isExpanded: $isExpandedScoreboard) {
                        LabeledContent(awayTeam) {
                            TextField("Score", text: $gameAwayScore)
                                .keyboardType(.numbersAndPunctuation)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 75)
                                .focused($focusedField, equals: .gameAwayScore)
                                .submitLabel(.next)
                                .onSubmit {
                                    focusedField = .gameHomeScore
                                }
                        }
                        LabeledContent(homeTeam) {
                            TextField("Score", text: $gameHomeScore)
                                .keyboardType(.numbersAndPunctuation)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 75)
                                .focused($focusedField, equals: .gameHomeScore)
                                .submitLabel(.done)
                        }
                    }
                    .sensoryFeedback(.impact(flexibility: .soft, intensity: hapticsIntensity), trigger: isExpandedScoreboard)
                }
                if (doShowGameOutcomeSection) {
                    Section("Outcome \(Image(systemName: "baseball.diamond.bases.outs.indicator"))", isExpanded: $isExpandedOutcome) {
                        Text(gameWinLossString)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.system(size: 100, weight: .bold))
                            .foregroundStyle(arrAppTints[selectedAppTintIndex].color)
                    }
                    .sensoryFeedback(.impact(flexibility: .soft, intensity: hapticsIntensity), trigger: isExpandedOutcome)
                }
            }
            .listStyle(.sidebar)
        }
        .onAppear() {
            UITextField.appearance().clearButtonMode = .whileEditing
            
            if (doGameAddView) {
                focusedField = .gameOpponent
            }
        }
        .task(id: allData) {
            gameWinLossString = winLossString
            gameAtVersusString = atVersusString
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button {
                    focusedField = nil
                } label: {
                    Image(systemName: "keyboard.chevron.compact.down")
                }
            }
        }
        .tint(arrAppTints[selectedAppTintIndex].color)
        .preferredColorScheme(selectedColorScheme == "System" ? nil : selectedColorScheme == "Dark" ? .dark : .light)
    }
}

// MARK: Preview
#Preview {
    @Previewable @State var gameHomeAwaySelectedIndex = 0
    @Previewable @State var gameDate: Date = .now
    @Previewable @State var gameOpponent = "New York Yankees"
    @Previewable @State var gameAwayScore = "5"
    @Previewable @State var gameHomeScore = "10"
    @Previewable @State var gameWinLossString = "Win"
    @Previewable @State var gameAtVersusString = "@"
    
    GamesCardView(
        gameHomeAwaySelectedIndex: $gameHomeAwaySelectedIndex,
        gameDate: $gameDate,
        gameOpponent: $gameOpponent,
        gameAwayScore: $gameAwayScore,
        gameHomeScore: $gameHomeScore,
        gameWinLossString: $gameWinLossString,
        gameAtVersusString: $gameAtVersusString
    )
}
