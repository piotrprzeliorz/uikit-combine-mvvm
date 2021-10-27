//
//  EmojiCategoryCollectionViewHeaderView.swift
//  emoji-picker
//
//  Created by Piotr Przeliorz on 14/10/2021.
//

import UIKit

final class EmojiCategoryCollectionViewHeader: UICollectionReusableView {

    var title: String? {
        set {
            label.text = newValue
        }
        get {
            label.text
        }
    }

    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        makeConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }
}

private extension EmojiCategoryCollectionViewHeader {

    func setup() {
        backgroundColor = .white
        label.font = .systemFont(ofSize: 16.0)
        addSubview(label)
    }

    func makeConstraints() {
        label.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(4.0)
        }
    }
}
