//
//  NavigationModalActions.swift
//  
//  Copyright © 2022 ALTEN. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

public protocol NavigationModalActions: AnyObject {
    var viewController: UIViewController? { get }
    
    //MARK: - Dismiss
    
    /// Oculta modalmente el stack actual
    /// - Parameters:
    ///   - animated: indica si la acción debe ser animada
    @MainActor func dismiss(animated: Bool)
    
    /// Oculta modalmente el stack actual
    /// - Parameters:
    ///   - animated: indica si la acción debe ser animada
    ///   - completion: bloque que se ejecuta cuando termina el proceso
    @MainActor func dismiss(animated: Bool, completion: (() -> Void)?)
    
    /// Oculta modalmente todos los stacks de vistas que hayan sido presentados hasta encontrar el stack con el identificador indicado. La busqueda la realiza desde el stack actual hacía arriba en la jerarquía. Si no encuentra ningúna vista con el identificador indicado en las vistas presentadas no hará nada
    /// - Parameters:
    ///   - identifier: identificador del vista hasta la que debe ocultar
    ///   - animated: indica si la acción debe ser animada
    @MainActor func dismissTo(_ identifier: String, animated: Bool)
    
    /// Oculta modalmente todos los stacks de vistas que hayan sido presentados hasta encontrar el stack con el identificador indicado. La busqueda la realiza desde el stack actual hacía arriba en la jerarquía. Si no encuentra ningúna vista con el identificador indicado en las vistas presentadas no hará nada
    /// - Parameters:
    ///   - identifier: identificador del vista hasta la que debe ocultar
    ///   - animated: indica si la acción debe ser animada
    ///   - completion: bloque que se ejecuta cuando termina el proceso
    @MainActor func dismissTo(_ identifier: String, animated: Bool, completion: ((Bool) -> Void)?)
    
    /// Oculta modalmente todos los stacks de vistas presentados hasta el primero
    /// - Parameters: 
    ///   - animated: indica si la acción debe ser animada
    @MainActor func dismissAllStack(animated: Bool)
    
    /// Oculta modalmente todos los stacks de vistas presentados hasta el primero
    /// - Parameters:
    ///   - animated: indica si la acción debe ser animada
    ///   - completion: bloque que se ejecuta cuando termina el proceso
    @MainActor func dismissAllStack(animated: Bool, completion: (() -> Void)?)
    
    
    //MARK: - Present View
    
    /// Muestra la vista modalmente
    /// - Parameters:
    ///   - destination: vista de destino que se debe presentar
    ///   - animated: indica si la acción debe ser animada
    @MainActor func present<Destination: NavigableView>(_ destination: Destination, animated: Bool)
    
    /// Muestra la vista modalmente
    /// - Parameters:
    ///   - destination: vista de destino que se debe presentar
    ///   - animated: indica si la acción debe ser animada
    ///   - completion: bloque que se ejecuta cuando termina el proceso
    @MainActor func present<Destination: NavigableView>(_ destination: Destination, animated: Bool, completion: (() -> Void)?)
    
    /// Muestra la vista modalmente
    /// - Parameters:
    ///   - destination: vista de destino que se debe presentar
    ///   - presentationStyle: indica el modo de presentación que se debe aplicar a la animación
    ///   - animated: indica si la acción debe ser animada
    @MainActor func present<Destination: NavigableView>(_ destination: Destination, presentationStyle: UIModalPresentationStyle?,  animated: Bool)
    
    /// Muestra la vista modalmente
    /// - Parameters:
    ///   - destination: vista de destino que se debe presentar
    ///   - presentationStyle: indica el modo de presentación que se debe aplicar a la animación
    ///   - animated: indica si la acción debe ser animada
    ///   - completion: bloque que se ejecuta cuando termina el proceso
    @MainActor func present<Destination: NavigableView>(_ destination: Destination, presentationStyle: UIModalPresentationStyle?,  animated: Bool, completion: (() -> Void)?)
    
    /// Muestra la vista modalmente
    /// - Parameters:
    ///   - destination: vista de destino que se debe presentar
    ///   - transitionStyle: indica el modo de transición que se debe aplicar a la animación
    ///   - animated: indica si la acción debe ser animada
    @MainActor func present<Destination: NavigableView>(_ destination: Destination, transitionStyle: UIModalTransitionStyle?,  animated: Bool)
    
