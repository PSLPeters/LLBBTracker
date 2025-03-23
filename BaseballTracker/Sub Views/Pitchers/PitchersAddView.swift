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
                    Button("Cancel")
                    {
                        if(doDataEntered)
                        {
                            isShowingCloseAlert = true
                        } else {
                            dismiss()
                            doPitcherAddView = false
                            doHaptics ? closeAddPitcherHapticToggle.toggle() : nil
                        }
                    }
                    .alert(isPresented: $isShowingCloseAlert) {
                        Alert(title: Text(ConstantsAlerts.cancelAddPitcherAlertTitle),
                              message: Text(ConstantsAlerts.cancelAddPitcherAlertMessage),
                              primaryButton: .destructive(Text(ConstantsAlerts.cancelAddPitcherAlertConfirmButtonTitle))
                              {
                            dismiss()
                            doPitcherAddView = false
                            doHaptics ? cancelAddPitcherHapticToggle.toggle() : nil
                        },
                              secondaryButton: .cancel(Text("No")) {
                            
                        }
                        )
                    }
                    .sensoryFeedback(.error, trigger: cancelAddPitcherHapticToggle)
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Button("Save")
                    {
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
                    }
                    .sensoryFeedback(.impact(weight: .medium), trigger: closeAddPitcherHapticToggle)
                    .opacity(!pitcherName.isEmpty && pitcherAgeSelectedIndex != 0 ? 1 : 0)
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
