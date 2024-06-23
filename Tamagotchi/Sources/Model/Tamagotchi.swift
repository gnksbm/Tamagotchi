//
//  Tamagotchi.swift
//  Tamagotchi
//
//  Created by gnksbm on 6/9/24.
//

import Foundation

struct Tamagotchi: Hashable, Codable {
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
    static var selectedTamagotchi: Self {
        myTamagotchi[selectedTamaIndex]
    }
    
    @UserDefaultsWrapper(key: .selectedTamaIndex, defaultValue: 0)
    static var selectedTamaIndex
    
    @UserDefaultsWrapper(key: .captainName, defaultValue: "대장")
    static var captainName
    
    @UserDefaultsWrapper(
        key: .myTamagotchi,
        defaultValue: Tamagotchi.defaultMember
    )
    static var myTamagotchi
    
    var visibleName: String {
        character.name.isEmpty ?
        "준비중이에요" : "\(character.name) 다마고치"
    }
    
    var imageName: String {
        character.imageIndex.isEmpty ?
        "" : "\(character.imageIndex)-\(level)"
    }
    
    var tamaDescription: String {
        [visibleLevel, visibleFood, visibleWater].joined(separator: " · ")
    }
    
    private var visibleLevel: String {
        "LV\(level)"
    }
    
    private var visibleFood: String {
        "밥알 \(foodCount)개"
    }
    
    private var visibleWater: String {
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
    private static let defaultMember = [
        Tamagotchi(character: .member1),
        Tamagotchi(character: .member2),
        Tamagotchi(character: .member3),
    ]
    
    fileprivate static let visibleCount = 30
    
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
    struct TamaCharacter: Hashable, Codable {
        let name: String
        let imageIndex: String
        let introduceMessage: String
    }
    
    enum FeedingType {
        case food, water
    }
}

extension Tamagotchi.TamaCharacter {
    static let member1 = Self(
        name: "따끔따끔",
        imageIndex: "1",
        introduceMessage: "너무 더워요 물마시고 싶어요"
    )
    static let member2 = Self(
        name: "방실방실",
        imageIndex: "2",
        introduceMessage: "배고파요....."
    )
    static let member3 = Self(
        name: "반짝반짝",
        imageIndex: "3",
        introduceMessage: "Zzz..."
    )
    
    static func makeEmptyCharacter() -> Self {
        Self(
            name: "",
            imageIndex: "",
            introduceMessage: ""
        )
    }
}
