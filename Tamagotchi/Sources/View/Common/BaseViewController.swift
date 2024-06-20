//
//  BaseViewController.swift
//  Tamagotchi
//
//  Created by gnksbm on 6/20/24.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureDefaultUI()
    }
    
    private func configureDefaultUI() {
        view.backgroundColor = .tamaBackground
        view.tintColor = .tamaForeground
        navigationController?.navigationBar.topItem?.title = ""
    }
}
