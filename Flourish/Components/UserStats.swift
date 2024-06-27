//
//  UserStats.swift
//  Flourish
//
//  Created by Agfi on 25/06/24.
//

import SwiftUI

struct UserStats: View {
    @ObservedObject var userViewModel: UserViewModel
    
    var body: some View {
        HStack(spacing: 16, content: {
            HStack(spacing: 8, content: {
                Image(systemName: "leaf.fill")
                Text("\(userViewModel.user.seeds) Seeds")
            })
            HStack(spacing: 8, content: {
                Image(systemName: "flame.fill")
                Text("\(userViewModel.user.streaks) Streak")
            })
            HStack(spacing: 8, content: {
                Image("teko-hijau")
                    .resizable()
                    .frame(width: 25, height: 18)
                Text("\(userViewModel.user.teapot) Gembor")
            })
        })
        .foregroundColor(.customSecondary100)
    }
}

#Preview {
    ContentView()
}
