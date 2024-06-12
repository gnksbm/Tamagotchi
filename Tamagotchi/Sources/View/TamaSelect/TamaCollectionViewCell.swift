//
//  TamaCollectionViewCell.swift
//  Tamagotchi
//
//  Created by gnksbm on 6/13/24.
//

import UIKit

final class TamaCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(item: Tamagotchi) {
        
    }
    
    private func configureLayout() {
        
    }
}
