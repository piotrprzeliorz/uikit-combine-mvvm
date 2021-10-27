//
//  StatusViewModelType.swift
//  emoji-picker
//
//  Created by Piotr Przeliorz on 14/10/2021.
//

import Combine

enum StatusViewModelRoute {
    case emojiPicker(context: EmojiPickerViewModel.Context, presentationContext: PopoverPresentationContext)
}

struct StatusViewModelInput {
    let emojiPickerAction: AnyPublisher<PopoverPresentationContext, Never>
}

struct StatusViewModelOutput {
    let emoji: AnyPublisher<Emoji, Never>
}

protocol StatusViewModelType {

    typealias Route = StatusViewModelRoute
    typealias Input = StatusViewModelInput
    typealias Output = StatusViewModelOutput

    var route: AnyPublisher<Route, Never> { get }
    var disposeBag: Set<AnyCancellable> { get set }

    func transform(input: Input) -> Output
}
