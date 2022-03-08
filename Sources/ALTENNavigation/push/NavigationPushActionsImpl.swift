//
//  NavigationPushActionsImpl.swift
//
//  Copyright © 2022 ALTEN. All rights reserved.
//

import SwiftUI

public final class NavigationPushActionsImpl: NavigationPushActions {
    public private(set) weak var navigationController: ALTENUINavigationController?
    internal weak var navigationInjectable: NavigationActionsInjectable!
    
    init(navigationController: ALTENUINavigationController) {
        self.navigationController = navigationController
    }
    
    public func push<Destination: NavigableView>(_ destination: Destination, animated: Bool) {
        navigationController?.pushViewController(navigationInjectable.createViewController(destination), animated: animated)
    }
    
    public func push(_ destination: UIHostingController<AnyNavigableView>, animated: Bool) {
        navigationController?.pushViewController(navigationInjectable.injectNavigationAction(destination), animated: animated)
    }
    
    public func pop(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }
    
    public func popToRoot(animated: Bool) {
        navigationController?.popToRootViewController(animated: animated)
    }
    
    public func popTo(_ navigationIdentifier: String, animated: Bool) {
        guard let navigationController = navigationController else { return }
        let result = navigationController.viewControllers.reversed().compactMap {
            $0 as? UIHostingController<AnyNavigableView>
        }.first {
            $0.rootView.navigationIdentifier == navigationIdentifier
        }
        
        if let result = result {
            navigationController.popToViewController(result, animated: animated)
        }
    }
    
    public func setViews<Destination: NavigableView>(_ views:[Destination], animated: Bool) {
        let result = views.map { view -> UIViewController in
            return navigationInjectable.createViewController(view)
        }
        navigationController?.setViewControllers(result, animated: animated)
    }
    
    public func setViews(_ views:[UIHostingController<AnyNavigableView>], animated: Bool) {
        let result = views.map { view -> UIViewController in
            return navigationInjectable.injectNavigationAction(view)
        }
        navigationController?.setViewControllers(result, animated: animated)
    }
}
