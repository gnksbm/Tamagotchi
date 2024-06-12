//
//  Tamagotchi.swift
//  Tamagotchi
//
//  Created by gnksbm on 6/9/24.
//

import Foundation

struct Tamagotchi: Hashable {
    let id: UUID
    let character: TamaCharacter
    private var level: Int
    private var foodCount: Int
    private var waterCount: Int
    
    init(
        id: UUID = UUID(),
        character: TamaCharacter,
        level: Int = 1,
        foodCount: Int = 0,
        waterCount: Int = 0
    ) {
        self.id = id
        self.character = character
        self.level = level
        self.foodCount = foodCount
        self.waterCount = waterCount
    }
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
    static let defaultMember = [
        Tamagotchi(character: .member1),
        Tamagotchi(character: .member2),
        Tamagotchi(character: .member3),
    ]
    fileprivate static let visibleCount = 31
    fileprivate static func makeEmptyMember() -> Self {
        Tamagotchi(character: .makeEmptyCharacter())
    }
}

extension Array where Element == Tamagotchi {
    func addingEmptyMember() -> Self {
        let emptyMemberCount = Element.visibleCount - count
        return self + (0..<emptyMemberCount).map { _ in
            Element.makeEmptyMember()
        }
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

extension Tamagotchi.TamaCharacter {
    static let member1 = Self(
        name: "따끔따끔",
        imageName: "",
        introduceMessage: ""
    )
    static let member2 = Self(
        name: "방실방실",
        imageName: "",
        introduceMessage: ""
    )
    static let member3 = Self(
        name: "반짝반짝",
        imageName: "",
        introduceMessage: ""
    )
    
    static func makeEmptyCharacter() -> Self {
        Self(
            name: "준비중이에요",
            imageName: "",
            introduceMessage: ""
        )
    }
}
