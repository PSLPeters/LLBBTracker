//
//  GamesMainView.swift
//  BaseballTracker
//
//  Created by Michael Peters on 3/14/25.
//

import SwiftUI
import SwiftData

struct GamesMainView: View {
    
    // MARK: AppStorage variables
    @AppStorage("selectedColorScheme") private var selectedColorScheme = "System"
    @AppStorage("selectedAppTintIndex") var selectedAppTintIndex = 0
    @AppStorage("selectedGameColumnIndex") var selectedGameColumnIndex = 0
    @AppStorage("doHaptics") private var doHaptics = true
    @AppStorage("doGameAddView") private var doGameAddView = false
    
    // MARK: @State variables
    @State private var isShowingGamesFullScreenCover = false
    @State private var gameToEdit: modelGame?
    @State private var searchTerm = ""
    
    // MARK: Haptic toggles
    @State private var deleteGameHapticToggle = false
    
    // MARK: Other variables
    @FocusState private var focusedField: FocusedField?
    
    @Environment(\.modelContext) var context
    @Query(sort: \modelGame.gameDate)
    
    var arrGames: [modelGame] = []
    
    var arrFilteredGames: [modelGame]
    {
        guard !searchTerm.isEmpty else { return arrGames }
        return arrGames.filter
        {
            $0.gameOpponent.localizedCaseInsensitiveContains(searchTerm)
        }
    }
    
    // MARK: Body
    var body: some View {
        NavigationStack{
            List {
                Section {
                    ForEach(arrFilteredGames) { game in
                        GamesCellView(game: game)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                doGameAddView = false
                                gameToEdit = game
                            }
                    }
                    .onDelete(perform: { indexSet in
                        for index in indexSet {
                            context.delete(arrFilteredGames[index])
                            doHaptics ? deleteGameHapticToggle.toggle() : nil
                        }
                    })
                    .sensoryFeedback(.error, trigger: deleteGameHapticToggle)
                } header: {
                    if !arrFilteredGames.isEmpty {
                        HStack {
                            Text("Date - Opponent")
                            Spacer()
                            Text(arrGameColumns[selectedGameColumnIndex].name)
                        }
                    }
                } footer: {
                    let winCount = arrFilteredGames.filter { $0.gameWinLossString == "Win" }.count
                    let lossCount = arrFilteredGames.filter { $0.gameWinLossString == "Loss" }.count
                    let tieCount = arrFilteredGames.filter { $0.gameWinLossString == "Tie" }.count
                    
                    let winPercent = Double(winCount) / Double(arrFilteredGames.count)
                    let lossPercent = Double(lossCount) / Double(arrFilteredGames.count)
                    let tiePercent = Double(tieCount) / Double(arrFilteredGames.count)
                    
                    var footerString : String {
                        [
                            "Games Played: \(arrFilteredGames.count)",
                            "--------------------",
                            "Wins: \(String(winCount)) (\(winPercent.formatted(.percent.precision(.fractionLength(2)))))",
                            "Losses: \(String(lossCount)) (\(lossPercent.formatted(.percent.precision(.fractionLength(2)))))",
                            "Ties: \(String(tieCount)) (\(tiePercent.formatted(.percent.precision(.fractionLength(2)))))"
                        ].joined(separator: "\n")
                    }
                    HStack {
                        Spacer()
                        if !arrFilteredGames.isEmpty {
                            Text(footerString)
                                .multilineTextAlignment(.trailing)
                        }
                    }
                }
            }
            .navigationTitle("Games")
            .searchable(text: $searchTerm, prompt: "Search")
            .fullScreenCover(
                isPresented: $isShowingGamesFullScreenCover
            ) {
                GamesAddView()
            }
            .fullScreenCover(item: $gameToEdit)
            {
                game in
                GamesUpdateView(game: game)
            }
            .toolbar {
                ToolbarItemGroup(placement: .topBarLeading) {
                    if !arrGames.isEmpty
                    {
                        EditButton()
                    }
                }
                ToolbarItemGroup(placement: .topBarTrailing) {
                    if !arrGames.isEmpty
                    {
                        Button("", systemImage: "plus")
                        {
                            doGameAddView = true
                            isShowingGamesFullScreenCover = true
                        }
                    }
                }
            }
            .overlay {
                if arrGames.isEmpty {
                    ContentUnavailableView(
                        label:
                            {
                                Label("No Games", systemImage: "baseball.diamond.bases.outs.indicator")
                                    .imageScale(.large)
                            }
                        , description:
                            {
                                Text("Start adding games to track scores.")
                            }
                        , actions:
                            {
                                if #available(iOS 26.0, *) {
                                    Button("Add Game")
                                    {
                                        doGameAddView = true
                                        isShowingGamesFullScreenCover = true
                                    }
                                    .padding()
                                    .glassEffect(.regular.interactive())
                                } else {
                                    Button("Add Game")
                                    {
                                        doGameAddView = true
                                        isShowingGamesFullScreenCover = true
                                    }
                                }
                            }
                    )
                }
            }
        }
        .tint(arrAppTints[selectedAppTintIndex].color)
        .preferredColorScheme(selectedColorScheme == "System" ? nil : selectedColorScheme == "Dark" ? .dark : .light)
    }
}

// MARK: Preview
#Preview {
    GamesMainView()
}
