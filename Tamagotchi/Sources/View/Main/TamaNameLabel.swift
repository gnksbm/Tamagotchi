//
//  TamaNameLabel.swift
//  Tamagotchi
//
//  Created by gnksbm on 6/22/24.
//

import UIKit

import SnapKit

@dynamicMemberLookup
final class TamaNameView: UIView {
    private let nameLabel = UILabel().build { builder in
        builder.textAlignment(.center)
            .textColor(.tamaForeground)
            .font(.tamaMedium.with(weight: .semibold))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    subscript<Value>(
        dynamicMember keyPath: ReferenceWritableKeyPath<UILabel, Value>
    ) -> Value {
        get {
            nameLabel[keyPath: keyPath]
        }
        set {
            nameLabel[keyPath: keyPath] = newValue
        }
    }
    
    private func configureUI() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.tamaForeground.cgColor
        layer.cornerRadius = .smallBoxRadius
    }
    
    private func configureLayout() {
        [nameLabel].forEach { addSubview($0) }
        
        nameLabel.snp.makeConstraints { make in
            make.edges.equalTo(self).inset(10)
        }
    }
}

#if DEBUG
import SwiftUI
struct TamaNameViewPreview: PreviewProvider {
    static var previews: some View {
        TamaNameView().build { builder in
            builder.text("테스트 다마고치")
        }.swiftUIView
    }
}
#endif
