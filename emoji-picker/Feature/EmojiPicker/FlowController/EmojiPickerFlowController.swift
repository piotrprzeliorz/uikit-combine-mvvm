//
//  EmojiPickerFlowController.swift
//  emoji-picker
//
//  Created by Piotr Przeliorz on 14/10/2021.
//

struct EmojiPickerFlowController {

    private let verticalFlow: VerticalFlowType

    init(verticalFlow: VerticalFlowType) {
        self.verticalFlow = verticalFlow
    }

    func handle(route: EmojiPickerViewModelRoute) {
        switch route {
        case .close:
            verticalFlow.navigateBack(animated: true, completion: nil)
        }
    }
}
