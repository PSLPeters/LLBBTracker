//
//  PitchersCardView.swift
//  BaseballTracker
//
//  Created by Michael Peters on 3/9/25.
//

import SwiftUI

struct PitchersCardView: View {
    
    // MARK: AppStorage variables
    @AppStorage("selectedColorScheme") private var selectedColorScheme = "System"
    @AppStorage("selectedAppTintIndex") var selectedAppTintIndex = 0
    @AppStorage("doHaptics") private var doHaptics = true
    @AppStorage("isExpandedPitcherInfo") private var isExpandedPitcherInfo = true
    @AppStorage("isExpandedCalculatedData") private var isExpandedCalculatedData = true
    @AppStorage("isExpandedCount") private var isExpandedCount = true
    @AppStorage("doPitcherAddView") private var doPitcherAddView = false

    // MARK: @State variables
    
    // MARK: Other variables
    @Binding var pitcherDate: Date
    @Binding var pitcherName: String
    @Binding var pitcherAgeSelectedIndex: Int
    @Binding var pitcherCount: Double
    @Binding var pitcherDaysRest: Int
    @Binding var pitcherCountPercentage: Double
    
    @FocusState private var focusedField: FocusedField?
    
    // MARK: Body
    var body: some View {
        
        // MARK: Calculated variables
        var hapticsIntensity: Double {
            doHaptics ? 1.0 : 0.0
        }
        
        var doShowPitcherSections: Bool {
            !pitcherName.isEmpty && pitcherAgeSelectedIndex != 0
        }
        
        var allData : String {
            [
                pitcherDate.description,
                pitcherName,
                pitcherAgeSelectedIndex.description,
                pitcherCount.description,
                pitcherCountPercentage.description
            ].joined(separator: "")
        }
        
        var daysRest: Int {
            if(arrPitcherAges[pitcherAgeSelectedIndex].age == "15" ||
               arrPitcherAges[pitcherAgeSelectedIndex].age == "16") {
                switch pitcherCount {
                case 1...30:
                    0
                case 31...45:
                    1
                case 46...60:
                    2
                case 61...75:
                    3
                case 76...1000:
                    4
                default:
                    0
                }
            } else {
                switch pitcherCount {
                case 1...20:
                    0
                case 21...35:
                    1
                case 36...50:
                    2
                case 51...65:
                    3
                case 66...1000:
                    4
                default:
                    0
                }
            }
        }
        let restedDate = Calendar.current.date(byAdding: .day, value: daysRest, to: pitcherDate)
        let selectedPitcherLimit = arrPitcherAges[pitcherAgeSelectedIndex].pitchLimit
        let pitcherLimit = selectedPitcherLimit > 0 ? Double(selectedPitcherLimit) : 100
        
        var countPercentage: Double {
            (pitcherCount / pitcherLimit) == 0 ? 0.0 : (pitcherCount / pitcherLimit)
        }
        
        VStack {
            List {
                Section("Pitcher Information \(Image(systemName: "info.circle"))", isExpanded: $isExpandedPitcherInfo) {
                    DatePicker("Date - [\(pitcherDate.getDayOfWeek())]", selection: $pitcherDate, displayedComponents: .date)
                    LabeledContent("Name:") {
                        TextField("Enter here", text: $pitcherName)
                            .focused($focusedField, equals: .pitcherName)
                            .textInputAutocapitalization(.words)
                            .submitLabel(.done)
                    }
                    Picker("Age", selection: $pitcherAgeSelectedIndex) {
                        ForEach(arrPitcherAges.indices, id:\.self) { index in
                            let activePitcherAge = arrPitcherAges[index]
                            Text(activePitcherAge.age)
                            if index == 0 {
                                Divider()
                            }
                        }
                    }
                }
                .sensoryFeedback(.impact(flexibility: .soft, intensity: hapticsIntensity), trigger: isExpandedPitcherInfo)
                if (doShowPitcherSections) {
                    Section("Calculated Data \(Image(systemName: "infinity"))", isExpanded: $isExpandedCalculatedData) {
                        LabeledContent("Maximum Pitches") {
                            Text(String(arrPitcherAges[pitcherAgeSelectedIndex].pitchLimit))
                        }
                        LabeledContent("Days Rest") {
                            Text("^[\(pitcherDaysRest) Day](inflect: true)")
                        }
                        LabeledContent("Rested Date - [\(restedDate!.getDayOfWeek())]") {
                            Text(restedDate!.formatDate())
                        }
                    }
                    .sensoryFeedback(.impact(flexibility: .soft, intensity: hapticsIntensity), trigger: isExpandedCalculatedData)
                    .foregroundStyle(.secondary)
                }
                if (doShowPitcherSections) {
                    Section("Count \(Image(systemName: "plus.forwardslash.minus"))", isExpanded: $isExpandedCount) {
                        VStack {
                            LabeledContent("Pitches") {
                                Text(String(Int(pitcherCount)))
                            }
                            VStack {
                                Slider(value: $pitcherCount,
                                       in: 0...pitcherLimit,
                                       step: 1) {
                                    Text("Pitches")
                                } minimumValueLabel: {
                                    Text("0")
                                } maximumValueLabel: {
                                    Text(String(format: "%.0f", pitcherLimit))
                                }
                                Text((pitcherCountPercentage).formatted(
                                    .percent.precision(.fractionLength(2)))
                                )
                                .padding(.top, -10)
                            }
                        }
                        HStack {
                            Button {
                                pitcherCount -= 1.0
                            } label: {
                                Image(systemName: "minus.circle")
                                    .imageScale(.large)
                            }
                            .disabled(pitcherCount == 0)
                            Spacer()
                            Button {
                                pitcherCount += 1.0
                            } label: {
                                Image(systemName: "baseball.fill", variableValue: 0.05)
                                    .font(.system(size: 140))
                            }
                            .disabled(pitcherCount == pitcherLimit)
                            Spacer()
                            Button {
                                pitcherCount += 1.0
                            } label: {
                                Image(systemName: "plus.circle")
                                    .imageScale(.large)
                            }
                            .disabled(pitcherCount == pitcherLimit)
                        }
                        .buttonStyle(.borderless)
                    }
                    .sensoryFeedback(.impact(flexibility: .soft, intensity: hapticsIntensity), trigger: isExpandedCount)
                    .sensoryFeedback(.impact(weight: .light, intensity: hapticsIntensity), trigger: pitcherCount)
                }
            }
            .listStyle(.sidebar)
        }
        .onAppear() {
            pitcherDaysRest = daysRest
            pitcherCountPercentage = countPercentage
            UITextField.appearance().clearButtonMode = .whileEditing
            
            if (doPitcherAddView) {
                focusedField = .pitcherName
            }
        }
        .task(id: allData) {
            pitcherDaysRest = daysRest
            pitcherCountPercentage = countPercentage
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button {
                    focusedField = nil
                } label: {
                    Image(systemName: "keyboard.chevron.compact.down")
                }
            }
        }
        .tint(arrAppTints[selectedAppTintIndex].color)
        .preferredColorScheme(selectedColorScheme == "System" ? nil : selectedColorScheme == "Dark" ? .dark : .light)
    }
}

// MARK: Preview
#Preview {
    @Previewable @State var pitcherName = ""
    @Previewable @State var pitcherDate: Date = .now
    @Previewable @State var pitcherAgeSelectedIndex = 0
    @Previewable @State var pitcherCount = 0.0
    @Previewable @State var pitcherDaysRest = 0
    @Previewable @State var pitcherCountPercentage = 0.0
    
    PitchersCardView(
        pitcherDate: $pitcherDate,
        pitcherName: $pitcherName,
        pitcherAgeSelectedIndex: $pitcherAgeSelectedIndex,
        pitcherCount: $pitcherCount,
        pitcherDaysRest: $pitcherDaysRest,
        pitcherCountPercentage: $pitcherCountPercentage
    )
}
