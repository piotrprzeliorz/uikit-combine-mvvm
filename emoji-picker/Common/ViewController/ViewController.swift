//
//  ViewController.swift
//  emoji-picker
//
//  Created by Piotr Przeliorz on 14/10/2021.
//

import UIKit

class ViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        print("📺 \(type(of: self)) -> \(#function)")
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    deinit {
        print("☠️ \(type(of: self)) -> \(#function)")
    }
}
