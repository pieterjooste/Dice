//
//  Throws.swift
//  Dice
//
//  Created by Pieter Jooste on 2022/07/01.
//

import Foundation

struct Throw: Codable, Hashable {
    let throwNumber: Int
    let diceNumber: Int
    let total: Int
    let sides: Int
}
