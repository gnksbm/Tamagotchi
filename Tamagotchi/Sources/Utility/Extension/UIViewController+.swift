//
//  UIViewController+.swift
//  Tamagotchi
//
//  Created by gnksbm on 6/9/24.
//

import UIKit

extension UIViewController {
    @UserDefaultsWrapper(key: .isFirstLaunch, defaultValue: true)
    static var isFirstLaunch: Bool
    
    static func makeRootVC() -> UIViewController {
        let viewController = isFirstLaunch ?
        TamaSelectViewController() : MainViewController(
            tamagotchi: .selectedTamagotchi
        )
        return UINavigationController(rootViewController: viewController)
    }
    
    func hideKeyboardOnTap() {
        let gesture = UITapGestureRecognizer(
            target: self,
            action: #selector(hideKeyboard)
        )
        view.addGestureRecognizer(gesture)
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
}
