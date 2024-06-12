//
//  Tamagotchi.swift
//  Tamagotchi
//
//  Created by gnksbm on 6/9/24.
//

import Foundation

struct Tamagotchi: Hashable {
    let character: TamaCharacter
    private var level: Int
    private var foodCount: Int
    private var waterCount: Int
}

extension Tamagotchi {
    var visibleLevel: String {
        "LV\(level)"
    }
    
    var visibleFood: String {
        "밥알 \(foodCount)개"
    }
    
    var visibleWater: String {
        "물방울 \(level)개"
    }
    
    mutating func feedingFood(count: Int) -> String {
        foodCount += count
        levelCheck()
        return getFeedingMessage(type: .food, count: count)
    }
    
    mutating func feedingWater(count: Int) -> String {
        waterCount += count
        levelCheck()
        return getFeedingMessage(type: .water, count: count)
    }
    
    mutating private func levelCheck() {
        level = max(1, (foodCount / 5) + (waterCount / 2))
    }
    
    private func getFeedingMessage(type: FeedingType, count: Int) -> String {
        ""
    }
}

extension Tamagotchi {
    struct TamaCharacter: Hashable {
        let name: String
        let imageName: String
        let introduceMessage: String
    }
    
    enum FeedingType {
        case food, water
    }
}
