//
//  NavigationActions.swift
//
//  Copyright © 2021 SDOS. All rights reserved.
//

import SwiftUI

public final class NavigationActions: ObservableObject, NavigationControllerActions {
    public weak var navigationController: UINavigationController?
    
    deinit {
        print("[NavigationActions] - deinit")
    }
    
    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    public func push<Destination: NavigableView>(_ destination: Destination, animated: Bool) {
        navigationController?.pushViewController(createViewController(destination), animated: animated)
    }
    
    public func push(_ destination: NavigationViewController<AnyNavigableView>, animated: Bool) {
        navigationController?.pushViewController(injectNavigationAction(destination), animated: animated)
    }
    
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        navigationController?.dismiss(animated: animated, completion: completion)
    }
    
    public func dismissTo(_ identifier: String, animated: Bool, completion: (() -> Void)?) {
        guard let navigationController = navigationController else { return }
        var lastViewController: UIViewController = navigationController
        var doDismiss = false
        while let vc = lastViewController.presentingViewController as? UIHostingController<AnyNavigableView> {
            lastViewController = vc
            if vc.rootView.identifier == identifier {
                doDismiss = true
                break
            }
        }
        if doDismiss {
            lastViewController.dismiss(animated: animated, completion: completion)
        } else {
            if var topController: UIViewController = UIApplication.shared.windows.first?.rootViewController {
                while (topController.presentedViewController != nil) {
                    topController = topController.presentedViewController!
                }
                topController.dismiss(animated: animated, completion: completion)
            } else {
                navigationController.dismiss(animated: animated, completion: completion)
            }
        }
    }
    
    public func dismissAllStack(animated: Bool, completion: (() -> Void)?) {
        guard let navigationController = navigationController else { return }
        var lastViewController: UIViewController = navigationController
        while let vc = lastViewController.presentingViewController {
            lastViewController = vc
        }
        lastViewController.dismiss(animated: animated, completion: completion)
    }
    
    public func pop(animated: Bool) {
        navigationController?.popViewController(animated: animated)
    }
    
    public func popToRoot(animated: Bool) {
        navigationController?.popToRootViewController(animated: animated)
    }
    
    public func popTo(_ identifier: String, animated: Bool) {
        guard let navigationController = navigationController else { return }
        let result = navigationController.viewControllers.compactMap {
            $0 as? UIHostingController<AnyNavigableView>
        }.first {
            $0.rootView.identifier == identifier
        }
        
        if let result = result {
            navigationController.popToViewController(result, animated: animated)
        }
    }
    
    public func setViews<Destination: NavigableView>(_ views:[Destination], animated: Bool) {
        let result = views.map { view -> UIViewController in
            return createViewController(view)
        }
        navigationController?.setViewControllers(result, animated: animated)
    }
    
    public func setViews(_ views:[NavigationViewController<AnyNavigableView>], animated: Bool) {
        let result = views.map { view -> UIViewController in
            return injectNavigationAction(view)
        }
        navigationController?.setViewControllers(result, animated: animated)
    }
    
    public func present<Destination: NavigableView>(_ destination: Destination, presentationStyle: UIModalPresentationStyle?, transitionStyle: UIModalTransitionStyle?,  animated: Bool, completion: (() -> Void)?) {
        let viewController = NavigationViewController(
            rootView: destination.navigationControllerActions(self)
        )
        
        if let presentationStyle = presentationStyle {
            viewController.modalPresentationStyle = presentationStyle
        }
        if let transitionStyle = transitionStyle {
            viewController.modalTransitionStyle = transitionStyle
        }
        
        if var topController: UIViewController = UIApplication.shared.windows.first?.rootViewController {
            while (topController.presentedViewController != nil) {
                topController = topController.presentedViewController!
            }
            topController.present(viewController, animated: animated, completion: completion)
        } else {
            navigationController?.present(viewController, animated: animated, completion: completion)
        }
    }
    
    public func present<Destination: NavigableView>(_ destination: NavigationViewController<Destination>, presentationStyle: UIModalPresentationStyle?, transitionStyle: UIModalTransitionStyle?,  animated: Bool, completion: (() -> Void)?) {
        let viewController = destination
        if let presentationStyle = presentationStyle {
            viewController.modalPresentationStyle = presentationStyle
        }
        if let transitionStyle = transitionStyle {
            viewController.modalTransitionStyle = transitionStyle
        }
        navigationController?.present(viewController, animated: animated, completion: completion)
    }
    
    @MainActor private func createViewController<Destination: NavigableView>(_ view: Destination) -> NavigationViewController<AnyNavigableView> {
        let navigationViewController = NavigationViewController(rootView: view.navigationControllerActions(self))
        return navigationViewController
    }
    
    @MainActor private func injectNavigationAction(_ hostingController: NavigationViewController<AnyNavigableView>) -> NavigationViewController<AnyNavigableView> {
        hostingController.rootView = hostingController.rootView.navigationControllerActions(self)
        return hostingController
    }
}
