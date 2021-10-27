//
//  EmojiPickerViewController.swift
//  emoji-picker
//
//  Created by Piotr Przeliorz on 14/10/2021.
//

import Combine
import UIKit

final class EmojiPickerViewController: ViewController, CustomViewType {
    
    typealias View = EmojiPickerView

    typealias EmojisPickerCollectionViewDataSource = UICollectionViewDiffableDataSource<String, Emoji>

    private typealias ViewBinder = EmojiPickerViewBinder
    
    private var viewModel: EmojiPickerViewModelType
    
    private lazy var dataSource: EmojisPickerCollectionViewDataSource = provideDataSource()
    
    init(viewModel: EmojiPickerViewModelType, presentationContext: PopoverPresentationContext) {
        self.viewModel = viewModel
        super.init()
        setupPopoverAttributes(for: presentationContext)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func loadView() {
        view = View()
    }
}

private extension EmojiPickerViewController {
    
    func provideDataSource() -> EmojisPickerCollectionViewDataSource {
        let dataSource = EmojisPickerCollectionViewDataSource(collectionView: customView.collectionView) { collectionView, indexPath, emoji in
            let cell: EmojiCollectionViewCell = collectionView.dequeue(for: indexPath)
            cell.title = emoji.emoji
            return cell
        }

        dataSource.supplementaryViewProvider = { collectionView, identifier, indexPath in
            let headerItem = dataSource.snapshot().sectionIdentifiers[indexPath.section]
            let view: EmojiCategoryCollectionViewHeader = collectionView.dequeueHeaderView(for: indexPath)
            view.title = headerItem
            return view
        }

        return dataSource
    }
}

private extension EmojiPickerViewController {
    
    func bind() {
        let searchQuery = customView.searchBarTextSubject
            .eraseToAnyPublisher()
        let selectedEmoji = customView.selectedIndexSubject
            .map(dataSource.itemIdentifier)
            .compactMap { $0 }
            .eraseToAnyPublisher()

        let input = EmojiPickerViewModelInput(searchQuery: searchQuery,
                                              selectedEmoji: selectedEmoji)
        let output = viewModel.transform(input: input)
        ViewBinder.bind(dataSource: dataSource,
                        output: output,
                        disposeBag: &viewModel.disposeBag)
    }
}

private extension EmojiPickerViewController {
    
    func setupPopoverAttributes(for presentationContext: PopoverPresentationContext) {
        modalPresentationStyle = .popover
        preferredContentSize = presentationContext.preferredContentSize
        guard let popoverPresentationController = popoverPresentationController else {
            fatalError("Popover presentation controller could not be nil")
        }
        
        popoverPresentationController.delegate = presentationContext.delegate
        popoverPresentationController.permittedArrowDirections = [.up, .down]
        popoverPresentationController.sourceView = presentationContext.sourceView
    }
}
