//
//  EssenceError.swift
//  Essence
//
//  Created by Cole Riggle on 1/7/21.
//

import Foundation

struct EssenceError: Error {
    let message: String

    init(_ message: String) {
        self.message = message
    }

    public var localizedDescription: String {
        return message
    }
}
