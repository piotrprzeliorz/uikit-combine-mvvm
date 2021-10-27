//
//  EmojiPickerBuilder.swift
//  emoji-picker
//
//  Created by Piotr Przeliorz on 14/10/2021.
//

import UIKit

extension Builder.EmojiPicker {

    static func make(context: EmojiPickerViewModel.Context, presentationContext: PopoverPresentationContext) -> UIViewController {
        let viewModel = EmojiPickerViewModel(context: context, dataProvider: EmojiDataProvider())
        let viewController = EmojiPickerViewController(viewModel: viewModel, presentationContext: presentationContext)
        let flowController = EmojiPickerFlowController(verticalFlow: viewController.verticalNavigationFlow)

        viewModel.route
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: flowController.handle)
            .store(in: &viewModel.disposeBag)

        return viewController
    }
}
