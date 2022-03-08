//
//  ALTENNavigationView.swift
//
//  Copyright © 2022 ALTEN. All rights reserved.
//

import SwiftUI

public struct ALTENNavigationView<Content: NavigableView>: UIViewControllerRepresentable {
    private let navigationController: ALTENUINavigationController
    private let navigationActions: NavigationActions
    private let content: (NavigationActions) -> Content
    
    /// Crea una nueva instancia de `ALTENNavigationView`
    /// - Parameters:
    ///   - identifier: Identificador de navegación
    ///   - content: Vista que se mostrará como primera pantalla de la navegación
    public init(identifier: String, content: @escaping (NavigationActions) -> Content) {
        self.navigationController = ALTENUINavigationController(identifier: identifier)
        self.content = content
        let navigationPushActions = NavigationPushActionsImpl(navigationController: navigationController)
        self.navigationActions = NavigationActions(pushActions: navigationPushActions)
    }
    
    public func makeUIViewController(context: UIViewControllerRepresentableContext<ALTENNavigationView>) -> ALTENUINavigationController {
        let view = content(navigationActions)
        navigationController.setViewControllers([UIHostingController(rootView: view.navigationActions(navigationActions).navigableView(view.navigationIdentifier, style: view.applyNavigationStyle()))], animated: false)
        return navigationController
    }
    
    public func updateUIViewController(_ uiViewController: ALTENUINavigationController, context: UIViewControllerRepresentableContext<ALTENNavigationView>) { }
}

extension ALTENNavigationView: NavigableView {
    public var navigationIdentifier: String { navigationController.identifier }
}

struct NavigationController_Previews: PreviewProvider {
    static var previews: some View {
        ALTENNavigationView(identifier: "identifier") { navigationControllerPushActions in
            Text("Test").navigableView("test_identifier", style: nil)
        }
        .edgesIgnoringSafeArea(.all)
    }
}
