//
//  VerticalFlowType.swift
//  emoji-picker
//
//  Created by Piotr Przeliorz on 14/10/2021.
//

import UIKit

protocol VerticalFlowType {

    func navigate(to viewController: UIViewController, animated: Bool, completion: (() -> Void)?)
    func navigateBack(animated: Bool, completion: (() -> Void)?)
}

