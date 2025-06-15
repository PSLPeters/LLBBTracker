//
//  GamesAddView.swift
//  BaseballTracker
//
//  Created by Michael Peters on 3/14/25.
//

import SwiftUI
import SwiftData

struct GamesAddView: View {
    
    // MARK: AppStorage variables
    @AppStorage("selectedColorScheme") private var selectedColorScheme = "System"
    @AppStorage("selectedAppTintIndex") var selectedAppTintIndex = 0
    @AppStorage("doHaptics") private var doHaptics = true
    
    // MARK: @State variables
    @State private var gameHomeAwaySelectedIndex: Int = 0
    @State private var gameDate: Date = Date()
    @State private var gameOpponent: String = ""
    @State private var gameAwayScore: String = ""
    @State private var gameHomeScore: String = ""
    @State private var gameWinLossString: String = ""
    @State private var gameAtVersusString: String = ""
    
    @State private var isShowingCloseAlert = false
    
    // MARK: Haptic toggles
    @State private var cancelAddGameHapticToggle = false
    @State private var closeAddGameHapticToggle = false
    
    // MARK: Other variables
    @Environment(\.modelContext) var context
    @Environment(\.dismiss) private var dismiss
  
    // MARK: Body
    var body: some View {
        
        // MARK: Calculated variables
        var hapticsIntensity: Double {
            doHaptics ? 1.0 : 0.0
        }
        
        var doDataEntered: Bool {
            !gameOpponent.isEmpty || !gameAwayScore.isEmpty || !gameHomeScore.isEmpty
        }
        
        let gameOpponentString = gameOpponent == "" ? "Opponent" : gameOpponent
        
        NavigationStack {
            GamesCardView(
                gameHomeAwaySelectedIndex: $gameHomeAwaySelectedIndex,
                gameDate: $gameDate,
                gameOpponent: $gameOpponent,
                gameAwayScore: $gameAwayScore,
                gameHomeScore: $gameHomeScore,
                gameWinLossString: $gameWinLossString,
                gameAtVersusString: $gameAtVersusString
            )
            .navigationTitle("\(gameAtVersusString)\(gameOpponentString)")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button("X")
                    {
                        if(doDataEntered)
                        {
                            isShowingCloseAlert = true
                        } else {
                            dismiss()
                            doHaptics ? closeAddGameHapticToggle.toggle() : nil
                        }
                    }
                    .font(.title2)
                    .alert(isPresented: $isShowingCloseAlert) {
                        Alert(title: Text(ConstantsAlerts.cancelAddGameAlertTitle),
                              message: Text(ConstantsAlerts.cancelAddGameAlertMessage),
                              primaryButton: .destructive(Text(ConstantsAlerts.cancelAddGameAlertConfirmButtonTitle))
                              {
                            dismiss()
                            doHaptics ? cancelAddGameHapticToggle.toggle() : nil
                        },
                              secondaryButton: .cancel(Text("No")) {
                        }
                        )
                    }
                    .sensoryFeedback(.error, trigger: cancelAddGameHapticToggle)
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    if(!gameOpponent.isEmpty && !gameAwayScore.isEmpty && !gameHomeScore.isEmpty) {
                        Button {
                            let game = modelGame(
                                gameHomeAwaySelectedIndex: gameHomeAwaySelectedIndex,
                                gameDate: gameDate,
                                gameOpponent: gameOpponent,
                                gameAwayScore: gameAwayScore,
                                gameHomeScore: gameHomeScore,
                                gameWinLossString: gameWinLossString,
                                gameAtVersusString: gameAtVersusString)
                            context.insert(game)
                            dismiss()
                            doHaptics ? closeAddGameHapticToggle.toggle() : nil
                        } label: {
                            Image(systemName: "checkmark")
                        }
                        .sensoryFeedback(.impact(weight: .medium), trigger: closeAddGameHapticToggle)
                    }
                }
            }
        }
        .tint(arrAppTints[selectedAppTintIndex].color)
        .preferredColorScheme(selectedColorScheme == "System" ? nil : selectedColorScheme == "Dark" ? .dark : .light)
    }
}

// MARK: Preview
#Preview {
    GamesAddView()
}
