//
//  PlantView.swift
//  Flourish
//
//  Created by Agfi on 25/06/24.
//

import SwiftUI

struct PlantView: View {
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
                    .edgesIgnoringSafeArea(.bottom) // This line extends the view to the bottom edge
                    .overlay(content: {
                        VStack(spacing: 60, content: {
                            Text("28/50")
                                .foregroundColor(.customSecondary100)
                                .fontWeight(.bold)
                                .font(.title)
                            Image("Plant")
                            
                            VStack(spacing: 8, content: {
                                Button(action: {
                                    
                                }, label: {
                                    HStack(spacing: 8, content: {
                                        Image(systemName: "plus")
                                        Text("Water")
                                    })
                                    .fontWeight(.semibold)
                                    .padding(.horizontal, 32)
                                    .padding(.vertical, 16)
                                    .foregroundColor(.black)
                                    .background(Color.customPrimary80)
                                    .cornerRadius(20)
                                    .shadow(color: .black.opacity(0.1), radius: 7.5, x: 0, y: 0)
                                })
                                
                                HStack(content: {
                                    Image("teko")
                                    Text("29")
                                        .foregroundColor(.white)
                                })
                            })
                        })
                        .offset(CGSize(width: 0, height: -100.0))
                    })
            }
            .background(Color.customPrimary10)
        }
    }
}

#Preview {
    ContentView()
}
