//
//  User.swift
//  Flourish
//
//  Created by Agfi on 23/06/24.
//

import Foundation

import SwiftUI
import Combine

class User: ObservableObject, Codable {
    @Published var seeds: Int
    @Published var streaks: Int
    @Published var teapot: Int

    init(seeds: Int = 0, streaks: Int = 0, teapot: Int = 0) {
        self.seeds = seeds
        self.streaks = streaks
        self.teapot = teapot
    }

    enum CodingKeys: String, CodingKey {
        case seeds
        case streaks
        case teapot
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        seeds = try container.decode(Int.self, forKey: .seeds)
        streaks = try container.decode(Int.self, forKey: .streaks)
        teapot = try container.decode(Int.self, forKey: .teapot)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(seeds, forKey: .seeds)
        try container.encode(streaks, forKey: .streaks)
        try container.encode(teapot, forKey: .teapot)
    }
}
