//
//  SettingTableViewCell.swift
//  Tamagotchi
//
//  Created by gnksbm on 6/23/24.
//

import UIKit

import SnapKit

final class SettingTableViewCell: UITableViewCell {
    private let iconImageView = UIImageView().build { builder in
        builder.contentMode(.scaleAspectFit)
    }
    
    private let titleLabel = UILabel().build { builder in
        builder.font(.tamaMedium.with(weight: .bold))
    }
    
    private let disclosureLabel = UILabel().build { builder in
        builder.font(.tamaSmall)
            .textColor(.secondaryLabel)
    }
    
    private let disclosureIndicatorView = UIImageView().build { builder in
        builder.contentMode(.scaleAspectFit)
            .image(UIImage(systemName: "chevron.right"))
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(item: SettingViewController.TableViewMainItem) {
        iconImageView.image = item.image
        titleLabel.text = item.title
        disclosureLabel.text = item.disclosureText
    }
    
    private func configureUI() {
        backgroundColor = .tamaBackground
        selectionStyle = .none
    }
    
    private func configureLayout() {
        [
            iconImageView,
            titleLabel,
            disclosureLabel,
            disclosureIndicatorView
        ].forEach { contentView.addSubview($0) }
        
        iconImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView).inset(20)
            make.centerY.equalTo(contentView)
            make.size.equalTo(contentView.snp.height).multipliedBy(0.5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(20)
            make.verticalEdges.equalTo(contentView).inset(15)
        }
        
        disclosureLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.trailing).offset(20)
            make.trailing.equalTo(disclosureIndicatorView.snp.leading)
                .offset(-10)
            make.centerY.equalTo(contentView)
        }
        
        disclosureIndicatorView.snp.makeConstraints { make in
            make.trailing.equalTo(contentView).inset(20)
            make.centerY.equalTo(contentView)
            make.size.equalTo(contentView.snp.height).multipliedBy(0.3)
        }
    }
}
