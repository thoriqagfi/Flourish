//
//  TopicEntry.swift
//  Flourish
//
//  Created by Riyadh Abu Bakar on 23/06/24.
//

import SwiftUI

struct TopicEntry: View {
    @State private var journalText: String = ""
    @State private var isEditing: Bool = false // Track editing state

    var body: some View {
        ZStack {
            // Background overlay
            Color.black.opacity(0.2)
                .edgesIgnoringSafeArea(.all)

            VStack {
                // White frame container
                VStack(alignment: .center, spacing: 16) {
                    Text("Add your topic")
                        .font(Font.custom("SF Pro", size: 20).weight(.semibold))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                    
                    // TextEditor with placeholder
                    ZStack(alignment: .topLeading) {
                        if journalText.isEmpty && !isEditing {
                            Text("Enter your topic here...")
                                .foregroundColor(Color(UIColor.placeholderText))
                                .padding(.horizontal, 8)
                                .padding(.vertical, 10)
                                .allowsHitTesting(false) // Prevents text from being selectable
                        }
                        TextEditor(text: $journalText)
                            .frame(width: 313, height: 187)
                            .scrollContentBackground(.hidden)
                            .background(Color.customPrimary30)
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0.1), radius: 7.5, x: 0, y: 0)
                            .onTapGesture {
                                isEditing = true
                            }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                .padding(.bottom, 20)
                .frame(width: 353)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: .black.opacity(0.1), radius: 7.5, x: 0, y: 0)

                // Generate button
                Button(action: {
                    // Action to perform when button is tapped
                    print("Generate button tapped")
                }) {
                    Text("Generate")
                        .font(Font.custom("SF Pro", size: 20).weight(.semibold))
                        .foregroundColor(.black)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 25)
                        .frame(width: 353)
                        .background(Color.customPrimary100)
                        .cornerRadius(20)
                        .shadow(color: .black.opacity(0.1), radius: 7.5, x: 0, y: 0)
                }
                .padding(.top, 12)
            }
        }
        .frame(width: 393, height: 852)
    }
}

struct TopicEntry_Previews: PreviewProvider {
    static var previews: some View {
        TopicEntry()
    }
}
