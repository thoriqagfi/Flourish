//
//  ActivityEntry.swift
//  Flourish
//
//  Created by Agfi on 24/06/24.
//

import SwiftUI

struct ActivityEntry: View {
    @State private var currentPage = 0

    private let rectCount = 5
    private let rectWidth: CGFloat = 67
    private let rectHeight: CGFloat = 4
    private let rectSpacing: CGFloat = 5

    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: rectSpacing) {
                ForEach(0..<rectCount, id: \.self) { index in
                    Rectangle()
                        .frame(width: rectWidth, height: rectHeight)
                        .foregroundColor(self.getRectangleColor(for: index))
                        .cornerRadius(rectHeight / 2)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)

            TabView(selection: $currentPage) {
                ForEach(0..<5, id: \.self) { index in
                    PromptedTextbox()
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Hide page status indicators
            .onAppear {
                // Ensure currentPage is set correctly when the view appears
                currentPage = 0 // or set it to the index you want initially selected
            }
        }
    }

    private func getRectangleColor(for index: Int) -> Color {
        if index <= currentPage {
            return Color.customPrimary100 // Adjust this to your actual color
        } else {
            return Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.18)
        }
    }
}

struct ActivityEntry_Previews: PreviewProvider {
    static var previews: some View {
        ActivityEntry()
    }
}
