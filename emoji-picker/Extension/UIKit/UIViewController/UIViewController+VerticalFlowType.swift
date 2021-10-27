//
//  UIViewController+VerticalFlowType.swift
//  emoji-picker
//
//  Created by Piotr Przeliorz on 14/10/2021.
//

import UIKit

extension UIViewController {

    var verticalNavigationFlow: VerticalFlowType {
        NavigationFlow(contextController: self)
    }
}

private extension UIViewController {

    struct NavigationFlow: VerticalFlowType {

        private weak var contextController: UIViewController?

        init(contextController: UIViewController) {
            self.contextController = contextController
        }

        func navigate(to viewController: UIViewController, animated: Bool, completion: (() -> Void)? = nil) {
            contextController?.present(viewController, animated: animated, completion: completion)
        }

        func navigateBack(animated: Bool, completion: (() -> Void)?) {
            contextController?.dismiss(animated: animated, completion: completion)
        }
    }
}

