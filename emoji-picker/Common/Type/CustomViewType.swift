//
//  CustomViewType.swift
//  emoji-picker
//
//  Created by Piotr Przeliorz on 14/10/2021.
//

import UIKit

protocol CustomViewType {

    associatedtype View: UIView

    var customView: View { get }
}

extension CustomViewType where Self: UIViewController {

    var customView: View {
        guard let view: View = self.view as? View else {
            fatalError("Custom view type mismatch: expected \(View.self) and got \(type(of: self.view))")
        }
        return view
    }
}
