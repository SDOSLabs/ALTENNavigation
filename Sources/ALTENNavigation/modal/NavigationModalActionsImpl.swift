//
//  NavigationModalActionsImpl.swift
//  
//  Copyright © 2022 ALTEN. All rights reserved.
//

import SwiftUI

public final class NavigationModalActionsImpl: NavigationModalActions {
    public private(set) weak var viewController: UIViewController?
    internal weak var navigationInjectable: NavigationActionsInjectable!
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    public func dismiss(animated: Bool, completion: (() -> Void)?) {
        viewController?.dismiss(animated: animated, completion: completion)
    }
    
    public func dismissTo(_ navigationIdentifier: String, animated: Bool, completion: ((Bool) -> Void)?) {
        guard let viewController = viewController else { return }
        var lastViewController: UIViewController = viewController
        var doDismiss = false
        while let vc = lastViewController.presentingViewController {
            if lastViewController == vc {
                break
            }
            lastViewController = vc
            if let vc = vc as? UIHostingController<AnyNavigableView> {
                if vc.rootView.navigationIdentifier == navigationIdentifier {
                    doDismiss = true
                    break
                }
            } else if let vc = vc as? ALTENUINavigationController {
                if vc.identifier == navigationIdentifier {
                    doDismiss = true
                    break
                }
            }
        }
        
        if doDismiss {
            lastViewController.dismiss(animated: animated) {
                completion?(true)
            }
        } else {
            completion?(false)
        }
//        if doDismiss {
//            lastViewController.dismiss(animated: animated, completion: completion)
//        } else {
//            if var topController: UIViewController = UIApplication.shared.windows.first?.rootViewController {
//                while (topController.presentedViewController != nil) {
//                    topController = topController.presentedViewController!
//                }
//                topController.dismiss(animated: animated, completion: completion)
//            } else {
//                navigationController.dismiss(animated: animated, completion: completion)
//            }
//        }
    }
    
    public func dismissAllStack(animated: Bool, completion: (() -> Void)?) {
        guard let viewController = viewController else { return }
        var lastViewController: UIViewController = viewController
        while let vc = lastViewController.presentingViewController {
            if lastViewController == vc {
                break
            }
            lastViewController = vc
        }
        lastViewController.dismiss(animated: animated, completion: completion)
    }
    
    public func present<Destination: NavigableView>(_ destination: Destination, presentationStyle: UIModalPresentationStyle?, transitionStyle: UIModalTransitionStyle?,  animated: Bool, completion: (() -> Void)?) {
        let viewController = navigationInjectable.createPresentViewController(destination)
        
        if let presentationStyle = presentationStyle {
            viewController.modalPresentationStyle = presentationStyle
        }
        if let transitionStyle = transitionStyle {
            viewController.modalTransitionStyle = transitionStyle
        }
        
        self.viewController?.present(viewController, animated: animated, completion: completion)
//        if var topController: UIViewController = UIApplication.shared.windows.first?.rootViewController {
//            while (topController.presentedViewController != nil) {
//                topController = topController.presentedViewController!
//            }
//            topController.present(viewController, animated: animated, completion: completion)
//        } else {
//            navigationController?.present(viewController, animated: animated, completion: completion)
//        }
    }
    
    public func present(_ destination: UIHostingController<AnyNavigableView>, presentationStyle: UIModalPresentationStyle?, transitionStyle: UIModalTransitionStyle?,  animated: Bool, completion: (() -> Void)?) {
        let viewController = navigationInjectable.injectPresentAction(destination)
        if let presentationStyle = presentationStyle {
            viewController.modalPresentationStyle = presentationStyle
        }
        if let transitionStyle = transitionStyle {
            viewController.modalTransitionStyle = transitionStyle
        }
        self.viewController?.present(viewController, animated: animated, completion: completion)
    }
}
