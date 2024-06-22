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
    
    static func makeRootVC(debuggingVC: UIViewController) -> UIViewController {
        #if DEBUG
        debuggingVC
        #else
        isFirstLaunch ? TamaSelectViewController() : MainViewController()
        #endif
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
