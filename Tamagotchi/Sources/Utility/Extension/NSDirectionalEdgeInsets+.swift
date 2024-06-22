//
//  NSDirectionalEdgeInsets+.swift
//  Tamagotchi
//
//  Created by gnksbm on 6/22/24.
//

import UIKit

extension NSDirectionalEdgeInsets {
    static func same(inset: CGFloat) -> Self {
        NSDirectionalEdgeInsets(
            top: inset,
            leading: inset,
            bottom: inset,
            trailing: inset
        )
    }
}
