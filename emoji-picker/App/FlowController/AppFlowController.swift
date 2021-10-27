//
//  AppFlowController.swift
//  emoji-picker
//
//  Created by Piotr Przeliorz on 14/10/2021.
//

import UIKit

final class AppFlowController {

    private var rootController: UIViewController? {
        didSet {
            updateWindowRoot()
        }
    }

    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
        setup()
    }
}

extension AppFlowController {

    func start() {
        let navigationController = UINavigationController()
        navigationController.viewControllers = [Builder.Status.make()]
        rootController = navigationController
        window.makeKeyAndVisible()
    }
}

private extension AppFlowController {

    func setup() {
        window.backgroundColor = .white
    }

    func updateWindowRoot() {
        window.rootViewController = rootController
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
}

