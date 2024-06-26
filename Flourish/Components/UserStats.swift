//
//  UserStats.swift
//  Flourish
//
//  Created by Agfi on 25/06/24.
//

import SwiftUI

struct UserStats: View {
    @State private var user: User = UserManager.shared.getCurrentUser()
    
    var body: some View {
        HStack(spacing: 16, content: {
            HStack(spacing: 8, content: {
                Image(systemName: "leaf.fill")
                Text("\(user.seeds) Seeds")
            })
            HStack(spacing: 8, content: {
                Image(systemName: "flame.fill")
                Text("\(user.streaks) Streak")
            })
        })
        .foregroundColor(.customSecondary100)
    }
}

#Preview {
    ContentView()
}