    /// Muestra la vista modalmente
    /// - Parameters:
    ///   - destination: vista de destino que se debe presentar
    ///   - transitionStyle: indica el modo de transición que se debe aplicar a la animación
    ///   - animated: indica si la acción debe ser animada
    ///   - completion: bloque que se ejecuta cuando termina el proceso
    @MainActor func present<Destination: NavigableView>(_ destination: Destination, transitionStyle: UIModalTransitionStyle?,  animated: Bool, completion: (() -> Void)?)
    
    /// Muestra la vista modalmente
    /// - Parameters:
    ///   - destination: vista de destino que se debe presentar
    ///   - presentationStyle: indica el modo de presentación que se debe aplicar a la animación
    ///   - transitionStyle: indica el modo de transición que se debe aplicar a la animación
    ///   - animated: indica si la acción debe ser animada
    @MainActor func present<Destination: NavigableView>(_ destination: Destination, presentationStyle: UIModalPresentationStyle?, transitionStyle: UIModalTransitionStyle?, animated: Bool)
    
    /// Muestra la vista modalmente
    /// - Parameters:
    ///   - destination: vista de destino que se debe presentar
    ///   - presentationStyle: indica el modo de presentación que se debe aplicar a la animación
    ///   - transitionStyle: indica el modo de transición que se debe aplicar a la animación
    ///   - animated: indica si la acción debe ser animada
    ///   - completion: bloque que se ejecuta cuando termina el proceso
    @MainActor func present<Destination: NavigableView>(_ destination: Destination, presentationStyle: UIModalPresentationStyle?, transitionStyle: UIModalTransitionStyle?, animated: Bool, completion: (() -> Void)?)
    
    //MARK: - Present UIHostingController
    
    /// Muestra la vista modalmente
    /// - Parameters:
    ///   - destination: vista de destino que se debe presentar
    ///   - animated: indica si la acción debe ser animada
    @MainActor func present(_ destination: UIHostingController<AnyNavigableView>, animated: Bool)
    
    /// Muestra la vista modalmente
    /// - Parameters:
    ///   - destination: vista de destino que se debe presentar
    ///   - animated: indica si la acción debe ser animada
    ///   - completion: bloque que se ejecuta cuando termina el proceso
    @MainActor func present(_ destination: UIHostingController<AnyNavigableView>, animated: Bool, completion: (() -> Void)?)
    
    /// Muestra la vista modalmente
    /// - Parameters:
    ///   - destination: vista de destino que se debe presentar
    ///   - presentationStyle: indica el modo de presentación que se debe aplicar a la animación
    ///   - animated: indica si la acción debe ser animada
    @MainActor func present(_ destination: UIHostingController<AnyNavigableView>, presentationStyle: UIModalPresentationStyle?, animated: Bool)
    
    /// Muestra la vista modalmente
    /// - Parameters:
    ///   - destination: vista de destino que se debe presentar
    ///   - presentationStyle: indica el modo de presentación que se debe aplicar a la animación
    ///   - animated: indica si la acción debe ser animada
    ///   - completion: bloque que se ejecuta cuando termina el proceso
    @MainActor func present(_ destination: UIHostingController<AnyNavigableView>, presentationStyle: UIModalPresentationStyle?, animated: Bool, completion: (() -> Void)?)
    
    /// Muestra la vista modalmente
    /// - Parameters:
    ///   - destination: vista de destino que se debe presentar
    ///   - transitionStyle: indica el modo de transición que se debe aplicar a la animación
    ///   - animated: indica si la acción debe ser animada
    @MainActor func present(_ destination: UIHostingController<AnyNavigableView>, transitionStyle: UIModalTransitionStyle?, animated: Bool)
    
    /// Muestra la vista modalmente
    /// - Parameters:
    ///   - destination: vista de destino que se debe presentar
    ///   - transitionStyle: indica el modo de transición que se debe aplicar a la animación
    ///   - animated: indica si la acción debe ser animada
    ///   - completion: bloque que se ejecuta cuando termina el proceso
    @MainActor func present(_ destination: UIHostingController<AnyNavigableView>, transitionStyle: UIModalTransitionStyle?, animated: Bool, completion: (() -> Void)?)
    
    /// Muestra la vista modalmente
    /// - Parameters:
    ///   - destination: vista de destino que se debe presentar
    ///   - presentationStyle: indica el modo de presentación que se debe aplicar a la animación
    ///   - transitionStyle: indica el modo de transición que se debe aplicar a la animación
    ///   - animated: indica si la acción debe ser animada
    @MainActor func present(_ destination: UIHostingController<AnyNavigableView>, presentationStyle: UIModalPresentationStyle?, transitionStyle: UIModalTransitionStyle?, animated: Bool)
    
