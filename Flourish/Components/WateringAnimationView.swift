//
//  WateringAnimationView.swift
//  Flourish
//
//  Created by Agfi on 27/06/24.
//

import SwiftUI

struct WateringAnimationView: View {
    var body: some View {
        VStack {
            Spacer()
            LottieViewComponent()
                .frame(width: 200, height: 200)
                .offset(CGSize(width: -80.0, height: 0.0))
            Spacer()
        }
    }
}

#Preview {
    WateringAnimationView()
}
