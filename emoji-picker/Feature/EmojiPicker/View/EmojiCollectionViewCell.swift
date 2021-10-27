//
//  EmojiCollectionViewCell.swift
//  emoji-picker
//
//  Created by Piotr Przeliorz on 14/10/2021.
//

import UIKit

final class EmojiCollectionViewCell: UICollectionViewCell {

    private static let animationDuration: TimeInterval = 0.25

    var title: String? {
        set {
            label.text = newValue
        }
        get {
            label.text
        }
    }

    private let label = UILabel()

    override var isHighlighted: Bool {
        didSet {
            animate(isHighlighted: isHighlighted)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
        makeConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        nil
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
    }
}

private extension EmojiCollectionViewCell {

    func setup() {
        label.font = .systemFont(ofSize: 30.0)
        label.textAlignment = .center
        contentView.addSubview(label)
    }

    func makeConstraints() {
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func animate(isHighlighted: Bool) {
        UIView.animate(withDuration: Self.animationDuration) {
            if isHighlighted {
                self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            } else {
                self.transform = .identity
            }
        }
    }
}
