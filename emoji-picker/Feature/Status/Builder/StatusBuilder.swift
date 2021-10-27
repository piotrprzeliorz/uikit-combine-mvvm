//
//  StatusBuilder.swift
//  emoji-picker
//
//  Created by Piotr Przeliorz on 14/10/2021.
//

import UIKit

extension Builder.Status {

    static func make() -> UIViewController {
        let viewModel = StatusViewModel()
        let viewController = StatusViewController(viewModel: viewModel)
        let flowController = StatusFlowController(verticalFlow: viewController.verticalNavigationFlow)

        viewModel.route
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: flowController.handle)
            .store(in: &viewModel.disposeBag)

        return viewController
    }
}
