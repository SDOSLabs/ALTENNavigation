//
//  NavigableViewModel.swift
//
//  Copyright © 2022 ALTEN. All rights reserved.
//

import Foundation

/// Protocolo para los `ObservableObject`s que usa SwiftUI como ViewModel.
public protocol NavigableViewModel: AnyObject {
    /// Acciones de navegación que debe incluir para que el `ViewModel` pueda encargarse de realizar la navegación
    var navigationActions: NavigationActions? { get set }
}
