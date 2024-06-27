//
//  DateRangePickerView.swift
//  Flourish
//
//  Created by Agfi on 27/06/24.
//

import SwiftUI

struct DateRangePickerView: View {
    @Binding var startDate: Date
    @Binding var endDate: Date
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Select Date Range")
                .font(.headline)
                .padding()

            DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()

            DatePicker("End Date", selection: $endDate, in: startDate...(startDate.addingTimeInterval(6*24*60*60)), displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())
                .padding()

            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Done")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
            }
        }
        .padding()
        .background(Color.customPrimary10)
    }
}
