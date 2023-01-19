//
//  PopoverPresentationContext.swift
//  emoji-picker
//
//  Created by Piotr Przeliorz on 14/10/2021.
//

import UIKit

struct PopoverPresentationContext {

    unowned let sourceView: UIView
    unowned let sourceItem: UIView
    weak var delegate: UIPopoverPresentationControllerDelegate?
    let preferredContentSize: CGSize

    init(
        sourceView: UIView,
        sourceItem: UIView,
        delegate: UIPopoverPresentationControllerDelegate?,
        preferredContentSize: CGSize = .init(width: 350.0, height: UIView.noIntrinsicMetric)
    ) {
        self.sourceView = sourceView
        self.sourceItem = sourceItem
        self.delegate = delegate
        self.preferredContentSize = preferredContentSize
    }
}
