//
//  TamaDetailView.swift
//  Tamagotchi
//
//  Created by gnksbm on 6/23/24.
//

import UIKit

import SnapKit

final class TamaDetailView: UIView {
    private let viewMode: ViewMode
    
    var primaryAction: () -> Void = { }
    var cancelAction: () -> Void = { }
    
    private var buttonConfiguration = {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .tamaForeground
        config.contentInsets = .same(inset: 20)
        return config
    }()
    
    private let tamaImageView = UIImageView()
    private let tamaNameView = TamaNameView()
    
    private let dividerView = UIView().build { builder in
        builder.backgroundColor(.tamaForeground)
    }
    
    private let tamaDescriptionLabel = UILabel().build { builder in
        builder.textAlignment(.center)
            .textColor(.tamaForeground)
            .numberOfLines(0)
            .font(.tamaMedium)
    }
    
    private lazy var primaryButton = UIButton().build { builder in
        builder.configuration(buttonConfiguration)
            .attributedTitle(
                viewMode.title,
                attributes: [
                    .font: UIFont.tamaLarge
                ]
            )
            .addTarget(
                self,
                action: #selector(primaryButtonTapped),
                for: .touchUpInside
            )
    }
    
    private lazy var cancelButton = UIButton().build { builder in
        builder.configuration(buttonConfiguration)
            .attributedTitle(
                "취소",
                attributes: [
                    .font: UIFont.tamaLarge
                ]
            )
            .backgroundColor(.secondaryLabel.withAlphaComponent(0.1))
            .addTarget(
                self,
                action: #selector(cancelButtonTapped),
                for: .touchUpInside
            )
    }
    
    private lazy var buttonStackView = UIStackView(
        arrangedSubviews: [cancelButton, primaryButton]
    ).build { builder in
        builder.distribution(.fillEqually)
    }
    
    init(viewMode: ViewMode) {
        self.viewMode = viewMode
        super.init(frame: .zero)
        configureUI()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let stackViewDividerLayer = CALayer()
        stackViewDividerLayer.backgroundColor = UIColor.tertiaryLabel.cgColor
        let height: CGFloat = 1
        stackViewDividerLayer.frame = CGRect(
            x: buttonStackView.bounds.origin.x,
            y: buttonStackView.bounds.origin.y - height,
            width: buttonStackView.bounds.width,
            height: height
        )
        buttonStackView.layer.addSublayer(stackViewDividerLayer)
    }
    
    func updateView(item: Tamagotchi) {
        tamaImageView.image = UIImage(named: item.imageName)
        tamaNameView.text = item.visibleName
        tamaDescriptionLabel.text = item.character.introduceMessage
    }
    
    private func configureUI() {
        backgroundColor = .tamaBackground
        layer.cornerRadius = .regularRadius
    }
    
    private func configureLayout() {
        [
            tamaImageView,
            tamaNameView,
            dividerView,
            tamaDescriptionLabel,
            buttonStackView
        ].forEach {
            addSubview($0)
        }
        
        tamaNameView.snp.makeConstraints { make in
            make.center.equalTo(self)
        }
        
        tamaImageView.snp.makeConstraints { make in
            make.bottom.equalTo(tamaNameView.snp.top).offset(-10)
            make.centerX.equalTo(self)
        }
        
        dividerView.snp.makeConstraints { make in
            make.top.equalTo(tamaNameView.snp.bottom).offset(20)
            make.centerX.equalTo(tamaNameView)
            make.height.equalTo(1)
            make.width.equalTo(self).multipliedBy(0.7)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.width.bottom.equalTo(self)
        }
        
        tamaDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(dividerView.snp.bottom).offset(20)
            make.bottom.equalTo(buttonStackView.snp.top).offset(-20)
            make.width.centerX.equalTo(dividerView)
        }
    }
    
    @objc private func primaryButtonTapped() {
        primaryAction()
    }
    
    @objc private func cancelButtonTapped() { 
        cancelAction()
    }
}

extension TamaDetailView {
    enum ViewMode {
        case start, edit
        
        var title: String {
            switch self {
            case .start:
                "시작하기"
            case .edit:
                "변경하기"
            }
        }
    }
}

#if DEBUG
import SwiftUI
struct TamaDetailViewPreview: PreviewProvider {
    static var previews: some View {
        VStack {
            TamaDetailView(viewMode: .edit).build { builder in
                builder.capture { base in
                    base.updateView(item: .myTamagotchi.first!)
                }
            }.swiftUIView
                .frame(width: 300, height: 400)
        }
    }
}
#endif
