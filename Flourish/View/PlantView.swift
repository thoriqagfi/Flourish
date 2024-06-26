//
//  PlantView.swift
//  Flourish
//
//  Created by Agfi on 25/06/24.
//

import SwiftUI

struct PlantView: View {
    @ObservedObject var plantViewModel: PlantViewModel
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .top) {
                    UserStats()
                    Spacer()
                    VStack(spacing: 16) {
                        Button(action: {
                            // Action for gift button
                        }) {
                            Image(systemName: "gift")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .foregroundStyle(Color.customSecondary100)
                                .padding(16)
                                .background(Color.white)
                                .cornerRadius(30)
                                .shadow(color: .black.opacity(0.1), radius: 7.5, x: 0, y: 0)
                        }
                        Button(action: {
                            // Action for book button
                        }) {
                            Image(systemName: "book.closed")
                                .resizable()
                                .frame(width: 32, height: 32)
                                .foregroundStyle(Color.customSecondary100)
                                .padding(16)
                                .background(Color.white)
                                .cornerRadius(30)
                                .shadow(color: .black.opacity(0.1), radius: 7.5, x: 0, y: 0)
                        }
                        Button(action: {
                            // Action for badge button
                        }) {
                            Image("fi-rr-badge")
                                .foregroundStyle(Color.customSecondary100)
                                .padding(16)
                                .background(Color.white)
                                .cornerRadius(30)
                                .shadow(color: .black.opacity(0.1), radius: 7.5, x: 0, y: 0)
                        }
                    }
                }
                .padding()
                Spacer()
                Image("cloud")
                    .overlay(content: {
                    })
                Image("grass")
                    .resizable()
                    .edgesIgnoringSafeArea(.bottom)
                    .overlay(content: {
                        VStack(spacing: 60) {
                            Text("\(plantViewModel.selectedPlant!.amountFlushed)/\(plantViewModel.selectedPlant!.countFlushedtoFinish)")
                                .foregroundColor(.customSecondary100)
                                .fontWeight(.bold)
                                .font(.title)
                            
                            Image("\(plantViewModel.selectedPlant!.name)")
                            
                            VStack(spacing: 8) {
                                Button(action: {
                                    plantViewModel.flushSelectedPlant()
                                }) {
                                    HStack(spacing: 8) {
                                        Image(systemName: "plus")
                                        Text("Water")
                                    }
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 32)
                                    .padding(.vertical, 16)
                                    .foregroundColor(.black)
                                    .background(Color.customPrimary80)
                                    .cornerRadius(20)
                                    .shadow(color: .black.opacity(0.1), radius: 7.5, x: 0, y: 0)
                                }
                                
                                HStack {
                                    Image("teko")
                                    Text("\(plantViewModel.user.teapot)")
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        .offset(y: -100.0)
                    })
            }
            .background(Color.customPrimary10)
        }
    }
}

#Preview {
    ContentView()
}
