//
//  PromptedTextbox.swift
//  Flourish
//
//  Created by Riyadh on 24/06/24.
//

import SwiftUI

struct PromptedTextbox: View {
    var question: String
    @Binding var answer: String
    var topic: String
    var regeneratePrompt: (() -> Void)?

    var body: some View {
        VStack(alignment: .center, spacing: 32) {
            VStack (alignment: .center, spacing: 16){
                Text(question)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.teks)
                    .frame(width: 312, height: 75 , alignment: .topLeading)
                
                Button(action: {
                    regeneratePrompt?()
                }) {
                    Text("Regenerate Prompt")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.teks)
                        .frame(width: 220, height: 40)
                        .background(Color.customPrimary100)
                        .cornerRadius(10)
                        .shadow(color: .black.opacity(0.15), radius: 2, x: 0, y: 0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.customPrimary100, lineWidth: 1)
                        )
                }
                .frame(width: 312)
            }
            Rectangle()
                .frame(width: 312, height: 1)
                .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
            
            CustomTextEditor(text: $answer, placeholder: "Enter your answer...")
                .foregroundColor(.teks.opacity(0.8))
                .frame(width: 312, height: 320)
                .background(Color.customPrimary10)
                .cornerRadius(10)
                .padding(.vertical, 10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.customPrimary10, lineWidth: 1)
                )
            
            Spacer()
        }

        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .frame(width: 353, height: 685)
        .background(Color.customPrimary10)
        .cornerRadius(10)
        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 0)
        .onTapGesture {
            hideKeyboard()
        }
    }
}

struct PromptedTextbox_Previews: PreviewProvider {
    @State static var dummyAnswer: String = "Initial answer"
    
    static var previews: some View {
        PromptedTextbox(question: "Sample Question fanlndflanflndalfnalnfladnfldanlfnakfnaklnfdlanfklanflkadasm;kdmak;sdm;asdasdklasndklsandklsasndlasndlsandlandklandlandlkansdlnlandklsadnlaldnlsaknddsalknda", answer: $dummyAnswer, topic: "Sample Topic")
    }
}


extension View {
func hideKeyboard() {
    let resign = #selector(UIResponder.resignFirstResponder)
    UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
  }
}
