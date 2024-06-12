//
//  UIKitPreviewHelper.swift
//  Tamagotchi
//
//  Created by gnksbm on 6/12/24.
//

import SwiftUI

#if DEBUG
extension UIView {
    var swiftUIView: some View {
        UIViewSwiftUIView(self)
    }
}

extension UIViewController {
    var swiftUIView: some View {
        UIViewControllerSwiftUIView(self)
    }
}

fileprivate struct UIViewControllerSwiftUIView: UIViewControllerRepresentable {
    private let viewController: UIViewController
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        viewController
    }
    
    func updateUIViewController(
        _ uiViewController: UIViewControllerType,
        context: Context
    ) {
    }
}

fileprivate struct UIViewSwiftUIView: UIViewRepresentable {
    private let view: UIView
    
    init(_ view: UIView) {
        self.view = view
    }
    
    func makeUIView(context: Context) -> some UIView {
        view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
#endif
