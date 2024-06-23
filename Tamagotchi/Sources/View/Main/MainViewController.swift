//
//  MainViewController.swift
//  Tamagotchi
//
//  Created by gnksbm on 6/9/24.
//

import UIKit

final class MainViewController: BaseViewController {
    private lazy var bubbleView = TamaBubbleView()
    
    private lazy var tamaImageView = UIImageView()
    
    private lazy var tamaNameView = TamaNameView()
    
    private lazy var tamaInfoLabel = UILabel().build { builder in
        builder.textAlignment(.center)
            .textColor(.tamaForeground)
            .font(.tamaSmall.with(weight: .bold))
    }
    
    private lazy var foodFeedView = TamaFeedView(viewType: .food)
    
    private lazy var waterFeedView = TamaFeedView(viewType: .water)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        configureNavigation()
        hideKeyboardOnTap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateView(item: Tamagotchi.selectedTamagotchi)
        navigationItem.title = "\(Tamagotchi.captainName)님의 다마고치"
    }
    
    private func updateView(item: Tamagotchi) {
        bubbleView.updateMessage(item.character.introduceMessage)
        tamaImageView.image = UIImage(named: item.imageName)
        tamaNameView.text = "\(item.character.name) 다마고치"
        tamaInfoLabel.text = item.tamaDescription
    }
    
    private func configureLayout() {
        [
            bubbleView,
            tamaImageView,
            tamaNameView,
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
         
        tamaNameView.snp.makeConstraints { make in
            make.top.equalTo(tamaImageView.snp.bottom).offset(10)
            make.centerX.equalTo(bubbleView)
            make.width.lessThanOrEqualTo(safeArea).multipliedBy(0.9)
        }
        
        tamaInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(tamaNameView.snp.bottom).offset(10)
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
        navigationController?.pushViewController(
            SettingViewController(),
            animated: true
        )
    }
}

#if DEBUG
import SwiftUI
struct MainViewControllerPreview: PreviewProvider {
    static var previews: some View {
        MainViewController().withNavigationSwiftUIView
    }
}
#endif
