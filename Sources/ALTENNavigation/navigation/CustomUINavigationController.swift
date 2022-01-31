//
//  CustomUINavigationController.swift
//  Rafita_app
//
//  Created by rafael.fernandez on 21/12/21.
//  Copyright © 2021 company_app. All rights reserved.
//

import UIKit
import SwiftUI

public final class CustomUINavigationController: UINavigationController, UINavigationControllerDelegate {

    public override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        guard let hostingController = viewController as? UIHostingController<AnyNavigableView> else { return }
        if let style = hostingController.rootView.applyNavigationStyle() {
            style(self)
        }
    }

}
