//
//  TamaSelectViewController.swift
//  Tamagotchi
//
//  Created by gnksbm on 6/9/24.
//

import UIKit

import SnapKit

class TamaSelectViewController: UIViewController {
    private var dataSource: TamaSelectDataSource!
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: makeLayout()
    ).build { builder in
        builder.backgroundColor(.tamaBackground)
            .action { $0.register(TamaCollectionViewCell.self) }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
        configureDataSource()
        updateSnapshot(items: Tamagotchi.defaultMember)
    }
    
    private func configureUI() {
        navigationItem.title = "다마고치 선택하기"
    }
    
    private func configureLayout() {
        [collectionView].forEach {
            view.addSubview($0)
        }
        
        let safeArea = view.safeAreaLayoutGuide
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
    }
    
    private func updateSnapshot(items: [Tamagotchi]) {
        var snapshot = TamaSelectSnapshot()
        let allSection = TamaSelectSection.allCases
        snapshot.appendSections(allSection)
        allSection.forEach { section in
            switch section {
            case .main:
                snapshot.appendItems(
                    items.addingEmptyMember(),
                    toSection: section
                )
            }
        }
        dataSource.apply(snapshot)
    }
    
    private func makeLayout() -> UICollectionViewCompositionalLayout {
        .init { _, _ in
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1/3),
                    heightDimension: .fractionalHeight(1)
                )
            )
            item.contentInsets = NSDirectionalEdgeInsets(
                top: 10,
                leading: 10,
                bottom: 10,
                trailing: 10
            )
            let hGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalWidth(1/3)
                ),
                subitems: [item]
            )
            let vGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalWidth(1)
                ),
                subitems: [hGroup]
            )
            let section = NSCollectionLayoutSection(group: vGroup)
            return section
        }
    }
    
    private func configureDataSource() {
        let tamaRegistration = makeTamaCellRegistration()
        dataSource = .init(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, item in
                collectionView.dequeueConfiguredReusableCell(
                    using: tamaRegistration,
                    for: indexPath,
                    item: item
                )
            }
        )
    }
    
    private func makeTamaCellRegistration() -> TamaCellRegistration {
        TamaCellRegistration { cell, indexPath, tamagotchi in
            cell.configureCell(item: tamagotchi)
        }
    }
}

extension TamaSelectViewController {
    typealias TamaSelectDataSource =
    UICollectionViewDiffableDataSource<TamaSelectSection, Tamagotchi>
    
    typealias TamaSelectSnapshot =
    NSDiffableDataSourceSnapshot<TamaSelectSection, Tamagotchi>
    
    typealias TamaCellRegistration =
    UICollectionView.CellRegistration<TamaCollectionViewCell, Tamagotchi>
    
    enum TamaSelectSection: CaseIterable {
        case main
    }
}

#if DEBUG
import SwiftUI
struct TamaSelectViewControllerPreview: PreviewProvider {
    static var previews: some View {
        TamaSelectViewController().withNavigationSwiftUIView
    }
}
#endif
