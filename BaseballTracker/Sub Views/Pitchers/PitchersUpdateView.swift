//
//  PitchersUpdateView.swift
//  BaseballTracker
//
//  Created by Michael Peters on 3/9/25.
//

import SwiftUI
import SwiftData

struct PitchersUpdateView: View {
    
    // MARK: AppStorage variables
    @AppStorage("selectedColorScheme") private var selectedColorScheme = "System"
    @AppStorage("selectedAppTintIndex") var selectedAppTintIndex = 0
    @AppStorage("doHaptics") private var doHaptics = true
    
    // MARK: @State variables
    @State private var pitchCountShareImage: Image? = nil
    @State private var pitchCountShareString = ""
    
    // MARK: Haptic toggles
    @State private var closeUpdatePitcherHapticToggle = false
    
    // MARK: Other variables
    @Environment(\.dismiss) private var dismiss
    @Bindable var pitcher: modelPitcher
    
    // MARK: Body
    var body: some View {
        
        // MARK: Calculated variables
        var allData : String {
            [
                pitcher.pitcherDate.description,
                pitcher.pitcherName,
                pitcher.pitcherAgeSelectedIndex.description,
                pitcher.pitcherCount.description,
                pitcher.pitcherCountPercentage.description
            ].joined(separator: "")
        }
        
        NavigationStack {
            PitchersCardView(
                pitcherDate: $pitcher.pitcherDate,
                pitcherName: $pitcher.pitcherName,
                pitcherAgeSelectedIndex: $pitcher.pitcherAgeSelectedIndex,
                pitcherCount: $pitcher.pitcherCount,
                pitcherDaysRest: $pitcher.pitcherDaysRest,
                pitcherCountPercentage: $pitcher.pitcherCountPercentage
            )
            .navigationTitle($pitcher.pitcherName.wrappedValue == "" ? "Pitcher Name" : $pitcher.pitcherName.wrappedValue)
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    if let pitchCountShareImage {
                        ShareLink(item: pitchCountShareImage,
                                  preview: SharePreview(pitchCountShareString,
                                                        image: pitchCountShareImage))
                    }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Done")
                    {
                        dismiss()
                        doHaptics ? closeUpdatePitcherHapticToggle.toggle() : nil
                    }
                    .sensoryFeedback(.impact(weight: .medium), trigger: closeUpdatePitcherHapticToggle)
                }
            }
        }
        .task(id: allData) {
            pitchCountShareString = "\(pitcher.pitcherName) - \(String(format: "%.0f", pitcher.pitcherCount)) pitches"
            let renderer = ImageRenderer(content: PitchersShareView(pitcher: $pitcher.wrappedValue))
            renderer.scale = 3
            if let image = renderer.cgImage {
                pitchCountShareImage = Image(decorative: image, scale: 1.0)
            }
        }
        .tint(arrAppTints[selectedAppTintIndex].color)
        .preferredColorScheme(selectedColorScheme == "System" ? nil : selectedColorScheme == "Dark" ? .dark : .light)
    }
}

// MARK: Preview
#Preview {
    PitchersUpdateView(pitcher: .init(
        pitcherDate: .now,
        pitcherName: "Mariano Rivera",
        pitcherAgeSelectedIndex: 10,
        pitcherCount: 100,
        pitcherDaysRest: 0,
        pitcherCountPercentage: 0)
    )
}
