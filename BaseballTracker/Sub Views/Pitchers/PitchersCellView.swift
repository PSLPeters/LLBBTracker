//
//  PitchersCellView.swift
//  BaseballTracker
//
//  Created by Michael Peters on 3/9/25.
//

import SwiftUI

struct PitchersCellView: View {
    // MARK: AppStorage variables
    @AppStorage("selectedColorScheme") private var selectedColorScheme = "System"
    @AppStorage("selectedPitcherColumnIndex") var selectedPitcherColumnIndex = 0
    
    // MARK: Other variables
    let pitcher: modelPitcher
    
    // MARK: Body
    var body: some View {
        
        let restedDate = Calendar.current.date(byAdding: .day, value: pitcher.pitcherDaysRest, to: pitcher.pitcherDate)
        
        // MARK: Calculated variables
        var pitcherDataPoint: String {
            switch (arrPitcherColumns[selectedPitcherColumnIndex].name) {
            case "Pitch Count":
                return String(format: "%.0f", pitcher.pitcherCount)
            case "Age":
                return arrPitcherAges[pitcher.pitcherAgeSelectedIndex].age
            case "Maximum Pitches":
                return String(arrPitcherAges[pitcher.pitcherAgeSelectedIndex].pitchLimit)
            case "Days Rest":
                return String(pitcher.pitcherDaysRest)
            case "Rested Date":
                return restedDate!.formatDate()
            case "Percentage":
                return pitcher.pitcherCountPercentage.formatted(
                    .percent.precision(.fractionLength(2)))
            default:
                return String(format: "%.0f", pitcher.pitcherCount)
            }
        }
        
        HStack {
            Text("\(pitcher.pitcherDate.formatDate()) - \(Text(pitcher.pitcherName))")
            Spacer()
            Text(pitcherDataPoint)
        }
        .preferredColorScheme(selectedColorScheme == "System" ? nil : selectedColorScheme == "Dark" ? .dark : .light)
    }
}

// MARK: Preview
#Preview {
    PitchersCellView(pitcher: .init(
        pitcherDate: .now,
        pitcherName: "Mariano Rivera",
        pitcherAgeSelectedIndex: 0,
        pitcherCount: 100,
        pitcherDaysRest: 0,
        pitcherCountPercentage: 0)
    )
}
