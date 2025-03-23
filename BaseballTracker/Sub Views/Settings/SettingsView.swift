//
//  SettingsView.swift
//  BaseballTracker
//
//  Created by Michael Peters on 3/9/25.
//

import SwiftUI

struct SettingsView: View {

    // MARK: AppStorage variables
    @AppStorage("selectedMainTab") private var selectedMainTab = ""
    @AppStorage("selectedColorScheme") private var selectedColorScheme = "System"
    @AppStorage("selectedAppTintIndex") var selectedAppTintIndex = 0
    @AppStorage("selectedAppIconIndex") private var selectedAppIconIndex = 0
    @AppStorage("selectedPitcherColumnIndex") var selectedPitcherColumnIndex = 0
    @AppStorage("selectedGameColumnIndex") var selectedGameColumnIndex = 0
    
    @AppStorage("globalTeamName") private var globalTeamName = "My Team Name"
    
    @AppStorage("isExpandedTeamInformation") private var isExpandedTeamInformation = true
    @AppStorage("isExpandedAppearance") private var isExpandedAppearance = true
    @AppStorage("isExpandedGeneral") private var isExpandedGeneral = true
    @AppStorage("isExpandedPitchers") private var isExpandedPitchers = true
    @AppStorage("isExpandedGames") private var isExpandedGames = true

    @AppStorage("doHaptics") private var doHaptics = true
    
    // MARK: @State variables
    
    // MARK: Other variables
    @Environment(\.dismiss) private var dismiss
    @FocusState private var focusedField: FocusedField?
    
    // MARK: Body
    var body: some View {
        
        // MARK: Calculated variables
        var hapticsIntensity: Double {
            doHaptics ? 1.0 : 0.0
        }
        
        var allSectionsExpanded: Bool {
            isExpandedTeamInformation &&
            isExpandedAppearance &&
            isExpandedGeneral &&
            isExpandedPitchers &&
            isExpandedGames
        }
        
        var allSectionsCollapsed: Bool {
            !isExpandedTeamInformation &&
            !isExpandedAppearance &&
            !isExpandedGeneral &&
            !isExpandedPitchers &&
            !isExpandedGames
        }
        
        NavigationStack {
            List {
                Section("Team Information \(Image(systemName: "info.circle"))", isExpanded: $isExpandedTeamInformation) {
                    LabeledContent("Team Name:") {
                        TextField("Enter here", text: $globalTeamName)
                            .focused($focusedField, equals: .teamName)
                            .textInputAutocapitalization(.words)
                            .submitLabel(.done)
                    }
                }
                .sensoryFeedback(.impact(flexibility: .soft, intensity: hapticsIntensity), trigger: isExpandedTeamInformation)
                
                Section("Appearance \(Image(systemName: "sunglasses"))", isExpanded: $isExpandedAppearance) {
                    Picker("Color Scheme", selection: $selectedColorScheme) {
                        ForEach(arrColorSchemes.indices, id:\.self) { index in
                            let activeColorScheme = arrColorSchemes[index]
                                HStack {
                                    Text(activeColorScheme.image)
                                    Text(activeColorScheme.name)
                                }
                                .tag(activeColorScheme.name)
                        }
                    }
                    .pickerStyle(.navigationLink)
                    NavigationLink {
                        SettingsAccentsView()
                        .navigationTitle("Accent Color")
                    } label: {
                        HStack {
                            Text("Accent Color")
                            Spacer()
                            RoundedRectangle(cornerRadius: 50)
                                .frame(width: 30, height: 15)
                                .padding(.trailing)
                                .foregroundStyle(arrAppTints[selectedAppTintIndex].color)
                        }
                    }
                    NavigationLink {
                        SettingsAppIconsView()
                        .navigationTitle("App Icon")
                    } label: {
                        HStack {
                            Text("App Icon")
                            Spacer()
                            Text(arrAppIcons[selectedAppIconIndex].description)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .sensoryFeedback(.impact(flexibility: .soft, intensity: hapticsIntensity), trigger: isExpandedAppearance)
                
                Section("General \(Image(systemName: "gear"))", isExpanded: $isExpandedGeneral) {
                    NavigationLink("About") {
                        SettingsAboutView()
                    }
                    if (UIDevice.current.userInterfaceIdiom != .pad)
                    {
                        Toggle("Haptic Feedback", isOn: $doHaptics)
                    }
                }
                .sensoryFeedback(.impact(flexibility: .soft, intensity: hapticsIntensity), trigger: isExpandedGeneral)
                
                Section("Pitchers Tab \(Image(systemName: "baseball"))", isExpanded: $isExpandedPitchers) {
                    Picker("Data Point", selection: $selectedPitcherColumnIndex) {
                        ForEach(arrPitcherColumns.indices, id:\.self) { index in
                            let activePitcherColumn = arrPitcherColumns[index]
                            HStack {
                                Text(activePitcherColumn.image)
                                    .frame(width: 30)
                                Text(activePitcherColumn.name)
                            }
                            .tag(index)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                .onChange(of: selectedPitcherColumnIndex) {
                    dismiss()
                    selectedMainTab = "Pitchers"
                }
                .sensoryFeedback(.impact(flexibility: .soft, intensity: hapticsIntensity), trigger: isExpandedPitchers)
                
                Section("Games Tab \(Image(systemName: "baseball.diamond.bases.outs.indicator"))", isExpanded: $isExpandedGames) {
                    Picker("Data Point", selection: $selectedGameColumnIndex) {
                        ForEach(arrGameColumns.indices, id:\.self) { index in
                            let activeGameColumn = arrGameColumns[index]
                            HStack {
                                Text(activeGameColumn.image)
                                    .frame(width: 30)
                                Text(activeGameColumn.name)
                            }
                            .tag(index)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                .onChange(of: selectedGameColumnIndex) {
                    dismiss()
                    selectedMainTab = "Games"
                }
                .sensoryFeedback(.impact(flexibility: .soft, intensity: hapticsIntensity), trigger: isExpandedGames)
            }
            .navigationTitle("Settings")
            .onAppear() {
                UITextField.appearance().clearButtonMode = .whileEditing
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    Menu {
                        Section("View Options") {
                            Button {
                                isExpandedTeamInformation = true
                                isExpandedAppearance = true
                                isExpandedGeneral = true
                                isExpandedPitchers = true
                                isExpandedGames = true
                            } label: {
                                Text("Expand All")
                                Image(systemName: "chevron.down")
                            }
                            .disabled(allSectionsExpanded)
                            
                            Button {
                                isExpandedTeamInformation = false
                                isExpandedAppearance = false
                                isExpandedGeneral = false
                                isExpandedPitchers = false
                                isExpandedGames = false
                            } label: {
                                Text("Collapse All")
                                Image(systemName: "chevron.up")
                            }
                            .disabled(allSectionsCollapsed)
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button {
                        focusedField = nil
                    } label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                    }
                }
            }
            .listStyle(.sidebar)
        }
        .tint(arrAppTints[selectedAppTintIndex].color)
        .preferredColorScheme(selectedColorScheme == "System" ? nil : selectedColorScheme == "Dark" ? .dark : .light)
        .interactiveDismissDisabled(true)
    }
    
}

// MARK: Preview
#Preview {    
    SettingsView()
}

