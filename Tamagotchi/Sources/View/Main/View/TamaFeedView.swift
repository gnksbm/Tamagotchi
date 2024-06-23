//
//  TamaFeedView.swift
//  Tamagotchi
//
//  Created by gnksbm on 6/20/24.
//

import UIKit

import SnapKit

final class TamaFeedView: UIView {
    var buttonAction: (String?) -> Void = { _ in }
    private let viewType: ViewType
    
    private lazy var textField = UITextField().build { builder in
        builder.textAlignment(.center)
            .attributedPlaceholder(
            NSAttributedString(
                string: viewType.typeDescription + "주세용",
                attributes: [
                    .font: UIFont.tamaSmall.with(weight: .bold),
                    .foregroundColor: UIColor.tertiaryLabel
                ]
            )
        )
    }
    
    private let textFieldUnderlineView = UIView().build { builder in
        builder.backgroundColor(.tamaForeground)
    }
    
    private lazy var actionButton = UIButton().build { builder in
        builder.layer(\.cornerRadius)(.regularRadius)
            .layer(\.borderWidth)(1)
            .layer(\.borderColor)(UIColor.tamaForeground.cgColor)
            .configuration(.bordered())
            .configuration(\.baseBackgroundColor)(.clear)
            .configuration(\.baseForegroundColor)(.tamaForeground)
            .configuration(\.image)(UIImage(systemName: viewType.imageName))
            .configuration(\.contentInsets)(.same(inset: 8))
            .configuration(\.titlePadding)(0)
            .configuration(\.imagePadding)(5)
            .attributedTitle(
                viewType.typeDescription + "먹기",
                attributes: [
                    .font: UIFont.tamaMedium.with(weight: .bold)
                ]
            )
            .setContentHuggingPriority(
                .required,
                for: .horizontal
            )
            .addTarget(
                self,
                action: #selector(
                    actionButtonTapped
                ),
                for: .touchUpInside
            )
    }
    
    init(viewType: ViewType) {
        self.viewType = viewType
        super.init(frame: .zero)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureLayout() {
        [
            textField,
            textFieldUnderlineView,
            actionButton
        ].forEach { addSubview($0) }
        
        textFieldUnderlineView.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(5)
            make.leading.equalTo(self).inset(10)
            make.height.equalTo(1)
        }
        
        textField.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.horizontalEdges.equalTo(textFieldUnderlineView).inset(20)
        }
        
        actionButton.snp.makeConstraints { make in
            make.verticalEdges.centerY.trailing.equalTo(self)
            make.leading.equalTo(textFieldUnderlineView.snp.trailing).offset(10)
        }
    }
    
    @objc private func actionButtonTapped() {
        buttonAction(textField.text)
    }
}

extension TamaFeedView {
    enum ViewType {
        case food, water
        
        var typeDescription: String {
            switch self {
            case .food:
                "밥"
            case .water:
                "물"
            }
        }
        
        var imageName: String {
            switch self {
            case .food:
                "drop.circle"
            case .water:
                "leaf.circle"
            }
        }
    }
}

#if DEBUG
import SwiftUI
struct TamaFeedViewPreview: PreviewProvider {
    static var previews: some View {
        TamaFeedView(viewType: .food).swiftUIView
            .frame(width: 300, height: 100, alignment: .center)
    }
}
#endif
