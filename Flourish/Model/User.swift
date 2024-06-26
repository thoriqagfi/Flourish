//
//  User.swift
//  Flourish
//
//  Created by Agfi on 23/06/24.
//

import Foundation

struct User: Codable, Hashable {
    var seeds: Int
    var streaks: Int
    var teapot: Int
    
    init(seeds: Int = 0, streaks: Int = 0, teapot: Int = 0) {
        self.seeds = seeds
        self.streaks = streaks
        self.teapot = teapot
    }
}
