//
//  TamaSelectFlow.swift
//  Tamagotchi
//
//  Created by gnksbm on 6/23/24.
//

import Foundation

enum TamaSelectFlow {
    case start, edit
    
    var title: String {
        switch self {
        case .start:
            "시작하기"
        case .edit:
            "변경하기"
        }
    }
}
