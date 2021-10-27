//
//  StatusViewModel.swift
//  emoji-picker
//
//  Created by Piotr Przeliorz on 14/10/2021.
//

import Combine
import Foundation

final class StatusViewModel: StatusViewModelType {

    var route: AnyPublisher<Route, Never> {
        routeSubject.eraseToAnyPublisher()
    }

    var disposeBag = Set<AnyCancellable>()

    private let routeSubject: PassthroughSubject<Route, Never> = .init()
}

extension StatusViewModel {

    func transform(input: Input) -> Output {
        let selectedEmoji: PassthroughSubject<Emoji, Never> = .init()

        input.emojiPickerAction
            .map { Route.emojiPicker(context: .init(selectedEmoji: selectedEmoji), presentationContext: $0) }
            .sink(receiveValue: routeSubject.send)
            .store(in: &disposeBag)

        return .init(emoji: selectedEmoji.eraseToAnyPublisher())
    }
}
