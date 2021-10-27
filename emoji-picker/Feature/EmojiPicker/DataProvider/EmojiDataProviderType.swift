//
//  EmojiDataProviderType.swift
//  emoji-picker
//
//  Created by Piotr Przeliorz on 14/10/2021.
//

import Combine
import Foundation

protocol EmojiDataProviderType {
    
    func fetch() -> AnyPublisher<[EmojiCategory], Error>
}

struct EmojiDataProvider: EmojiDataProviderType {
    
    private static let fileName: StaticString = "emoji"
    private static let fileExtension: StaticString = "json"

    private let decoder = JSONDecoder()
}

extension EmojiDataProvider {

    func fetch() -> AnyPublisher<[EmojiCategory], Error> {
        Deferred {
            Future { future in
                do {
                    let emoji = try load()
                    future(.success(emoji))
                } catch {
                    future(.failure(error))
                }
            }
        }
        .subscribe(on: DispatchQueue.global(qos: .userInteractive))
        .eraseToAnyPublisher()
    }
}

private extension EmojiDataProvider {
    
    func load() throws -> [EmojiCategory] {
        guard let url = Bundle.main.url(forResource: Self.fileName.description,
                                        withExtension: Self.fileExtension.description) else {
            fatalError("Could not create URL for \(Self.fileName).\(Self.fileExtension)")
        }
        
        do {
            let data = try Data(contentsOf: url)
            let emojis = try decoder.decode([Emoji].self, from: data)
            return Dictionary(grouping: emojis, by: \.category)
                .map { EmojiCategory(title: $0.key, emojis: $0.value) }
                .sorted()
        } catch {
            throw error
        }
    }
}
