//
//  PitchersMainView.swift
//  BaseballTracker
//
//  Created by Michael Peters on 3/9/25.
//

import SwiftUI
import SwiftData
import Foundation

struct PitchersMainView: View {
    
    // MARK: AppStorage variables
    @AppStorage("selectedColorScheme") private var selectedColorScheme = "System"
    @AppStorage("selectedAppTintIndex") var selectedAppTintIndex = 0
    @AppStorage("selectedPitcherColumnIndex") var selectedPitcherColumnIndex = 0
    @AppStorage("doHaptics") private var doHaptics = true
    @AppStorage("doPitcherAddView") private var doPitcherAddView = false
    
    // MARK: @State variables
    @State private var isShowingPitcherFullScreenCover = false
    @State private var pitcherToEdit: modelPitcher?
    @State private var searchTerm = ""
    
    // MARK: Haptic toggles
    @State private var deletePitcherHapticToggle = false
    
    // MARK: Other variables
    @Environment(\.modelContext) var context
    @Query(sort: \modelPitcher.pitcherDate)
    
    var arrPitchers: [modelPitcher] = []
    
    var arrFilteredPitchers: [modelPitcher]
    {
        guard !searchTerm.isEmpty else { return arrPitchers }
        return arrPitchers.filter
        {
            $0.pitcherName.localizedCaseInsensitiveContains(searchTerm)
        }
    }
    
    // MARK: Body
    var body: some View {        
        NavigationStack{
            List {
                Section {
                    ForEach(arrFilteredPitchers) { pitcher in
                        PitchersCellView(pitcher: pitcher)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                doPitcherAddView = false
                                pitcherToEdit = pitcher
                            }
                    }
                    .onDelete(perform: { indexSet in
                        for index in indexSet {
                            context.delete(arrFilteredPitchers[index])
                            doHaptics ? deletePitcherHapticToggle.toggle() : nil
                        }
                    })
                    .sensoryFeedback(.error, trigger: deletePitcherHapticToggle)
                } header: {
                    if !arrFilteredPitchers.isEmpty {
                        HStack {
                            Text("Date - Pitcher")
                            Spacer()
                            Text(arrPitcherColumns[selectedPitcherColumnIndex].name)
                        }
                    }
                } footer: {
                    HStack {
                        Spacer()
                        if !arrFilteredPitchers.isEmpty {
                            Text("Pitchers: \(arrFilteredPitchers.count)")
                        }
                    }
                }
            }
            .navigationTitle("Pitchers")
            .fullScreenCover(
                isPresented: $isShowingPitcherFullScreenCover
            ) {
                PitchersAddView()
            }
            .fullScreenCover(item: $pitcherToEdit)
            {
                pitcher in
                PitchersUpdateView(pitcher: pitcher)
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    if !arrPitchers.isEmpty
                    {
                        EditButton()
                    }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    if !arrPitchers.isEmpty
                    {
                        Button("", systemImage: "plus")
                        {
                            doPitcherAddView = true
                            isShowingPitcherFullScreenCover = true
                        }
                    }
                }
            }
            .overlay {
                if arrPitchers.isEmpty {
                    ContentUnavailableView(
                        label:
                            {
                                Label("No Pitchers", systemImage: "baseball")
                                    .imageScale(.large)
                            }
                        , description:
                            {
                                Text("Start adding pitchers to track pitch counts.")
                            }
                        , actions:
                            {
                                if #available(iOS 26.0, *) {
                                    Button("Add Pitcher")
                                    {
                                        doPitcherAddView = true
                                        isShowingPitcherFullScreenCover = true
                                    }
                                    .padding()
                                    .glassEffect(.regular.interactive())
                                } else {
                                    Button("Add Pitcher")
                                    {
                                        doPitcherAddView = true
                                        isShowingPitcherFullScreenCover = true
                                    }
                                }
                            }
                    )
                }
            }
        }
        .searchable(text: $searchTerm, prompt: "Search")
        .tint(arrAppTints[selectedAppTintIndex].color)
        .preferredColorScheme(selectedColorScheme == "System" ? nil : selectedColorScheme == "Dark" ? .dark : .light)
    }
}

// MARK: Preview
#Preview {
    PitchersMainView()
}
