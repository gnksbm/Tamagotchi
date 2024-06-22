//
//  Appearance.swift
//  Tamagotchi
//
//  Created by gnksbm on 6/22/24.
//

import UIKit

enum Appearance {
    static func configureCommonUI() {
        configureNavigationBarUI()
    }
    
    private static func configureNavigationBarUI() {
        let appearance = UINavigationBarAppearance().build { builder in
            builder.shadowColor(.tertiaryLabel)
                .backgroundColor(.tamaBackground)
                .titleTextAttributes([
                    .foregroundColor: UIColor.tamaForeground
                ])
        }
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}
