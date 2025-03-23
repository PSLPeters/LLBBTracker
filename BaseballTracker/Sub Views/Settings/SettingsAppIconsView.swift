//
//  SettingsAppIconsView.swift
//  BaseballTracker
//
//  Created by Michael Peters on 3/16/25.
//

import SwiftUI

struct SettingsAppIconsView: View {
    
    // MARK: AppStorage variables
    @AppStorage("selectedColorScheme") private var selectedColorScheme = "System"
    @AppStorage("selectedAppTintIndex") var selectedAppTintIndex = 0
    @AppStorage("selectedAppIconIndex") private var selectedAppIconIndex = 0
    @AppStorage("doHaptics") private var doHaptics = true
    
    // MARK: Body
    var body: some View {
        
        // MARK: Calculated variables
        var hapticsIntensity: Double {
            doHaptics ? 1.0 : 0.0
        }
        
        Form {
            Picker("Select an App Icon", selection: $selectedAppIconIndex) {
                ForEach(arrAppIcons.indices, id:\.self) { index in
                    let activeAppIcon = arrAppIcons[index]
                        HStack {
                            Image(activeAppIcon.imageName)
                              .resizable()
                              .frame(width: 60, height: 60)
                              .cornerRadius(10)
                              .padding(.trailing)
                            Text(activeAppIcon.description)
                        }
                        .tag(index)
                }
            }
            .onChange(of: selectedAppIconIndex) {
                UIApplication.shared.setAlternateIconName(arrAppIcons[selectedAppIconIndex].appIconName)
            }
            .pickerStyle(.inline)
            .sensoryFeedback(.impact(weight: .medium, intensity: hapticsIntensity), trigger: selectedAppIconIndex)
        }
        .tint(arrAppTints[selectedAppTintIndex].color)
        .preferredColorScheme(selectedColorScheme == "System" ? nil : selectedColorScheme == "Dark" ? .dark : .light)
    }
    
}

// MARK: Preview
#Preview {
    SettingsAppIconsView()
}
