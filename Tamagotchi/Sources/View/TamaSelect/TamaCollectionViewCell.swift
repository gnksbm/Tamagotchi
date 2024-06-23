//
//  TamaCollectionViewCell.swift
//  Tamagotchi
//
//  Created by gnksbm on 6/13/24.
//

import UIKit

import SnapKit

final class TamaCollectionViewCell: UICollectionViewCell {
    private let tamaImageView = UIImageView()
    private let tamaImageOverlayView = UIView().build { builder in
        builder.backgroundColor(.darkGray.withAlphaComponent(0.3))
    }
    
    private let tamaNameView = TamaNameView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        tamaImageOverlayView.layer.cornerRadius = tamaImageOverlayView.bounds.width / 2
    }
    
    func configureCell(item: Tamagotchi) {
        tamaImageOverlayView.isHidden = !item.imageName.isEmpty
        tamaImageView.image = item.imageName.isEmpty ?
            ._1_1 : UIImage(named: item.imageName)
        tamaNameView.text = item.visibleName
    }
    
    private func configureLayout() {
        [tamaImageView, tamaImageOverlayView, tamaNameView].forEach { contentView.addSubview($0) }
        
        tamaImageView.snp.makeConstraints { make in
            make.top.centerX.equalTo(contentView)
            make.width.height.equalTo(contentView.snp.width).multipliedBy(0.9)
            make.width.lessThanOrEqualTo(contentView)
        }
        
        tamaImageOverlayView.snp.makeConstraints { make in
            make.edges.equalTo(tamaImageView)
        }
        
        tamaNameView.snp.makeConstraints { make in
            make.top.equalTo(tamaImageView.snp.bottom).offset(5)
            make.centerX.equalTo(contentView)
        }
    }
}

#if DEBUG
import SwiftUI
struct TamaCollectionViewCellPreview: PreviewProvider {
    static var previews: some View {
        TamaCollectionViewCell().build { builder in
            builder.capture { base in
                base.configureCell(item: Tamagotchi.myTamagotchi.addingEmptyMember().last!)
            }
        }.swiftUIView
        TamaCollectionViewCell().build { builder in
            builder.capture { base in
                base.configureCell(item: Tamagotchi.myTamagotchi.first!)
            }
        }.swiftUIView
    }
}
#endif
