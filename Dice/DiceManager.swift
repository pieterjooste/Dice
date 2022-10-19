//
//  DiceManager.swift
//  Dice
//
//  Created by Pieter Jooste on 2022/07/01.
//

import Foundation
import SwiftUI

class DiceManager: ObservableObject {
    @Published var throwArray: [Throw]
    @Published var throwNumber:Int = 0
    @Published var total:Int = 0
    @Published var diceNumber:Int = 5
    @Published var sides:Int = 6
    
    @Published var feedback = UINotificationFeedbackGenerator()
    
    let saveKey = "SavedData"
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedData")
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            throwArray = try JSONDecoder().decode([Throw].self, from: data)
        } catch {
            throwArray = []
        }
    }

    func save () {
        do {
            let data = try JSONEncoder().encode(throwArray)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data")
        }
    }
    
    func loadData() {
        do {
            let data = try Data(contentsOf: savePath)
            throwArray = try JSONDecoder().decode([Throw].self, from: data)
        } catch {
            throwArray = []
        }
        if let lastElement = throwArray.last {
            throwNumber = lastElement.throwNumber
            diceNumber = lastElement.diceNumber
            total = lastElement.total
            sides = lastElement.sides
        }
    }
    
    func rollDice() {
        throwNumber += 1
        diceNumber = Int.random(in: 1...sides)
        total = total + diceNumber
        let roll = Throw(throwNumber: throwNumber, diceNumber: diceNumber, total: total, sides: sides)
        throwArray.append(roll)
        save()
        feedback.notificationOccurred(.success)
    }
    
    func reset() {
        throwArray = []
        throwNumber = 0
        total = 0
        diceNumber = 5
        sides = 6
        save()
    }
}
