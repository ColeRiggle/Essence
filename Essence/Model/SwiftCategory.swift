//
//  Category.swift
//  Essence
//
//  Created by Cole Riggle on 11/26/20.
//

import Foundation

struct SwiftCategory {
    
    let name: String
    let lastStudied: Date
    let cardCount: Int
    
    init(name: String, lastStudied: Date, cardCount: Int) {
        self.name = name
        self.lastStudied = lastStudied
        self.cardCount = cardCount
    }
    
}
