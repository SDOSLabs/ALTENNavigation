//
//  NavigableView.swift
//
//  Copyright © 2021 SDOS. All rights reserved.
//

import SwiftUI
import UIKit

public protocol NavigableView: View {
    var identifier: String { get }
    @MainActor func applyNavigationStyle() -> ((UINavigationController) -> Void)?
}

extension NavigableView {
    @MainActor public func applyNavigationStyle() -> ((UINavigationController) -> Void)? { return nil }
}

public struct AnyNavigableView: View, NavigableView {
    public var identifier: String
    var view: AnyView
    var style: ((UINavigationController) -> Void)?
    public func applyNavigationStyle() -> ((UINavigationController) -> Void)? { style }

    init<V>(_ identifier: String, view: V, style: ((UINavigationController) -> Void)?) where V : View {
        self.identifier = identifier
        self.view = AnyView(view)
        self.style = style
    }

    public var body: some View {
        view
    }
}

@MainActor 
extension NavigableView {
    public func eraseToAnyNavigableView() -> AnyNavigableView {
        return AnyNavigableView(identifier, view: self, style: applyNavigationStyle())
    }
    
    public func navigationControllerActions(_ value: NavigationControllerActions) -> AnyNavigableView {
        return AnyNavigableView(identifier, view: self.environment(\.navigationControllerActions, value), style: applyNavigationStyle())
    }
    
}

extension View {
    public func navigableView(_ identifier: String, style: ((UINavigationController) -> Void)? = nil) -> AnyNavigableView {
        return AnyNavigableView(identifier, view: self, style: style)
    }
}
