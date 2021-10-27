//
//  PopoverPresentationContext.swift
//  emoji-picker
//
//  Created by Piotr Przeliorz on 14/10/2021.
//

import UIKit

struct PopoverPresentationContext {

    unowned let sourceView: UIView
    weak var delegate: UIPopoverPresentationControllerDelegate?
    let preferredContentSize: CGSize

    init(sourceView: UIView,
         delegate: UIPopoverPresentationControllerDelegate?,
         preferredContentSize: CGSize = .init(width: 350.0, height: UIView.noIntrinsicMetric)) {
        self.sourceView = sourceView
        self.delegate = delegate
        self.preferredContentSize = preferredContentSize
    }
}
