//
//  NavigableViewModel.swift
//
//  Copyright © 2021 company_app. All rights reserved.
//

import Foundation

public protocol NavigableViewModel: AnyObject {
    var navigationControllerActions: NavigationControllerActions? { get set }
}
