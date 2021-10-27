//
//  EmojiPickerViewModel.swift
//  emoji-picker
//
//  Created by Piotr Przeliorz on 14/10/2021.
//

import Combine
import Foundation

extension EmojiPickerViewModel {

    struct Context {
        let selectedEmoji: PassthroughSubject<Emoji, Never>
    }
}

final class EmojiPickerViewModel: EmojiPickerViewModelType {

    var route: AnyPublisher<Route, Never> {
        routeSubject.eraseToAnyPublisher()
    }

    var disposeBag = Set<AnyCancellable>()

    private let routeSubject: PassthroughSubject<Route, Never> = .init()

    private let dataProvider: EmojiDataProviderType

    private let context: Context

    init(context: Context, dataProvider: EmojiDataProviderType) {
        self.context = context
        self.dataProvider = dataProvider
    }
}

extension EmojiPickerViewModel {

    func transform(input: Input) -> Output {
        let context = self.context
        let selectedEmojiReceiveOutput = Self.provideSelectedEmojiClosure(context: context)
        let defaultEmojis = dataProvider.fetch()
            .replaceError(with: [])
            .eraseToAnyPublisher()
            .share()

        let filteredEmojis = input.searchQuery
            .withLatestFrom(defaultEmojis)
            .map(Self.filterMatching)

        let emojis = Publishers.Merge(defaultEmojis, filteredEmojis)
            .eraseToAnyPublisher()

        input.selectedEmoji
            .handleEvents(receiveOutput: selectedEmojiReceiveOutput)
            .map { _ in Route.close }
            .sink(receiveValue: routeSubject.send)
            .store(in: &disposeBag)

        return .init(emojis: emojis)
    }
}

private extension EmojiPickerViewModel {

    static func filterMatching(query: String, emojis: [EmojiCategory]) -> [EmojiCategory] {
        guard !query.isEmpty else {
            return emojis
        }

        let filteredEmojis: [EmojiCategory] = emojis.map { category in
                .init(title: category.title, emojis: category.emojis.filter { $0.isMatching(query: query) })
        }

        return filteredEmojis.filter { !$0.emojis.isEmpty }
    }

    static func provideSelectedEmojiClosure(context: Context) -> (Emoji) -> Void {
        return { emoji in
            context.selectedEmoji.send(emoji)
        }
    }
}
