//
//  HomeView.swift
//  Flourish
//
//  Created by Agfi on 23/06/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(spacing: 0, content: {
            TopBar()
                .zIndex(1)
            ScrollView(content: {
                VStack(content: {
                    Image("PlantBackground")
                        .overlay(alignment: .center, content: {
                            VStack(content: {
                            Image("Plant")
                        })
                    })
                    StreakDateCard()
                    Spacer()
                    JournalingCard()
                    Spacer()
                })
            })
        })
        .background(Color.customPrimary30)
//        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ContentView()
}
