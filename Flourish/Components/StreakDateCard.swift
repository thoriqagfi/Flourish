//
//  StreakDateCard.swift
//  Flourish
//
//  Created by Agfi on 23/06/24.
//

import SwiftUI

struct StreakDateCard: View {
    @Binding var selectedDayIndex: Int?
    
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
            HStack(spacing: 7) {
                ForEach(0..<7) { index in
                    let dayName = dayOfWeek(for: index)
                    let isToday = self.isToday(index)
                    let isDisabled = self.isAfterToday(index)
                    
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
                    .foregroundColor(isDisabled ? .gray.opacity(0.3) : .customSecondary100)
                    .padding(.horizontal, 4)
                    .padding(.vertical, 8)
                    .background(backgroundColor(for: index, isDisabled: isDisabled, isToday: isToday))
                    .cornerRadius(12)
                    .onTapGesture {
                        if !isDisabled {
                            selectedDayIndex = index
                        }
                    }
                }
            }
            
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
                    // Action for "Show more" button
                }) {
                    Text("Show more >")
                        .font(.caption2)
                }
            }
        }
        .foregroundColor(.customSecondary100)
        .padding()
        .background(Color.customPrimary10)
        .cornerRadius(20)
        .padding(.horizontal, 20)
        .shadow(color: .black.opacity(0.1), radius: 7.5, x: 0, y: 0)
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
    
    func backgroundColor(for index: Int, isDisabled: Bool, isToday: Bool) -> Color {
        if isDisabled {
            return Color.gray.opacity(0.18)
        } else if isSelected(index) {
            return Color.customPrimary100
        } else if isToday {
            return Color.customPrimary80
        } else {
            return Color.customPrimary30
        }
    }
}



#Preview {
    ContentView()
}
