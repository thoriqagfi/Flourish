//
//  HomeView.swift
//  Flourish
//
//  Created by Agfi on 23/06/24.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedDayIndex: Int?
    @State private var journalEntries: [JournalEntry] = []
    
    init() {
        _selectedDayIndex = State(initialValue: Calendar.current.component(.weekday, from: Date()) - 1)
    }
    
    var body: some View {
        VStack(spacing: -32) {
            TopBar()
                .zIndex(1)
            ScrollView {
                VStack {
                    Image("PlantBackground")
                        .overlay(alignment: .center) {
                            NavigationLink(destination: PlantView()) {
                                Image("Plant")
                            }
                        }
                    StreakDateCard(selectedDayIndex: $selectedDayIndex)
                        .padding(.top, -32)
                        .padding(.bottom, 32)
                    
                    VStack(spacing: 32) {
                        ForEach(filteredEntries(), id: \.self) { entry in
                            JournalingCard(journalType: "Reflection", date: getSelectedDate(), entry: entry)
                        }
                    }
                    Spacer()
                }
            }
        }
        .background(Color.customPrimary30)
        .onAppear(perform: loadJournalEntries)
    }
    
    func getSelectedDate() -> Date? {
        guard let index = selectedDayIndex else { return nil }
        let today = Date()
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: today)
        let daysToAdd = index - (weekday - 1)
        return calendar.date(byAdding: .day, value: daysToAdd, to: today)
    }
    
    func loadJournalEntries() {
        // Load journal entries using the JournalManager
        journalEntries = JournalManager.shared.loadEntries()
    }
    
    func filteredEntries() -> [JournalEntry] {
        guard let selectedDate = getSelectedDate() else { return [] }
        let calendar = Calendar.current
        let filteredEntries = journalEntries.filter { entry in
            return calendar.isDate(entry.date, inSameDayAs: selectedDate)
        }
        return filteredEntries
    }
}



#Preview {
    ContentView()
}
