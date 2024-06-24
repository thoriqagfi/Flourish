//
//  PromptedTextbox.swift
//  Flourish
//
//  Created by Agfi on 24/06/24.
//

import SwiftUI

struct PromptedTextbox: View {
    var question: String // Accept a single question
    @Binding var currentPage: Int // Binding to currentPage
    var totalQuestions: Int // Total number of questions
    @State private var answer: String = ""
    
    var body: some View {
        VStack(alignment: .center, spacing: 32) {
            
            // Subheadline/Emphasized
            Text(question)
                .font(
                    Font.custom("SF Pro", size: 15)
                        .weight(.semibold)
                )
                .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
                .frame(width: 312, alignment: .topLeading)
            
            Button(action: {
                // Print a message to the console
                print("Regenerate button tapped")
            }) {
                HStack(alignment: .center, spacing: 10) {
                    // Subheadline/Emphasized
                    Text("Regenerate Prompt")
                        .font(
                            Font.custom("SF Pro", size: 15)
                                .weight(.semibold)
                        )
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
                        .frame(width: 220, alignment: .top)
                }
                .padding(.horizontal, 46)
                .padding(.vertical, 12)
                .background(Color.customPrimary30)
                .cornerRadius(10)
                .shadow(color: .black.opacity(0.15), radius: 2, x: 0, y: 0)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .inset(by: 0.5)
                        .stroke(Color.customPrimary30, lineWidth: 1)
                )
            }
            
            Rectangle()
                .frame(width: 312, height: 1)
                .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
            
            // Subheadline/Regular
            TextEditor(text: $answer)
                .font(Font.custom("SF Pro", size: 15))
                .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
                .frame(width: 312, height: 200, alignment: .topLeading)
                .background(Color.customPrimary30)
                .cornerRadius(10)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: 353, height: 685)
        .background(Color.customPrimary30)
        .cornerRadius(10)
    }
}


#Preview {
    ContentView()
}
