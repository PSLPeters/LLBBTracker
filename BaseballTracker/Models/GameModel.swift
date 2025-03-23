//
//  GameModel.swift
//  BaseballTracker
//
//  Created by Michael Peters on 3/9/25.
//

import Foundation
import SwiftData

@Model
class modelGame {
    var gameHomeAwaySelectedIndex: Int = 0
    var gameDate: Date = Date()
    var gameOpponent: String = ""
    var gameAwayScore: String = ""
    var gameHomeScore: String = ""
    var gameWinLossString: String = ""
    var gameAtVersusString: String = ""
    
    init(
        gameHomeAwaySelectedIndex: Int,
        gameDate: Date,
        gameOpponent: String,
        gameAwayScore: String,
        gameHomeScore: String,
        gameWinLossString: String,
        gameAtVersusString: String
    ){
        self.gameHomeAwaySelectedIndex = gameHomeAwaySelectedIndex
        self.gameDate = gameDate
        self.gameOpponent = gameOpponent
        self.gameAwayScore = gameAwayScore
        self.gameHomeScore = gameHomeScore
        self.gameWinLossString = gameWinLossString
        self.gameAtVersusString = gameAtVersusString
    }
}
