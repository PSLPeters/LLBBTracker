//
//  PitcherModel.swift
//  BaseballTracker
//
//  Created by Michael Peters on 3/9/25.
//

import Foundation
import SwiftData

@Model
class modelPitcher {
    var pitcherDate: Date = Date()
    var pitcherName: String = ""
    var pitcherAgeSelectedIndex: Int = 0
    var pitcherCount: Double = 0
    var pitcherDaysRest: Int = 0
    var pitcherCountPercentage: Double = 0
    
    init(
        pitcherDate: Date,
        pitcherName: String,
        pitcherAgeSelectedIndex: Int,
        pitcherCount: Double,
        pitcherDaysRest: Int,
        pitcherCountPercentage: Double
    ){
        self.pitcherDate = pitcherDate
        self.pitcherName = pitcherName
        self.pitcherAgeSelectedIndex = pitcherAgeSelectedIndex
        self.pitcherCount = pitcherCount
        self.pitcherDaysRest = pitcherDaysRest
        self.pitcherCountPercentage = pitcherCountPercentage
    }
}
