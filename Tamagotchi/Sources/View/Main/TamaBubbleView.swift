//
//  TamaBubbleView.swift
//  Tamagotchi
//
//  Created by gnksbm on 6/22/24.
//

import UIKit

import SnapKit

final class TamaBubbleView: UIImageView {
    var messageWidthConstraint: Constraint!
    var messageHeightConstraint: Constraint!
    
    private let messageLabel = UILabel().build { builder in
        builder.font(.tamaSmall.with(weight: .semibold))
            .textAlignment(.center)
            .textColor(.tamaForeground)
            .numberOfLines(0)
    }
    
    init() {
        super.init(frame: .zero)
        configureUI()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        messageWidthConstraint.update(
            offset: intrinsicContentSize.width * (5 / 6)
        )
        messageHeightConstraint.update(
            offset: intrinsicContentSize.height * (3 / 4)
        )
    }
    
    func updateMessage(_ message: String) {
        messageLabel.text = message
    }
    
    private func configureUI() {
        image = .bubble
        contentMode = .scaleAspectFit
    }
    
    private func configureLayout() {
        [messageLabel].forEach {
            addSubview($0)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self)
            make.centerY.equalTo(self).multipliedBy(0.9)
            messageWidthConstraint = make.width.equalTo(0).constraint
            messageHeightConstraint = make.height.equalTo(0).constraint
        }
    }
}
