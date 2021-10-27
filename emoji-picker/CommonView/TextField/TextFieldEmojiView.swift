//
//  TextFieldEmojiView.swift
//  emoji-picker
//
//  Created by Piotr Przeliorz on 14/10/2021.
//

import SnapKit
import UIKit

final class TextFieldEmojiView: View {

    var emoji: String? = nil {
        didSet {
            updateContent()
        }
    }

    private(set) lazy var emojiButton: UIButton  = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .systemFont(ofSize: 24.0)
        button.tintColor = .black
        button.semanticContentAttribute = UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft ? .forceLeftToRight : .forceRightToLeft
        return button
    }()

    private let verticalBar: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        makeConstraints()
        updateContent()
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard superview != nil else {
            return
        }

        snp.makeConstraints { make in
            make.height.equalToSuperview()
        }
    }
}

private extension TextFieldEmojiView {

    func updateContent() {
        guard let emoji = emoji else {
            emojiButton.setTitle(nil, for: .normal)
            return
        }

        UIView.transition(with: emojiButton, duration: 0.2, options: .transitionCrossDissolve, animations: {
            self.emojiButton.setTitle(emoji, for: .normal)
        }, completion: nil)
    }
}

private extension TextFieldEmojiView {

    func setup() {
        addSubview(emojiButton)
        addSubview(verticalBar)
        emoji = "😍"
    }

    func makeConstraints() {
        emojiButton.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(5.0)
            make.trailing.equalTo(verticalBar.snp.leading).offset(-5.0)
            make.centerY.equalToSuperview()
            make.width.equalTo(50.0)
        }

        verticalBar.snp.makeConstraints { make in
            make.width.equalTo(2.0)
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}

