//
//  UserDefaultsWrapper.swift
//  Tamagotchi
//
//  Created by gnksbm on 6/9/24.
//

import Foundation

@propertyWrapper
struct UserDefaultsWrapper<T: Codable> {
    private let key: UserDefaultsKey
    private let defaultValue: T
    
    var wrappedValue: T {
        get {
            guard let data = UserDefaults.standard.data(forKey: key.rawValue)
            else {
                print("저장된 데이터 없음")
                return defaultValue
            }
            do {
                return try JSONDecoder().decode(T.self, from: data)
            } catch {
                print(
                    String(describing: T.self),
                    "디코딩 에러: \(error.localizedDescription)"
                )
                return defaultValue
            }
        }
        set {
            do {
                let data = try JSONEncoder().encode(newValue)
                UserDefaults.standard.set(data, forKey: key.rawValue)
            } catch {
                print(
                    String(describing: T.self),
                    "인코딩 에러: \(error.localizedDescription)"
                )
            }
        }
    }
    
    init(key: UserDefaultsKey, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
}

enum UserDefaultsKey: String {
    case isFirstLaunch
}
