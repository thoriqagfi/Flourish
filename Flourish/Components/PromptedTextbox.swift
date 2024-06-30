//
//  PromptedTextbox.swift
//  Flourish
//
//  Created by Riyadh on 24/06/24.
//

import SwiftUI
import GoogleGenerativeAI

struct PromptedTextbox: View {
    @Binding var question: String
    @Binding var answer: String
    var topic: String
    @Binding var isLoading: Bool
    @State private var showDevelopmentModal = false
    let model = GenerativeModel(name: "gemini-pro", apiKey: "AIzaSyCw_Qr1xj_qgA1yQcxK_9-hZwh7Otn5k8U")
    
    var body: some View {
        VStack(alignment: .center, spacing: 32) {
            VStack(alignment: .center, spacing: 16) {
                Text(question)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.teks)
                    .frame(width: 312, height: 75, alignment: .topLeading)
                
                HStack(spacing: 6) {
                    Button(action: {
                        //                        regenerateQuestions()
                        showDevelopmentModal = true
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
                    
                    Button(action: {
                        //                        addQuestion()
                        showDevelopmentModal = true
                    }) {
                        Text("+")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.teks)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 16)
                            .background(Color.customPrimary100)
                            .cornerRadius(10)
                            .shadow(color: .black.opacity(0.15), radius: 2, x: 0, y: 0)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.customPrimary100, lineWidth: 1)
                            )
                    }
                }
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
        .alert(isPresented: $showDevelopmentModal) {
            Alert(
                title: Text("Feature Under Development"),
                message: Text("The feature is under development!"),
                dismissButton: .default(Text("Ok"))
            )
        }
    }
    
    private func regenerateQuestions() {
        isLoading = true
        let oldQuestion = question
        print("Old Question: \(oldQuestion)")
        Task {
            let prompt = "I want to write a journal with a topic \(topic). Can you help me make a prompt question to help me writing? Provide me with a only one question without any following questions or additional description."
            do {
                let response = try await model.generateContent(prompt)
                if let text = response.text {
                    let newQuestion = text.trimmingCharacters(in: .whitespacesAndNewlines)
                    if !newQuestion.isEmpty {
                        DispatchQueue.main.async {
                            question = newQuestion
                            JournalManager.shared.updateQuestion(for: topic, oldQuestion: oldQuestion, newQuestion: newQuestion)
                        }
                    }
                }
            } catch {
                print("Error generating question: \(error.localizedDescription)")
            }
            DispatchQueue.main.async {
                isLoading = false
            }
        }
    }
    
    private func addQuestion() {
        isLoading = true
        print("Add question function running")
        Task {
            let prompt = "I want to write a journal with a topic \(topic). Can you help me make a prompt question to help me writing? Provide me with 1 main question without any following questions or additional description."
            do {
                let response = try await model.generateContent(prompt)
                if let text = response.text {
                    let newQuestion = text.trimmingCharacters(in: .whitespacesAndNewlines)
                    if !newQuestion.isEmpty {
                        DispatchQueue.main.async {
                            question = newQuestion
                        }
                    }
                }
            } catch {
                print("Error generating question: \(error.localizedDescription)")
            }
            DispatchQueue.main.async {
                isLoading = false
            }
        }
    }
}

struct PromptedTextbox_Previews: PreviewProvider {
    @State static var dummyQuestion: String = "Initial question"
    @State static var dummyAnswer: String = "Initial answer"
    @State static var isLoading: Bool = false
    
    static var previews: some View {
        PromptedTextbox(question: $dummyQuestion, answer: $dummyAnswer, topic: "Sample Topic", isLoading: $isLoading)
        //        ContentView()
    }
}


extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
