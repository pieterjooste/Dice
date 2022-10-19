//
//  FileManager.swift
//  Dice
//
//  Created by Pieter Jooste on 2022/07/01.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
