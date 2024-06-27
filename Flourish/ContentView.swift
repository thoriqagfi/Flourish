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
    @State private var showPopup = false

    enum Tab {
        case home
        case newEntry
        case profile
    }

    var body: some View {
        NavigationView {
            ZStack {
                TabView(selection: $selection) {
                    Group {
                        HomeView()
                            .tabItem {
                                Label("Home", systemImage: "house.fill")
                            }
                            .tag(Tab.home)

                        Text("Profile")
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
                                Image("fi-rr-file-add")
                                    .padding()
                                    .background(Color.customPrimary100)
                                    .clipShape(Circle())
                                    .shadow(color: .black.opacity(0.1), radius: 7.5, x: 0, y: 0)
                            }
                            .padding(.bottom, geometry.safeAreaInsets.bottom + 40)
                            Spacer()
                        }
                    }
                }
                .edgesIgnoringSafeArea(.all)
                
                if showPopup {
                    PopupView(showPopup: $showPopup)
                }
            }
            .sheet(isPresented: $showingNewEntrySheet) {
                NewEntry(showPopup: $showPopup, showingNewEntrySheet: $showingNewEntrySheet)
            }
        }
    }
}


#Preview {
    ContentView()
}
