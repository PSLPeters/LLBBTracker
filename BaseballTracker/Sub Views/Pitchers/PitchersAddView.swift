//
//  PitchersAddView.swift
//  BaseballTracker
//
//  Created by Michael Peters on 3/9/25.
//

import SwiftUI
import SwiftData

struct PitchersAddView: View {
    
    // MARK: AppStorage variables
    @AppStorage("selectedColorScheme") private var selectedColorScheme = "System"
    @AppStorage("selectedAppTintIndex") var selectedAppTintIndex = 0
    @AppStorage("doHaptics") private var doHaptics = true
    @AppStorage("doPitcherAddView") private var doPitcherAddView = false
    
    // MARK: @State variables
    @State private var pitcherName: String = ""
    @State private var pitcherDate: Date = Date()
    @State private var pitcherAgeSelectedIndex: Int = 0
    @State private var pitcherCount: Double = 0
    @State private var pitcherDaysRest: Int = 0
    @State private var pitcherCountPercentage: Double = 0
    
    @State private var isShowingCloseAlert = false
    
    // MARK: Haptic toggles
    @State private var cancelAddPitcherHapticToggle = false
    @State private var closeAddPitcherHapticToggle = false
    
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
            !pitcherName.isEmpty || pitcherAgeSelectedIndex != 0
        }
        
        NavigationStack {
            PitchersCardView(
                pitcherDate: $pitcherDate,
                pitcherName: $pitcherName,
                pitcherAgeSelectedIndex: $pitcherAgeSelectedIndex,
                pitcherCount: $pitcherCount,
                pitcherDaysRest: $pitcherDaysRest,
                pitcherCountPercentage: $pitcherCountPercentage
            )
            .navigationTitle(!pitcherName.isEmpty ? pitcherName : "Add Pitcher")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    Button {
                        if(doDataEntered)
                        {
                            isShowingCloseAlert = true
                        } else {
                            dismiss()
                            doPitcherAddView = false
                            doHaptics ? closeAddPitcherHapticToggle.toggle() : nil
                        }
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .confirmationDialog("Close Pitcher", isPresented: $isShowingCloseAlert) {
                        Button(ConstantsConfirmationDialogs.cancelAddPitcherConfirmationDialogConfirmButtonTitle, role: .destructive)
                        {
                            dismiss()
                            doPitcherAddView = false
                            doHaptics ? cancelAddPitcherHapticToggle.toggle() : nil
                        }
                        Button("No")
                        {
                            
                        }
                    } message: {
                        Text(ConstantsConfirmationDialogs.cancelAddPitcherConfirmationDialogMessage)
                    }
                    .sensoryFeedback(.error, trigger: cancelAddPitcherHapticToggle)
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    if (!pitcherName.isEmpty && pitcherAgeSelectedIndex != 0) {
                        Button {
                            let pitcher = modelPitcher(
                                pitcherDate: pitcherDate,
                                pitcherName: pitcherName,
                                pitcherAgeSelectedIndex: pitcherAgeSelectedIndex,
                                pitcherCount: pitcherCount,
                                pitcherDaysRest: pitcherDaysRest,
                                pitcherCountPercentage: pitcherCountPercentage)
                            context.insert(pitcher)
                            dismiss()
                            doPitcherAddView = false
                            doHaptics ? closeAddPitcherHapticToggle.toggle() : nil
                        } label: {
                            Image(systemName: "checkmark")
                        }
                        .buttonStyle(.borderedProminent)
                        .sensoryFeedback(.impact(weight: .medium), trigger: closeAddPitcherHapticToggle)
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
    PitchersAddView()
}