    /// Muestra la vista modalmente
    /// - Parameters:
    ///   - destination: vista de destino que se debe presentar
    ///   - presentationStyle: indica el modo de presentación que se debe aplicar a la animación
    ///   - transitionStyle: indica el modo de transición que se debe aplicar a la animación
    ///   - animated: indica si la acción debe ser animada
    ///   - completion: bloque que se ejecuta cuando termina el proceso
    @MainActor func present(_ destination: UIHostingController<AnyNavigableView>, presentationStyle: UIModalPresentationStyle?, transitionStyle: UIModalTransitionStyle?, animated: Bool, completion: (() -> Void)?)
}

extension NavigationModalActions {
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
    
    @MainActor public func present(_ destination: UIHostingController<AnyNavigableView>,  animated: Bool, completion: (() -> Void)?) {
        present(destination, presentationStyle: nil, transitionStyle: nil, animated: animated, completion: completion)
    }
    
    @MainActor public func present(_ destination: UIHostingController<AnyNavigableView>, presentationStyle: UIModalPresentationStyle?, animated: Bool, completion: (() -> Void)?) {
        present(destination, presentationStyle: presentationStyle, transitionStyle: nil, animated: animated, completion: completion)
    }
    
    @MainActor public func present(_ destination: UIHostingController<AnyNavigableView>, transitionStyle: UIModalTransitionStyle?,  animated: Bool, completion: (() -> Void)?) {
        present(destination, presentationStyle: nil, transitionStyle: transitionStyle, animated: animated, completion: completion)
    }
    
    @MainActor public func present(_ destination: UIHostingController<AnyNavigableView>, presentationStyle: UIModalPresentationStyle?, transitionStyle: UIModalTransitionStyle?,  animated: Bool) {
        present(destination, presentationStyle: presentationStyle, transitionStyle: transitionStyle, animated: animated, completion: nil)
    }
    
    @MainActor public func present(_ destination: UIHostingController<AnyNavigableView>, transitionStyle: UIModalTransitionStyle?,  animated: Bool) {
        present(destination, presentationStyle: nil, transitionStyle: transitionStyle, animated: animated, completion: nil)
    }
    
    @MainActor public func present(_ destination: UIHostingController<AnyNavigableView>, presentationStyle: UIModalPresentationStyle?, animated: Bool) {
        present(destination, presentationStyle: presentationStyle, transitionStyle: nil, animated: animated, completion: nil)
    }
    
    @MainActor public func present(_ destination: UIHostingController<AnyNavigableView>,  animated: Bool) {
        present(destination, presentationStyle: nil, transitionStyle: nil, animated: animated, completion: nil)
    }
    
    @MainActor public func present<Destination: NavigableView>(_ destination: Destination, presentationStyle: UIModalPresentationStyle?, transitionStyle: UIModalTransitionStyle?,  animated: Bool) {
        present(destination, presentationStyle: presentationStyle, transitionStyle: transitionStyle, animated: animated, completion: nil)
    }
    
    @MainActor public func present<Destination: NavigableView>(_ destination: Destination, transitionStyle: UIModalTransitionStyle?,  animated: Bool) {
        present(destination, presentationStyle: nil, transitionStyle: transitionStyle, animated: animated, completion: nil)
    }
    
    @MainActor public func present<Destination: NavigableView>(_ destination: Destination, presentationStyle: UIModalPresentationStyle?,  animated: Bool) {
        present(destination, presentationStyle: presentationStyle, transitionStyle: nil, animated: animated, completion: nil)
    }
    
    @MainActor public func present<Destination: NavigableView>(_ destination: Destination,  animated: Bool) {
        present(destination, presentationStyle: nil, transitionStyle: nil, animated: animated, completion: nil)
    }
}

public struct NavigationControllerModalActionsEnvironmentKey: EnvironmentKey {
    public static var defaultValue: NavigationModalActions? = nil
}

extension EnvironmentValues {
    public var navigationControllerModalActions: NavigationModalActions? {
        get { self[NavigationControllerModalActionsEnvironmentKey.self] }
        set { self[NavigationControllerModalActionsEnvironmentKey.self] = newValue }
    }
}
