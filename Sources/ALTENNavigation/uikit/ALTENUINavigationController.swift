//
//  ALTENUINavigationController.swift
//
//  Copyright © 2022 ALTEN. All rights reserved.
//

import UIKit
import SwiftUI

@objc public protocol ALTENUINavigationControllerDelegate {
    @objc optional func navigationController(_ navigationController: ALTENUINavigationController, willShow viewController: UIViewController, animated: Bool)

    @objc optional func navigationController(_ navigationController: ALTENUINavigationController, didShow viewController: UIViewController, animated: Bool)

    @objc optional func navigationControllerSupportedInterfaceOrientations(_ navigationController: ALTENUINavigationController) -> UIInterfaceOrientationMask

    @objc optional func navigationControllerPreferredInterfaceOrientationForPresentation(_ navigationController: ALTENUINavigationController) -> UIInterfaceOrientation

    @objc optional func navigationController(_ navigationController: ALTENUINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning?

    @objc optional func navigationController(_ navigationController: ALTENUINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?
}

/// Componente de navegación usado en UIKit. No usar el `delegate` de `UINavigationController`. En su lugar usar `navigationDelegate`
public final class ALTENUINavigationController: UINavigationController, UINavigationControllerDelegate {
    
    /// Identificador de navegación
    public let identifier: String
    /// Delegado personalizado que actua como puente para el `delegate` de `UINavigationController`
    public weak var navigationDelegate: ALTENUINavigationControllerDelegate?
    
    public init(identifier: String) {
        self.identifier = identifier
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if let hostingController = viewController as? UIHostingController<AnyNavigableView>,
           let style = hostingController.rootView.applyNavigationStyle() {
                style(self)
        }
        navigationDelegate?.navigationController?(self, willShow: viewController, animated: animated)
    }

    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        navigationDelegate?.navigationController?(self, didShow: viewController, animated: animated)
    }

    
    public func navigationControllerSupportedInterfaceOrientations(_ navigationController: UINavigationController) -> UIInterfaceOrientationMask {
        if let orientation = navigationDelegate?.navigationControllerSupportedInterfaceOrientations?(self) {
            return orientation
        } else {
            return self.visibleViewController?.supportedInterfaceOrientations ?? .all
        }
    }

    public func navigationControllerPreferredInterfaceOrientationForPresentation(_ navigationController: UINavigationController) -> UIInterfaceOrientation {
        if let orientation = navigationDelegate?.navigationControllerPreferredInterfaceOrientationForPresentation?(self) {
            return orientation
        } else {
            return self.visibleViewController?.preferredInterfaceOrientationForPresentation ?? .portrait
        }
    }

    
    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        navigationDelegate?.navigationController?(self, interactionControllerFor: animationController)
    }

    
    public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        navigationDelegate?.navigationController?(self, animationControllerFor: operation, from: fromVC, to: toVC)
    }

}
