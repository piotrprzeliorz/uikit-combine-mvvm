//
//  EmojiCategory.swift
//  emoji-picker
//
//  Created by Piotr Przeliorz on 14/10/2021.
//

struct EmojiCategory {

    let title: String
    let emojis: [Emoji]
}

extension EmojiCategory: Comparable {

    static func < (lhs: EmojiCategory, rhs: EmojiCategory) -> Bool {
        lhs.title < rhs.title
    }
}
