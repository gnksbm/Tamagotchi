//
//  EditNameViewController.swift
//  Tamagotchi
//
//  Created by gnksbm on 6/9/24.
//

import UIKit

import SnapKit

final class EditNameViewController: BaseViewController { 
    private let textField = UITextField().build { builder in
        builder.text(Tamagotchi.captainName)
            .textColor(.tamaForeground)
            .font(.tamaSmall.with(weight: .bold))
    }
    
    private let textFieldUnderlineView = UIView().build { builder in
        builder.backgroundColor(.label)
    }
    
    private lazy var saveButton = UIButton().build { builder in
        builder.attributedTitle(
            "저장",
            attributes: [
                .font: UIFont.tamaLarge.with(weight: .medium),
                .foregroundColor: UIColor.tamaForeground
            ]
        )
        .addTarget(
            self,
            action: #selector(saveButtonTapped),
            for: .touchUpInside
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigation()
        configureLayout()
    }
    
    private func configureNavigation() {
        navigationItem.title = "대장님 이름 정하기"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            customView: saveButton
        )
    }
    
    private func configureLayout() {
        [textField, textFieldUnderlineView].forEach { view.addSubview($0) }
        
        let safeArea = view.safeAreaLayoutGuide
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(safeArea).inset(30)
            make.centerX.equalTo(safeArea)
            make.width.equalTo(safeArea).multipliedBy(0.85)
        }
        
        textFieldUnderlineView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(10)
            make.centerX.equalTo(safeArea)
            make.width.equalTo(textField)
            make.height.equalTo(1)
        }
    }
    
    @objc private func saveButtonTapped() {
        guard let newName = textField.text else { return }
        Tamagotchi.captainName = newName
    }
}
