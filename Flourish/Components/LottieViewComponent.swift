//
//  LottieViewComponent.swift
//  Flourish
//
//  Created by Agfi on 26/06/24.
//

import SwiftUI
import Lottie

struct LottieViewComponent: View {
    @State var playbackMode = LottiePlaybackMode.playing(LottiePlaybackMode.PlaybackMode.fromProgress(0, toProgress: 1, loopMode: .playOnce))
    
    var body: some View {
        VStack {
            LottieView(animation: .named("watering"))
                .playbackMode(playbackMode)
                .animationDidFinish { _ in
                }
        }
    }
}

#Preview {
    LottieViewComponent()
}
