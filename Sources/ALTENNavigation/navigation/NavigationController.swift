//
//  NavigationController.swift
//
//  Copyright © 2021 SDOS. All rights reserved.
//

import SwiftUI

public struct NavigationController<Content>: UIViewControllerRepresentable, View where Content: NavigableView {
    public let navigationController = CustomUINavigationController()
    
    @Binding private var binding: NavigationControllerActions?
    private let navigationActions: NavigationActions
    private let content: (NavigationControllerActions) -> Content
    
    public init(_ binding: Binding<NavigationControllerActions?>, content: @escaping (NavigationControllerActions) -> Content) {
        self._binding = binding
        self.navigationActions = NavigationActions(navigationController: navigationController)
        self.content = content
    }
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationController>) -> CustomUINavigationController {
        let view = content(navigationActions)
        navigationController.setViewControllers([UIHostingController(rootView: view.navigationControllerActions(navigationActions).navigableView(view.identifier, style: view.applyNavigationStyle()))], animated: false)
        return navigationController
    }
    
    public func updateUIViewController(_ uiViewController: CustomUINavigationController, context: UIViewControllerRepresentableContext<NavigationController>) { }
}

struct NavigationController_Previews: PreviewProvider {
    @State static var navigationControllerActions: NavigationControllerActions?
    
    static var previews: some View {
        NavigationController($navigationControllerActions) { navigationControllerActions in
            Text("Test").navigableView("identifier", style: nil)
        }
        .edgesIgnoringSafeArea(.all)
    }
}
