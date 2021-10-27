//
//  TextField.swift
//  emoji-picker
//
//  Created by Piotr Przeliorz on 14/10/2021.
//

import UIKit

final class TextField: UITextField {
    
    static let defaultHeight: CGFloat = 56.0
    
    
    override class var requiresConstraintBasedLayout: Bool {
        true
    }
    
    override var intrinsicContentSize: CGSize {
        .init(width: UIView.noIntrinsicMetric, height: Self.defaultHeight)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
}

private extension TextField {
    
    func setup() {
        font = .systemFont(ofSize: 16.0, weight: .medium)
        textColor = .black
        tintColor = .black
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.black.cgColor
        layer.cornerRadius = 10.0
        layer.masksToBounds = true
    }
}

extension TextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds).inset(by: textRectInsets)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        super.editingRect(forBounds: bounds).inset(by: textRectInsets)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        super.placeholderRect(forBounds: bounds).inset(by: placeholderRectInsets)
    }
}

private extension TextField {
    
    var textRectInsets: UIEdgeInsets {
        .init(top: .zero,
              left: 16.0,
              bottom: .zero,
              right: 16.0)
    }
    
    var placeholderRectInsets: UIEdgeInsets {
        .init(top: .zero,
              left: 4.0,
              bottom: .zero,
              right: 4.0)
    }
}
