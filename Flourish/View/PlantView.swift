//
//  PlantView.swift
//  Flourish
//
//  Created by Agfi on 25/06/24.
//

import SwiftUI
import Lottie

struct PlantView: View {
    @ObservedObject var plantViewModel: PlantViewModel

    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 0) {
                HStack(alignment: .top) {
                    UserStats(userViewModel: plantViewModel.userViewModel)
                    Spacer()
                    VStack(spacing: 16) {
                        Button(action: {
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
                            print("Selected plant: \(plantViewModel.selectedPlant)")
                            print("Plants: \(plantViewModel.plants)")
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
                            Text("\(plantViewModel.selectedPlant?.amountFlushed ?? 0)/\(plantViewModel.selectedPlant?.countFlushedtoFinish ?? 0)")
                                .foregroundColor(.customSecondary100)
                                .fontWeight(.bold)
                                .font(.title)
                                .animation(.easeInOut, value: plantViewModel.selectedPlant?.amountFlushed ?? 1)

                            PlantImageView(imageBackground: "\(plantViewModel.selectedPlant?.name ?? "Plant")", imageFill: "\(plantViewModel.selectedPlant?.name ?? "Plant")-fill", amountFlushed: plantViewModel.selectedPlant?.amountFlushed ?? 0, countFlushedtoFinish: plantViewModel.selectedPlant?.countFlushedtoFinish ?? 50)
                                .scaleEffect(plantViewModel.isWatering ? 1.1 : 1.0)
                                .animation(.spring(), value: plantViewModel.isWatering)

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
                                    Text("\(plantViewModel.userViewModel.user.teapot)")
                                        .foregroundColor(.white)
                                }
                            }
                        }
                        .offset(y: -100.0)
                    })
            }
            .background(Color.customPrimary10)
            .overlay(
                Group {
                    if plantViewModel.isWatering {
                        WateringAnimationView()
                    }
                }
            )
        }
    }
}

#Preview {
    ContentView()
}
