//
//  NavigationControllerActions.swift
//
//  Copyright © 2021 SDOS. All rights reserved.
//

import SwiftUI

public final class NavigationViewController<T: NavigableView>: UIHostingController<T> {
    
//    var observingKeyboard = true
//
//    override func viewDidLoad() {
//        if observingKeyboard {
//            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//        }
//    }
//
//    @objc func keyboardWillShow(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
//            if self.view.frame.origin.y == 0 {
//                self.view.frame.origin.y -= keyboardSize.height
//            }
//        }
//    }
//
//    @objc func keyboardWillHide(notification: NSNotification) {
//        if self.view.frame.origin.y != 0 {
//            self.view.frame.origin.y = 0
//        }
//    }
}

public protocol NavigationControllerActions: AnyObject {
    var navigationController: UINavigationController? { get }
    
    @MainActor func push<Destination: NavigableView>(_ destination: Destination, animated: Bool)
    @MainActor func push(_ destination: NavigationViewController<AnyNavigableView>, animated: Bool)
    
    @MainActor func dismiss(animated: Bool)
    @MainActor func dismiss(animated: Bool, completion: (() -> Void)?)
    
    @MainActor func dismissTo(_ identifier: String, animated: Bool)
    @MainActor func dismissTo(_ identifier: String, animated: Bool, completion: (() -> Void)?)
    
    @MainActor func dismissAllStack(animated: Bool)
    @MainActor func dismissAllStack(animated: Bool, completion: (() -> Void)?)
    
    @MainActor func pop(animated: Bool)
    @MainActor func popToRoot(animated: Bool)
    
    @MainActor func popTo(_ identifier: String, animated: Bool)
    
    @MainActor func setViews<Destination: NavigableView>(_ views:[Destination], animated: Bool)
    @MainActor func setViews(_ views:[NavigationViewController<AnyNavigableView>], animated: Bool)
    
    @MainActor func present<Destination: NavigableView>(_ destination: Destination,  animated: Bool, completion: (() -> Void)?)
    @MainActor func present<Destination: NavigableView>(_ destination: Destination, presentationStyle: UIModalPresentationStyle?,  animated: Bool, completion: (() -> Void)?)
    @MainActor func present<Destination: NavigableView>(_ destination: Destination, transitionStyle: UIModalTransitionStyle?,  animated: Bool, completion: (() -> Void)?)
    @MainActor func present<Destination: NavigableView>(_ destination: Destination, presentationStyle: UIModalPresentationStyle?, transitionStyle: UIModalTransitionStyle?,  animated: Bool, completion: (() -> Void)?)
    
    @MainActor func present<Destination: NavigableView>(_ destination: NavigationViewController<Destination>, animated: Bool, completion: (() -> Void)?)
    @MainActor func present<Destination: NavigableView>(_ destination: NavigationViewController<Destination>, presentationStyle: UIModalPresentationStyle?,  animated: Bool, completion: (() -> Void)?)
    @MainActor func present<Destination: NavigableView>(_ destination: NavigationViewController<Destination>, transitionStyle: UIModalTransitionStyle?,  animated: Bool, completion: (() -> Void)?)
    @MainActor func present<Destination: NavigableView>(_ destination: NavigationViewController<Destination>, presentationStyle: UIModalPresentationStyle?, transitionStyle: UIModalTransitionStyle?,  animated: Bool, completion: (() -> Void)?)
}

extension NavigationControllerActions {
    @MainActor public func dismiss(animated: Bool) {
        dismiss(animated: animated, completion: nil)
    }
    
    @MainActor public func dismissAllStack(animated: Bool) {
        dismissAllStack(animated: animated, completion: nil)
    }
    
    @MainActor public func dismissTo(_ identifier: String, animated: Bool) {
        dismissTo(identifier, animated: animated, completion: nil)
    }
    
    @MainActor public func present<Destination: NavigableView>(_ destination: Destination,  animated: Bool, completion: (() -> Void)? = nil) {
        present(destination, presentationStyle: nil, transitionStyle: nil, animated: animated, completion: completion)
    }
    
    @MainActor public func present<Destination: NavigableView>(_ destination: Destination, presentationStyle: UIModalPresentationStyle?,  animated: Bool, completion: (() -> Void)?) {
        present(destination, presentationStyle: presentationStyle, transitionStyle: nil, animated: animated, completion: completion)
    }
    
    @MainActor public func present<Destination: NavigableView>(_ destination: Destination, transitionStyle: UIModalTransitionStyle?,  animated: Bool, completion: (() -> Void)?) {
        present(destination, presentationStyle: nil, transitionStyle: transitionStyle, animated: animated, completion: completion)
    }
    
    @MainActor public func present<Destination: NavigableView>(_ destination: NavigationViewController<Destination>,  animated: Bool, completion: (() -> Void)?) {
        present(destination, presentationStyle: nil, transitionStyle: nil, animated: animated, completion: completion)
    }
    
    @MainActor public func present<Destination: NavigableView>(_ destination: NavigationViewController<Destination>, presentationStyle: UIModalPresentationStyle?,  animated: Bool, completion: (() -> Void)?) {
        present(destination, presentationStyle: presentationStyle, transitionStyle: nil, animated: animated, completion: completion)
    }
    
    @MainActor public func present<Destination: NavigableView>(_ destination: NavigationViewController<Destination>, transitionStyle: UIModalTransitionStyle?,  animated: Bool, completion: (() -> Void)?) {
        present(destination, presentationStyle: nil, transitionStyle: transitionStyle, animated: animated, completion: completion)
    }
}


public struct NavigationControllerActionsEnvironmentKey: EnvironmentKey {
    public static var defaultValue: NavigationControllerActions? = nil
}

extension EnvironmentValues {
    public var navigationControllerActions: NavigationControllerActions? {
        get { self[NavigationControllerActionsEnvironmentKey.self] }
        set { self[NavigationControllerActionsEnvironmentKey.self] = newValue }
    }
}
