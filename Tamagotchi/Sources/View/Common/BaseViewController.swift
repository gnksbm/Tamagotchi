//
//  BaseViewController.swift
//  Tamagotchi
//
//  Created by gnksbm on 6/20/24.
//

import UIKit

class BaseViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
