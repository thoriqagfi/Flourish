//
//  PromptedTextbox.swift
//  Flourish
//
//  Created by Agfi on 24/06/24.
//

import SwiftUI

struct PromptedTextbox: View {
    var question: String // Accept a single question
    @Binding var answer: String // Bind the answer to the ActivityEntry's state
    var topic: String // The topic associated with this journal entry
    
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
            
            // TextEditor for user's answer
            TextEditor(text: $answer)
                .font(Font.custom("SF Pro", size: 15))
                .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
                .frame(width: 312, height: 200, alignment: .topLeading)
                .background(Color.customPrimary30)
                .cornerRadius(10)
                .onChange(of: answer) { newAnswer in
                    // Update the answer using JournalManager
                    JournalManager.shared.updateAnswer(for: topic, question: question, answer: newAnswer)
                }
            
            Divider()
                .frame(width: 312, height: 1)
                .background(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
            
            // Button to regenerate prompt (if needed)
            Button(action: {
                print("Regenerate button tapped")
                // Implement your logic for regenerating the prompt if required
            }) {
                Text("Regenerate Prompt")
                    .font(
                        Font.custom("SF Pro", size: 15)
                            .weight(.semibold)
                    )
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
                    .frame(width: 220)
                    .padding(.vertical, 12)
                    .background(Color.customPrimary30)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.customPrimary30, lineWidth: 1)
                    )
                    .shadow(color: .black.opacity(0.15), radius: 2, x: 0, y: 0)
            }
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
