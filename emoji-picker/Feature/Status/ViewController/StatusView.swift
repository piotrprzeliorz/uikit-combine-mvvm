//
//  StatusView.swift
//  emoji-picker
//
//  Created by Piotr Przeliorz on 14/10/2021.
//

import Combine
import UIKit

final class StatusView: View {

    var didTapEmojiButton: UIControl.EventPublisher {
        textFieldEmojiView.emojiButton.publisher(for: .touchUpInside)
    }

    let textFieldEmojiView = TextFieldEmojiView()
    private let textField = TextField()

    init() {
        super.init(frame: .zero)
        setup()
        makeConstraints()
    }
}

private extension StatusView {

    func setup() {
        backgroundColor = .white

        textField.placeholder = "Add a status..."
        textField.leftView = textFieldEmojiView
        textField.leftViewMode = .always
        
        addSubview(textField)
    }

    func makeConstraints() {
        textField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(15.0)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(25.0)
        }
    }
}

