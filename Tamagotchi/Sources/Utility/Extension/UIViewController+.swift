//
//  UIViewController+.swift
//  Tamagotchi
//
//  Created by gnksbm on 6/9/24.
//

import UIKit

extension UIViewController {
    @UserDefaultsWrapper(key: .isFirstLaunch, defaultValue: false)
    static var isFirstLaunch: Bool
    
    static func makeRootVC() -> UIViewController {
        isFirstLaunch ? TamaSelectViewController() : MainViewController()
    }
}
