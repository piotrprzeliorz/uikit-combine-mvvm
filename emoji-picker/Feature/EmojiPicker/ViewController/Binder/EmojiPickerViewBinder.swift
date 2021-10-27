//
//  EmojiPickerViewBinder.swift
//  emoji-picker
//
//  Created by Piotr Przeliorz on 14/10/2021.
//

import Combine
import UIKit

enum EmojiPickerViewBinder {

    static func bind(dataSource: EmojiPickerViewController.EmojisPickerCollectionViewDataSource,
                     output: EmojiPickerViewModelOutput,
                     disposeBag: inout Set<AnyCancellable>) {
        output.emojis
            .receive(on: RunLoop.main)
            .sink { emojiCategories in
                var snapshot = dataSource.snapshot()
                snapshot.deleteAllItems()
                emojiCategories.forEach { category in
                    snapshot.appendSections([category.title])
                    snapshot.appendItems(category.emojis, toSection: category.title)
                }

                dataSource.apply(snapshot, animatingDifferences: true)
            }
            .store(in: &disposeBag)
    }
}
