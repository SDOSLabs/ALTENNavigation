//
//  NavigableView.swift
//
//  Copyright © 2022 ALTEN. All rights reserved.
//

import SwiftUI
import UIKit

/// Protocolo para las `View`s de SwiftUI. Les da la capacidad de poder ser incluidas como vistas de navegación y que puedan modificar el aspecto visual de la barra de navegación
public protocol NavigableView: View {
    /// Identificador de navegación
    var navigationIdentifier: String { get }
    /// Permite modificar el aspecto visual de la barra de navegación
    /// - Returns: Closure que contiene el código encargado de modificar el aspecto visual de la barra de navegación
    @MainActor func applyNavigationStyle() -> ((UINavigationController) -> Void)?
}

extension NavigableView {
    @MainActor public func applyNavigationStyle() -> ((UINavigationController) -> Void)? { return nil }
}

/// `View` que permite encapsular cualquier tipo de vista a una vista concreta de tipo `NavigableView`
public struct AnyNavigableView: View, NavigableView {
    public var navigationIdentifier: String
    var view: AnyView
    var style: ((UINavigationController) -> Void)?
    public func applyNavigationStyle() -> ((UINavigationController) -> Void)? { style }
    
    /// Inicializador de `AnyNavigableView`
    /// - Parameters:
    ///   - navigationIdentifier: Identificador de navegación
    ///   - view: `View` a encapsular
    ///   - style: Closure que contiene el código encargado de modificar el aspecto visual de la barra de navegación
    public init<V: View>(_ navigationIdentifier: String, view: V, style: ((UINavigationController) -> Void)?) {
        self.navigationIdentifier = navigationIdentifier
        self.view = AnyView(view)
        self.style = style
    }

    public var body: some View {
        view
    }
}

@MainActor 
extension NavigableView {
    /// Convierte la vista a un tipo concreto `AnyNavigableView`
    /// - Returns: Un `AnyNavigableView` que envuelve `NavigableView`
    public func eraseToAnyNavigableView() -> AnyNavigableView {
        return AnyNavigableView(navigationIdentifier, view: self, style: applyNavigationStyle())
    }
    
    internal func navigationActions(_ value: NavigationActions) -> AnyNavigableView {
        return AnyNavigableView(navigationIdentifier, view: self.environment(\.navigationActions, value), style: applyNavigationStyle())
    }
    
}

extension View {
    /// Convierte la vista a un tipo concreto `AnyNavigableView`
    /// - Parameters:
    ///   - navigationIdentifier: Identificador de navegación
    ///   - navigationActions: Objeto encargado de realizar las acciones de navegación. Se debe extraer del contexto donde se encuentre para pasarlo como parámetro. Si se pasa `nil` la vista no podrá realizar navegaciones
    ///   - style: Closure que contiene el código encargado de modificar el aspecto visual de la barra de navegación
    /// - Returns: Un `AnyNavigableView` que envuelve `View`
    public func navigableView(_ navigationIdentifier: String, navigationActions: NavigationActions? = nil, style: ((UINavigationController) -> Void)? = nil) -> AnyNavigableView {
        if let navigationActions = navigationActions {
            return AnyNavigableView(navigationIdentifier, view: self.environment(\.navigationActions, navigationActions), style: style)
        } else {
            return AnyNavigableView(navigationIdentifier, view: self, style: style)
        }
        
    }
}
