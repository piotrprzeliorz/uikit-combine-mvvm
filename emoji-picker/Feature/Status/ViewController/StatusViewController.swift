//
//  StatusViewController.swift
//  emoji-picker
//
//  Created by Piotr Przeliorz on 14/10/2021.
//

import UIKit

final class StatusViewController: ViewController, CustomViewType {
    
    typealias View = StatusView
    
    private var viewModel: StatusViewModelType
    
    init(viewModel: StatusViewModelType) {
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func loadView() {
        view = View()
    }
}

private extension StatusViewController {
    
    func bind() {
        let context = PopoverPresentationContext(
            sourceView: customView,
            sourceItem: customView.textFieldEmojiView,
            delegate: self
        )
        let emojiPickerAction = customView.didTapEmojiButton
            .map { _ in context }
            .eraseToAnyPublisher()
        
        let input = StatusViewModelInput(emojiPickerAction: emojiPickerAction)
        let output = viewModel.transform(input: input)
        
        output.emoji
            .sink { [customView] in
                customView.textFieldEmojiView.emoji = $0.emoji
            }
            .store(in: &viewModel.disposeBag)
    }
}

extension StatusViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        .none
    }
}
