//
//  TamaFeedView.swift
//  Tamagotchi
//
//  Created by gnksbm on 6/20/24.
//

import UIKit

import SnapKit

final class TamaFeedView: UIView {
    private let viewType: ViewType
    private lazy var textField = UITextField().build { builder in
        builder.attributedPlaceholder(
            NSAttributedString(
                string: viewType.typeDescription + "주세용",
                attributes: [
                    .font: UIFont.boldSystemFont(ofSize: 13),
                    .foregroundColor: UIColor.secondaryLabel
                ]
            )
        )
    }
    
    private let textFieldUnderlineView = UIView().build { builder in
        builder.backgroundColor(.tamaForeground)
    }
    
    private lazy var actionButton = UIButton().build { builder in
        builder.layer(\.cornerRadius)(.smallBoxRadius)
            .layer(\.borderWidth)(1)
            .layer(\.borderColor)(UIColor.tamaForeground.cgColor)
            .configuration(.bordered())
            .configuration(\.baseBackgroundColor)(.clear)
            .configuration(\.baseForegroundColor)(.tamaForeground)
            .configuration(\.image)(UIImage(systemName: viewType.imageName))
            .configuration(\.contentInsets)(
                NSDirectionalEdgeInsets(
                    top: 10,
                    leading: 10,
                    bottom: 10,
                    trailing: 10
                )
            )
            .configuration(\.imagePadding)(5)
            .attributedTitle(
                viewType.typeDescription + "먹기",
                attributes: [
                    .font: UIFont.boldSystemFont(ofSize: 15)
                ]
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
        
        actionButton.snp.makeConstraints { make in
            make.centerY.trailing.equalTo(self)
        }
        
        textFieldUnderlineView.snp.makeConstraints { make in
            make.leading.equalTo(self).inset(20)
            make.trailing.equalTo(actionButton.snp.leading).offset(-20)
            make.height.equalTo(1)
            make.top.equalTo(textField.snp.bottom).offset(5)
        }
        
        textField.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.horizontalEdges.equalTo(textFieldUnderlineView).inset(20)
        }
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
