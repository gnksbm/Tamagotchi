//
//  MainViewController.swift
//  Tamagotchi
//
//  Created by gnksbm on 6/9/24.
//

import UIKit

final class MainViewController: BaseViewController {
    private let tamagotchi: Tamagotchi
    
    private lazy var bubbleView = TamaBubbleView().build { builder in
        builder.capture { base in
            base.updateMessage(tamagotchi.character.introduceMessage)
        }
    }
    
    private lazy var tamaImageView = UIImageView().build { builder in
        builder.image(UIImage(named: tamagotchi.imageName))
    }
    
    private lazy var tamaNameLabel = TamaNameView().build { builder in
        builder.text("\(tamagotchi.character.name) 다마고치")
    }
    
    private lazy var tamaInfoLabel = UILabel().build { builder in
        builder.textAlignment(.center)
            .textColor(.tamaForeground)
            .font(.tamaSmall.with(weight: .bold))
            .text(tamagotchi.tamaDescription)
    }
    
    private lazy var foodFeedView = TamaFeedView(viewType: .food).build { builder in
        builder
    }
    
    private lazy var waterFeedView = TamaFeedView(viewType: .water).build { builder in
        builder
    }
    
    init(tamagotchi: Tamagotchi) {
        self.tamagotchi = tamagotchi
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureNavigation()
        hideKeyboardOnTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "\(Tamagotchi.captainName)님의 다마고치"
    }
    
    private func configureLayout() {
        [
            bubbleView,
            tamaImageView,
            tamaNameLabel,
            tamaInfoLabel,
            foodFeedView,
            waterFeedView
            
        ].forEach { view.addSubview($0) }
        
        let safeArea = view.safeAreaLayoutGuide
        
        bubbleView.snp.makeConstraints { make in
            make.top.equalTo(safeArea).offset(40)
            make.width.equalTo(safeArea).multipliedBy(0.6)
            make.centerX.equalTo(safeArea)
        }
       
        tamaImageView.snp.makeConstraints { make in
            make.top.equalTo(bubbleView.snp.bottom)
            make.centerX.equalTo(bubbleView)
            make.size.equalTo(safeArea.snp.width).multipliedBy(0.5)
        }
         
        tamaNameLabel.snp.makeConstraints { make in
            make.top.equalTo(tamaImageView.snp.bottom).offset(10)
            make.centerX.equalTo(bubbleView)
            make.width.lessThanOrEqualTo(safeArea).multipliedBy(0.9)
        }
        
        tamaInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(tamaNameLabel.snp.bottom).offset(10)
            make.centerX.equalTo(bubbleView)
            make.width.lessThanOrEqualTo(safeArea).multipliedBy(0.9)
        }
        
        foodFeedView.snp.makeConstraints { make in
            make.top.equalTo(tamaInfoLabel.snp.bottom).offset(30)
            make.centerX.equalTo(bubbleView)
            make.width.equalTo(safeArea).multipliedBy(0.65)
        }
        
        waterFeedView.snp.makeConstraints { make in
            make.top.equalTo(foodFeedView.snp.bottom).offset(20)
            make.centerX.equalTo(bubbleView)
            make.width.equalTo(foodFeedView)
        }
    }
    
    private func configureNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "person.circle"),
            style: .plain,
            target: self,
            action: #selector(profileButtonTapped)
        ).build { builder in
            builder.tintColor(.tamaForeground)
        }
    }
    
    @objc private func profileButtonTapped() {
        
    }
}

#if DEBUG
import SwiftUI
struct MainViewControllerPreview: PreviewProvider {
    static var previews: some View {
        MainViewController(
            tamagotchi: .defaultMember.first!
        ).withNavigationSwiftUIView
    }
}
#endif
