//
//  Emoji.swift
//  emoji-picker
//
//  Created by Piotr Przeliorz on 14/10/2021.
//

struct Emoji: Decodable, Hashable {

    let emoji: String
    let category: String
    let aliases: [String]
}

extension Emoji {

    func isMatching(query: String) -> Bool {
        aliases.first(where: { $0.lowercased().contains(query.lowercased())}) != nil
    }
}
