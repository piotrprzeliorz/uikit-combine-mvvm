//
//  AppDelegate.swift
//  emoji-picker
//
//  Created by Piotr Przeliorz on 14/10/2021.
//

import UIKit

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var window: UIWindow? = UIWindow()
    private var appFlowController: AppFlowController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        start()
        return true
    }
}

private extension AppDelegate {

    func start()  {
        guard let window = window else {
            return
        }

        appFlowController = .init(window: window)
        appFlowController?.start()
    }
}

