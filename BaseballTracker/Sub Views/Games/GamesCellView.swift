//
//  GamesCellView.swift
//  BaseballTracker
//
//  Created by Michael Peters on 3/14/25.
//


import SwiftUI

struct GamesCellView: View {
    // MARK: AppStorage variables
    @AppStorage("selectedColorScheme") private var selectedColorScheme = "System"
    @AppStorage("selectedGameColumnIndex") var selectedGameColumnIndex = 0
    
    // MARK: @State variables
    
    // MARK: Other variables
    let game: modelGame
    
    // MARK: Body
    var body: some View {
        
        // MARK: Calculated variables
        var gameDataPoint: String {
            switch (arrGameColumns[selectedGameColumnIndex].name) {
            case "(W/L) Score":
                return "(\(game.gameWinLossString.prefix(1))) \(game.gameAwayScore)-\(game.gameHomeScore)"
            case "Away/Home":
                return arrGameHomeAway[game.gameHomeAwaySelectedIndex].text
            case "Score":
                return "\(game.gameAwayScore)-\(game.gameHomeScore)"
            case "Team Runs":
                return game.gameHomeAwaySelectedIndex == 0 ? game.gameAwayScore : game.gameHomeScore
            case "Opponent Runs":
                return game.gameHomeAwaySelectedIndex == 0 ? game.gameHomeScore : game.gameAwayScore
            case "Win/Loss":
                return game.gameWinLossString
            default:
                return "(\(game.gameWinLossString.prefix(1))) \(game.gameAwayScore)-\(game.gameHomeScore)"
            }
        }
        
        HStack {
            Text("\(game.gameDate.formatDate()) - \(game.gameAtVersusString)\(game.gameOpponent)")
            Spacer()
            Text(gameDataPoint)
        }
        .preferredColorScheme(selectedColorScheme == "System" ? nil : selectedColorScheme == "Dark" ? .dark : .light)
    }
}

// MARK: Preview
#Preview {
    GamesCellView(game: .init(
        gameHomeAwaySelectedIndex: 0,
        gameDate: .now,
        gameOpponent: "Opponent",
        gameAwayScore: "5",
        gameHomeScore: "10",
        gameWinLossString: "Win",
        gameAtVersusString: "@")
    )
}
