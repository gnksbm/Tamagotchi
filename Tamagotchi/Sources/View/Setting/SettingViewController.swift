//
//  SettingViewController.swift
//  Tamagotchi
//
//  Created by gnksbm on 6/9/24.
//

import UIKit

import SnapKit

final class SettingViewController: BaseViewController { 
    private lazy var tableView = UITableView().build { builder in
        builder.dataSource(self)
            .delegate(self)
            .capture { base in
                base.register(SettingTableViewCell.self)
            }
            .backgroundColor(.tamaBackground)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        [tableView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let safeArea = view.safeAreaLayoutGuide
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(safeArea)
        }
    }
    
    private func showResetAlert() {
        let alertController = UIAlertController(
            title: "데이터 초기화",
            message: "정말 다시 처음부터 시작하실 건가용?",
            preferredStyle: .alert
        ).build { builder in
            builder.capture { base in
                let cancelAction = UIAlertAction(title: "아냐!", style: .cancel)
                let okAction = UIAlertAction(
                    title: "웅",
                    style: .destructive
                ) { _ in
                    Tamagotchi.resetSavedData()
                }
                base.addAction(cancelAction)
                base.addAction(okAction)
            }
        }
        present(alertController, animated: true)
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        switch TableViewSection.allCases[indexPath.section] {
        case .main:
            TableViewMainItem.allCases[indexPath.row].action(vc: self)
        }
    }
}

extension SettingViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        TableViewSection.allCases.count
    }
    
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        switch TableViewSection.allCases[section] {
        case .main:
            TableViewMainItem.allCases.count
        }
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        switch TableViewSection.allCases[indexPath.section] {
        case .main:
            tableView.dequeueReusableCell(
                cellType: SettingTableViewCell.self,
                for: indexPath
            ).build { builder in
                builder.capture { base in
                    base.configureCell(
                        item: TableViewMainItem.allCases[indexPath.row]
                    )
                }
            }
        }
    }
}

extension SettingViewController {
    enum TableViewSection: CaseIterable {
        case main
    }

    enum TableViewMainItem: CaseIterable {
        case name, change, reset
        
        var image: UIImage? {
            switch self {
            case .name:
                UIImage(systemName: "pencil")
            case .change:
                UIImage(systemName: "moon.fill")
            case .reset:
                UIImage(systemName: "arrow.clockwise")
            }
        }
        
        var title: String {
            switch self {
            case .name:
                "내 이름 설정하기"
            case .change:
                "다마고치 변경하기"
            case .reset:
                "데이터 초기화"
            }
        }
        
        var disclosureText: String? {
            switch self {
            case .name:
                Tamagotchi.captainName
            case .change, .reset:
                nil
            }
        }
        
        func action(vc: UIViewController) {
            switch self {
            case .name:
                vc.navigationController?.pushViewController(
                    EditNameViewController(),
                    animated: true
                )
            case .change:
                vc.navigationController?.pushViewController(
                    TamaSelectViewController(flow: .edit),
                    animated: true
                )
            case .reset:
                let alertController = UIAlertController(
                    title: "데이터 초기화",
                    message: "정말 다시 처음부터 시작하실 건가용?",
                    preferredStyle: .alert
                ).build { builder in
                    builder.capture { base in
                        let cancelAction = UIAlertAction(
                            title: "아냐!",
                            style: .cancel
                        )
                        let okAction = UIAlertAction(
                            title: "웅",
                            style: .destructive
                        ) { _ in
                            Tamagotchi.resetSavedData()
                            vc.view.window?.rootViewController = .makeRootVC()
                        }
                        base.addAction(cancelAction)
                        base.addAction(okAction)
                    }
                }
                vc.present(alertController, animated: true)
            }
        }
    }
}
