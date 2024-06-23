//
//  TamaDetailViewController.swift
//  Tamagotchi
//
//  Created by gnksbm on 6/23/24.
//

import UIKit

import SnapKit

final class TamaDetailViewController: BaseViewController {
    private let flow: TamaSelectFlow
    private let tamagotchi: Tamagotchi
    
    private lazy var tamaDetailView = TamaDetailView(flow: flow).build { builder in
        builder.capture { base in
            base.updateView(item: tamagotchi)
        }
    }
    
    init(
        flow: TamaSelectFlow,
        tamagotchi: Tamagotchi,
        primaryAction: @escaping () -> Void
    ) {
        self.flow = flow
        self.tamagotchi = tamagotchi
        super.init()
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
        tamaDetailView.primaryAction = primaryAction
        tamaDetailView.cancelAction = { [weak self] in
            guard let self else { return }
            dismiss(animated: true)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureLayout()
        dismissOnTap()
    }
    
    private func configureUI() {
        view.backgroundColor = .darkGray.withAlphaComponent(0.7)
    }
    
    private func configureLayout() {
        [tamaDetailView].forEach { view.addSubview($0) }
        
        let safeArea = view.safeAreaLayoutGuide
        
        tamaDetailView.snp.makeConstraints { make in
            make.center.equalTo(safeArea)
            make.width.equalTo(safeArea).multipliedBy(0.8)
            make.height.equalTo(safeArea).multipliedBy(0.65)
        }
    }
    
    private func dismissOnTap() {
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(backgroundTapped)
        )
        view.addGestureRecognizer(tapGesture)
        
        tamaDetailView.addGestureRecognizer(UITapGestureRecognizer())
    }
    
    @objc private func backgroundTapped() {
        dismiss(animated: true)
    }
}

#if DEBUG
import SwiftUI
struct TamaDetailViewControllerPreview: PreviewProvider {
    static var previews: some View {
        TamaDetailViewController(
            flow: .start,
            tamagotchi: .myTamagotchi.first!,
            primaryAction: {
                
            }
        ).swiftUIView
    }
}
#endif
