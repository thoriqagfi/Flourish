//
//  ContentView.swift
//  Flourish
//
//  Created by Agfi on 23/06/24.
//

import SwiftUI


struct ContentView: View {
    @State private var selection: Tab = .home
    @State private var showingNewEntrySheet = false

    enum Tab {
        case home
        case newEntry
        case profile
    }

    var body: some View {
        ZStack {
            TabView(selection: $selection) {
                Group {
                    HomeView()
                        .tabItem {
                            Label("Home", systemImage: "house.fill")
                        }
                        .tag(Tab.home)

                    NewEntry()
                        .tabItem {
                            Label("Profile", systemImage: "person.fill")
                        }
                        .tag(Tab.profile)
                }
                .toolbarBackground(.white, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
            }
            .accentColor(.orange)
            .shadow(color: .gray.opacity(0.2), radius: 4, x: 0, y: 2)

            GeometryReader { geometry in
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            showingNewEntrySheet = true
                        }) {
                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 60, height: 60)
                                .foregroundColor(.orange.opacity(0.6))
                                .background(Color.white)
                                .clipShape(Circle())
                                .shadow(color: .gray, radius: 4, x: 0, y: 4)
                        }
                        .padding(.bottom, geometry.safeAreaInsets.bottom + 40)
                        Spacer()
                    }
                }
            }
            .edgesIgnoringSafeArea(.all)
        }
        .sheet(isPresented: $showingNewEntrySheet) {
            NewEntry()
        }
    }
}
#Preview {
    ContentView()
}