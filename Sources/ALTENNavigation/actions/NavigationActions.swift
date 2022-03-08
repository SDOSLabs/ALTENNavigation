//
//  NavigationActions.swift
//  
//  Copyright © 2022 ALTEN. All rights reserved.
//

import Foundation
import SwiftUI

@MainActor
protocol NavigationActionsInjectable: AnyObject {
    func createViewController<Destination: NavigableView>(_ view: Destination) -> UIHostingController<AnyNavigableView>
    func createPresentViewController<Destination: NavigableView>(_ view: Destination) -> UIHostingController<AnyNavigableView>
    
    func injectNavigationAction(_ hostingController: UIHostingController<AnyNavigableView>) -> UIHostingController<AnyNavigableView>
    func injectPresentAction(_ hostingController: UIHostingController<AnyNavigableView>) -> UIHostingController<AnyNavigableView>
}

/**
 Contiene las funcionalidades de navegación que se pueden realizar. Al usar `ALTENNavigationView` se inyecta como `Environment` una instancia de esta clase que se usará para realizar las acciones de navegación modales o de tipo push
 */
public final class NavigationActions {
    /// Acciones de navegación de tipo push. Existe si se navega a una vista embebida en `ALTENNavigationView`
    public private(set) var pushActions: NavigationPushActions?
    
    /// Acciones de navegación de tipo modal
    public var modalActions: NavigationModalActions {
        let modalAction: NavigationModalActionsImpl
        if let viewController = viewController {
            modalAction = NavigationModalActionsImpl(viewController: viewController)
        } else if let viewController = pushActions?.navigationController?.topViewController {
            modalAction = NavigationModalActionsImpl(viewController: viewController)
        } else {
            modalAction = NavigationModalActionsImpl(viewController: UIApplication.topViewController)
        }
        modalAction.navigationInjectable = self
        return modalAction
    }
    private weak var viewController: UIViewController? = nil
    
    init(pushActions: NavigationPushActionsImpl?) {
        pushActions?.navigationInjectable = self
        self.pushActions = pushActions
    }
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
        self.pushActions = nil
    }
}

extension NavigationActions: NavigationActionsInjectable {
    func createViewController<Destination: NavigableView>(_ view: Destination) -> UIHostingController<AnyNavigableView> {
        let navigationViewController = UIHostingController(rootView: view.navigationActions(self))
        return navigationViewController
    }
    
    func createPresentViewController<Destination: NavigableView>(_ view: Destination) -> UIHostingController<AnyNavigableView> {
        let viewController = UIHostingController(rootView: view.eraseToAnyNavigableView())
        viewController.rootView = viewController.rootView.navigationActions(NavigationActions(viewController: viewController))
        return viewController
    }
    
    func injectNavigationAction(_ hostingController: UIHostingController<AnyNavigableView>) -> UIHostingController<AnyNavigableView> {
        hostingController.rootView = hostingController.rootView.navigationActions(self)
        return hostingController
    }
    
    func injectPresentAction(_ hostingController: UIHostingController<AnyNavigableView>) -> UIHostingController<AnyNavigableView> {
        hostingController.rootView = hostingController.rootView.navigationActions(NavigationActions(viewController: hostingController))
        return hostingController
    }
}


fileprivate extension UIApplication {
    static var topViewController: UIViewController {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return UIViewController()
    }
}
