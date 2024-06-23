//
//  TamaSelectViewController.swift
//  Tamagotchi
//
//  Created by gnksbm on 6/9/24.
//

import UIKit

import SnapKit

class TamaSelectViewController: BaseViewController {
    private var dataSource: TamaSelectDataSource!
    
    private lazy var collectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: makeLayout()
    ).build { builder in
        builder.backgroundColor(.tamaBackground)
            .delegate(self)
            .capture { $0.register(TamaCollectionViewCell.self) }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
        configureDataSource()
        updateSnapshot(items: Tamagotchi.myTamagotchi)
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
}

extension TamaSelectViewController {
    private func updateSnapshot(items: [Tamagotchi]) {
        var snapshot = TamaSelectSnapshot()
        let allSection = CollectionViewSection.allCases
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
            item.contentInsets = .same(inset: 15)
            let hGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalWidth(1/3 * 1.2)
                ),
                subitems: [item]
            )
            let vGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalWidth(1.2)
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
    
    typealias TamaSelectDataSource =
    UICollectionViewDiffableDataSource<CollectionViewSection, Tamagotchi>
    
    typealias TamaSelectSnapshot =
    NSDiffableDataSourceSnapshot<CollectionViewSection, Tamagotchi>
    
    typealias TamaCellRegistration =
    UICollectionView.CellRegistration<TamaCollectionViewCell, Tamagotchi>
    
    enum CollectionViewSection: CaseIterable {
        case main
    }
}

extension TamaSelectViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let tamagotchi = dataSource
            .snapshot(for: CollectionViewSection.allCases[indexPath.section])
            .items[indexPath.row]
        guard !tamagotchi.character.name.isEmpty else { return }
        present(
            TamaDetailViewController(
                viewMode: .start,
                tamagotchi: tamagotchi,
                primaryAction: { [weak self] in
                    guard let self else { return }
                    Tamagotchi.selectedTamaIndex = indexPath.row
                    UIViewController.isFirstLaunch = false
                    view.window?.rootViewController = .makeRootVC()
                }
            ),
            animated: true
        )
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
