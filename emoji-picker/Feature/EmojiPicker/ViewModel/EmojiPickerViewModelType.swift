//
//  EmojiPickerViewModelType.swift
//  emoji-picker
//
//  Created by Piotr Przeliorz on 14/10/2021.
//

import Combine

enum EmojiPickerViewModelRoute {
    case close
}

struct EmojiPickerViewModelInput {
    let searchQuery: AnyPublisher<String, Never>
    let selectedEmoji: AnyPublisher<Emoji, Never>
}

struct EmojiPickerViewModelOutput {
    let emojis: AnyPublisher<[EmojiCategory], Never>
}

protocol EmojiPickerViewModelType {

    typealias Route = EmojiPickerViewModelRoute
    typealias Input = EmojiPickerViewModelInput
    typealias Output = EmojiPickerViewModelOutput

    var route: AnyPublisher<Route, Never> { get }
    var disposeBag: Set<AnyCancellable> { get set }

    func transform(input: Input) -> Output
}

