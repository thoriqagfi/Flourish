//
//  Plant.swift
//  Flourish
//
//  Created by Agfi on 26/06/24.
//

import Foundation

struct Plant: Codable, Hashable {
    var name: String
    var amountFlushed: Int
    var countFlushedtoFinish: Int
    
    init(name: String, amountFlushed: Int, countFlushedtoFinish: Int) {
        self.name = name
        self.amountFlushed = amountFlushed
        self.countFlushedtoFinish = countFlushedtoFinish
    }
}
