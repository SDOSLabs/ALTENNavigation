//
//  NavigationPushActions.swift
//
//  Copyright © 2022 ALTEN. All rights reserved.
//

import SwiftUI

public protocol NavigationPushActions: AnyObject {
    /// NavigationController actual sobre el que se realizan las acciones
    var navigationController: ALTENUINavigationController? { get }
    
    //MARK: - Push
    
    /// Navega a la pantalla indicada añadiendola al stack actual
    /// - Parameters:
    ///   - destination: pantalla de destino a la que debe navegar
    ///   - animated: indica si la acción debe ser animada
    @MainActor func push<Destination: NavigableView>(_ destination: Destination, animated: Bool)
    
    /// Navega a la pantalla indicada añadiendola al stack actual
    /// - Parameters:
    ///   - destination: pantalla de destino a la que debe navegar
    ///   - animated: indica si la acción debe ser animada
    @MainActor func push(_ destination: UIHostingController<AnyNavigableView>, animated: Bool)
    
    //MARK: - Pop
    
    /// Vuelve a la pantalla anterior del stack actual
    ///   - animated: indica si la acción debe ser animada
    @MainActor func pop(animated: Bool)
    
    /// Vuelve a la pantalla inicial del stack actual
    ///   - animated: indica si la acción debe ser animada
    @MainActor func popToRoot(animated: Bool)
    
    /// Vuelve a la pantalla del stack actual que tenga el mismo `identifier`. Si no encuentra ninguna vista con el identificador indicado en el stack no hará nada
    /// - Parameters:
    ///   - identifier: identificador del vista hasta la que debe volver
    ///   - animated: indica si la acción debe ser animada
    @MainActor func popTo(_ identifier: String, animated: Bool)
    
    //MARK: - Set
    
    /// Añade un array de vistas al stack. Se presentará el último indicado
    /// - Parameters:
    ///   - views: vistas a introducir en el stack
    ///   - animated: indica si la acción debe ser animada
    @MainActor func setViews<Destination: NavigableView>(_ views:[Destination], animated: Bool)
    
    /// Añade un array de vistas al stack. Se presentará el último indicado
    /// - Parameters:
    ///   - views: vistas a introducir en el stack
    ///   - animated: indica si la acción debe ser animada
    @MainActor func setViews(_ views:[UIHostingController<AnyNavigableView>], animated: Bool)
}


public struct NavigationActionsEnvironmentKey: EnvironmentKey {
    public static var defaultValue: NavigationActions? = nil
}

extension EnvironmentValues {
    public var navigationActions: NavigationActions? {
        get { self[NavigationActionsEnvironmentKey.self] }
        set { self[NavigationActionsEnvironmentKey.self] = newValue }
    }
}
