//
//  GamesUpdateView.swift
//  BaseballTracker
//
//  Created by Michael Peters on 3/14/25.
//

import SwiftUI
import SwiftData

struct GamesUpdateView: View {
    
    // MARK: AppStorage variables
    @AppStorage("selectedColorScheme") private var selectedColorScheme = "System"
    @AppStorage("selectedAppTintIndex") var selectedAppTintIndex = 0
    @AppStorage("doHaptics") private var doHaptics = true
    
    // MARK: @State variables
    @State private var gameShareImage: Image? = nil
    @State private var gameShareString = ""
    
    // MARK: Haptic toggles
    @State private var closeUpdateGameHapticToggle = false
    
    // MARK: Other variables
    @Environment(\.dismiss) private var dismiss
    @Bindable var game: modelGame
    
    // MARK: Body
    var body: some View {
        
        // MARK: Calculated variables
        var allData : String {
            [
                game.gameHomeAwaySelectedIndex.description,
                game.gameDate.description,
                game.gameOpponent,
                game.gameAwayScore,
                game.gameHomeScore,
                game.gameWinLossString,
                game.gameAtVersusString
            ].joined(separator: "")
        }
        
        let gameOpponentString = $game.gameOpponent.wrappedValue == "" ? "Opponent" : $game.gameOpponent.wrappedValue
        
        NavigationStack {
            GamesCardView(
                gameHomeAwaySelectedIndex: $game.gameHomeAwaySelectedIndex,
                gameDate: $game.gameDate,
                gameOpponent: $game.gameOpponent,
                gameAwayScore: $game.gameAwayScore,
                gameHomeScore: $game.gameHomeScore,
                gameWinLossString: $game.gameWinLossString,
                gameAtVersusString: $game.gameAtVersusString
            )
            .navigationTitle("\(game.gameAtVersusString)\(gameOpponentString)")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    if let gameShareImage {
                        ShareLink(item: gameShareImage,
                                  preview: SharePreview(gameShareString,
                                                        image: gameShareImage))
                    }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Done")
                    {
                        dismiss()
                        doHaptics ? closeUpdateGameHapticToggle.toggle() : nil
                    }
                    .sensoryFeedback(.impact(weight: .medium), trigger: closeUpdateGameHapticToggle)
                }
            }
        }
        .task(id: allData) {
            gameShareString = "\(game.gameDate.formatDate()) - \(game.gameAtVersusString)\(gameOpponentString)"
            let renderer = ImageRenderer(content: GamesShareView(game: $game.wrappedValue))
            renderer.scale = 3
            if let image = renderer.cgImage {
                gameShareImage = Image(decorative: image, scale: 1.0)
            }
        }
        .tint(arrAppTints[selectedAppTintIndex].color)
        .preferredColorScheme(selectedColorScheme == "System" ? nil : selectedColorScheme == "Dark" ? .dark : .light)
    }
}

// MARK: Preview
#Preview {
    GamesUpdateView(game: .init(
        gameHomeAwaySelectedIndex: 0,
        gameDate: .now,
        gameOpponent: "Opponent",
        gameAwayScore: "5",
        gameHomeScore: "10",
        gameWinLossString: "Win",
        gameAtVersusString: "@")
    )
}
