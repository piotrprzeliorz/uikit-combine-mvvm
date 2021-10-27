//
//  StatusFlowController.swift
//  emoji-picker
//
//  Created by Piotr Przeliorz on 14/10/2021.
//

struct StatusFlowController {

    private let verticalFlow: VerticalFlowType

    init(verticalFlow: VerticalFlowType) {
        self.verticalFlow = verticalFlow
    }

    func handle(route: StatusViewModelRoute) {
        switch route {
        case let .emojiPicker(context, presentationContext):
            let viewController = Builder.EmojiPicker.make(context: context, presentationContext: presentationContext)
            verticalFlow.navigate(to: viewController, animated: true, completion: nil)
        }
    }
}
