//
//  MainViewController.swift
//  Tamagotchi
//
//  Created by gnksbm on 6/9/24.
//

import UIKit

final class MainViewController: BaseViewController {
    private let bubbleImageView = UIImageView()
    private let tamaImageView = UIImageView()
    private let tamaNameLabel = UIImageView()
    private let tamaInfoLabel = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureNavigation()
    }
    
    private func configureLayout() {
        [
            bubbleImageView,
            tamaImageView,
            tamaNameLabel,
            tamaInfoLabel
        ].forEach { view.addSubview($0) }
        
        let safeArea = view.safeAreaLayoutGuide
    }
    
    private func configureNavigation() {
        
    }
}
