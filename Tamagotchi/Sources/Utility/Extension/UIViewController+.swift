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
}

// MARK: Method Swizzle
extension UIViewController {
    class func defaultUISwizzle() {
        guard let viewDidLoad = class_getInstanceMethod(
            Self.self,
            #selector(Self.viewDidLoad)
        ),
        let configureDefaultUI = class_getInstanceMethod(
            Self.self,
            #selector(Self.configureDefaultUI)
        )
        else { return }
        method_exchangeImplementations(viewDidLoad, configureDefaultUI)
    }
    
    @objc dynamic func configureDefaultUI() {
        view.backgroundColor = .tamaBackground
        view.tintColor = .tamaForeground
        navigationController?.navigationBar.topItem?.title = ""
    }
}
