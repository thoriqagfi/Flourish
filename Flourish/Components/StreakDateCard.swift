//
//  StreakDateCard.swift
//  Flourish
//
//  Created by Agfi on 23/06/24.
//

import SwiftUI

struct StreakDateCard: View {
    @Binding var selectedDayIndex: Int?
    
    @State private var journalEntries: [JournalEntry] = []
    @State private var showDatePicker = false
    @State private var startDate = Date()
    @State private var endDate = Date().addingTimeInterval(6*24*60*60)
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, d MMMM yyyy"
        return formatter
    }()
    
    let dayOfWeekFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        return formatter
    }()
    
    let dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }()
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                HStack(spacing: 4, content: {
                    Image(systemName: "calendar")
                        .font(.caption2)
                    Text(dateFormatter.string(from: Date()))
                        .font(.caption2)
                        .fontWeight(.semibold)
                })
                Spacer()
                Button(action: {
                    showDatePicker = true
                }) {
                    Text("Show more >")
                        .font(.caption2)
                }
                .sheet(isPresented: $showDatePicker) {
                    DateRangePickerView(startDate: $startDate, endDate: $endDate)
                }
            }
            .foregroundColor(.teks)
            HStack(spacing: 7) {
                ForEach(0..<7) { index in
                    let dayName = dayOfWeek(for: index)
                    let isToday = self.isToday(index)
                    let isDisabled = self.isAfterToday(index)
                    let isEmptyEntry = self.isEmptyEntry(for: index)
                    
                    VStack(spacing: 2, content: {
                        Text(dayName)
                            .fontWeight(.thin)
                            .font(.subheadline)
                        if isToday {
                            Image(systemName: "flame.fill")
                                .font(.headline)
                        } else {
                            Text(dayFormatter.string(from: dayDate(for: index)))
                                .font(.headline)
                                .fontWeight(.semibold)
                        }
                    })
                    .frame(width: 32)
                    .foregroundColor(textColor(for: index, isDisabled: isDisabled, isToday: isToday, isEmptyEntry: isEmptyEntry))
                    .padding(.horizontal, 4)
                    .padding(.vertical, 8)
                    .background(backgroundColor(for: index, isDisabled: isDisabled, isToday: isToday, isEmptyEntry: isEmptyEntry))
                    .cornerRadius(12)
                    .onTapGesture {
                        if !isDisabled {
                            selectedDayIndex = index
                        }
                    }
                }
            }
        }
        .foregroundColor(.customSecondary100)
        .padding()
        .background(Color.customPrimary10)
        .cornerRadius(20)
        .padding(.horizontal, 20)
        .shadow(color: .black.opacity(0.1), radius: 7.5, x: 0, y: 0)
        .onAppear {
            loadJournalEntries()
        }
    }
    
    func dayOfWeek(for index: Int) -> String {
        let today = Date()
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: today)
        let daysToAdd = index - (weekday - 1)
        let date = calendar.date(byAdding: .day, value: daysToAdd, to: today)!
        return dayOfWeekFormatter.string(from: date)
    }
    
    func dayDate(for index: Int) -> Date {
        let today = Date()
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: today)
        let daysToAdd = index - (weekday - 1)
        return calendar.date(byAdding: .day, value: daysToAdd, to: today)!
    }
    
    func isToday(_ index: Int) -> Bool {
        let today = Date()
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: today)
        return index == (weekday - 1)
    }
    
    func isAfterToday(_ index: Int) -> Bool {
        let today = Date()
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: today)
        return index > (weekday - 1)
    }
    
    func isSelected(_ index: Int) -> Bool {
        return selectedDayIndex == index
    }
    
    func backgroundColor(for index: Int, isDisabled: Bool, isToday: Bool, isEmptyEntry: Bool) -> Color {
        if isDisabled {
            return Color.gray.opacity(0.18)
        } else if isSelected(index) {
            return Color.customPrimary100
        } else if isToday {
            return Color.customPrimary80
        } else if isEmptyEntry {
            return Color.customDanger.opacity(0.3)
        } else {
            return Color.customPrimary30
        }
    }
    
    func textColor(for index: Int, isDisabled: Bool, isToday: Bool, isEmptyEntry: Bool) -> Color {
        if isDisabled {
            return Color.gray.opacity(0.3)
        } else if isSelected(index) {
            return Color.black
        } else if isToday {
            return Color.customSecondary100
        } else if isEmptyEntry {
            return Color.customDanger
        } else {
            return Color.customSecondary100
        }
    }
    
    func isEmptyEntry(for index: Int) -> Bool {
        guard let selectedDate = getSelectedDate(for: index) else { return true }
        return !journalEntries.contains { Calendar.current.isDate($0.date, inSameDayAs: selectedDate) }
    }
    
    func loadJournalEntries() {
        journalEntries = JournalManager.shared.loadEntries()
    }
    
    func getSelectedDate(for index: Int) -> Date? {
        let today = Date()
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: today)
        let daysToAdd = index - (weekday - 1)
        return calendar.date(byAdding: .day, value: daysToAdd, to: today)
    }
}

#Preview {
    ContentView()
}
