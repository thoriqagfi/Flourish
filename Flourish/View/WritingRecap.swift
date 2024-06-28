//
//  WritingRecap.swift
//  Flourish
//
//  Created by Riyadh on 26/06/24.
//

import SwiftUI

struct WritingRecap: View {
    var answers: [String]
    var totalWords: Int
    var totalMinutes: String
    var streak: Int
    
    @Environment(\.presentationMode) var presentationMode
    @State private var navigateToHome = false
    @State private var navigateToPlantView = false
    
    var body: some View {
        ZStack {
            VStack {
                Color.customPrimary10
                    .ignoresSafeArea()
            }
            
            VStack {
                VStack(alignment: .center, spacing: 48) {
                    VStack(alignment: .center, spacing: 32) {
                        Image("flame")
                            .frame(width: 129.93457, height: 166.88637)
                        
                        Text("\(streak) Days Streak!")
                            .font(
                                Font.custom("SF Pro", size: 36)
                                    .weight(.bold)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                    }
                    
                    VStack(alignment: .center, spacing: 8) {
                        Text("Daily Reward")
                            .font(
                                Font.custom("SF Pro", size: 16)
                                    .weight(.semibold)
                            )
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)
                        
                        HStack(alignment: .center, spacing: 8) {
                            Text("+5")
                                .font(
                                    Font.custom("SF Pro", size: 34)
                                        .weight(.bold)
                                )
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                            
                            Image("teko-hijau")
                                .frame(width: 40.08226, height: 24.96595)
                        }
                    }
                    .padding(.bottom, 67)
                }
                
                VStack {
                    VStack(alignment: .center, spacing: 20) {
                        HStack(alignment: .center, spacing: 56) {
                            VStack(alignment: .center, spacing: 2) {
                                Text("\(totalWords)")
                                    .font(
                                        Font.custom("SF Pro", size: 28)
                                            .weight(.bold)
                                    )
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.black)
                                
                                Text("Words")
                                    .font(
                                        Font.custom("SF Pro", size: 17)
                                            .weight(.semibold)
                                    )
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
                            }
                            
                            Divider()
                                .frame(height: 64)
                            
                            VStack(alignment: .center, spacing: 2) {
                                Text("\(totalMinutes)")
                                    .font(
                                        Font.custom("SF Pro", size: 28)
                                            .weight(.bold)
                                    )
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.black)
                                
                                Text("Minutes")
                                    .font(
                                        Font.custom("SF Pro", size: 17)
                                            .weight(.semibold)
                                    )
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Color(red: 0.24, green: 0.24, blue: 0.26).opacity(0.6))
                            }
                        }
                        .padding(.horizontal, 40)
                        .padding(.vertical, 15)
                        .frame(width: 353, alignment: .top)
                        
                        HStack {
                            Button(action: {
                                navigateToHome = true
                            }, label: {
                                Image("home")
                                    .padding(20)
                                    .background(Color.customPrimary100)
                                    .cornerRadius(20)
                                    .shadow(color: .black.opacity(0.1), radius: 7.5, x: 0, y: 0)
                            })
                            Button(action: {
                                navigateToPlantView = true
                            }, label: {
                                Text("Water my plant")
                                    .font(
                                        Font.custom("SF Pro", size: 17)
                                            .weight(.semibold)
                                    )
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.black)
                                    .padding(.vertical, 21)
                                    .padding(.horizontal, 78)
                                    .background(Color.customPrimary100)
                                    .frame(height: 64, alignment: .center)
                                    .cornerRadius(20)
                                    .shadow(color: .black.opacity(0.1), radius: 7.5, x: 0, y: 0)
                            })
                        }
                    }
                }
            }
            
            NavigationLink(destination: ContentView(), isActive: $navigateToHome) {
                EmptyView()
            }
            NavigationLink(destination: PlantView(plantViewModel: PlantViewModel(userViewModel: UserViewModel())), isActive: $navigateToPlantView) {
                EmptyView()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    WritingRecap(answers: ["Halo"], totalWords: 10, totalMinutes: "10:51", streak: 10)
}
