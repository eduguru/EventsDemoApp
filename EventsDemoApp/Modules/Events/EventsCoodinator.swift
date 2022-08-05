//
//  CartCoodinator.swift
//  AutoCarDemo
//
//  Created by Edwin Weru on 21/07/2022.
//

import UIKit

class EventsCoodinator: Coordinator {
    func primaryViewController() -> UIViewController {
        let vc = EventsViewController()
        let model = EventsViewModel()
        vc.viewModel = model
        vc.goToEvent = showEventDetails

        let navC = BaseNavigationController(rootViewController: vc)
        navigationController = navC
        return navC
    }

    private func showEventDetails(selected: EventModel?) {
        let vc = VideoPlaybackViewController()
        let model = VideoPlaybackViewModel()

        model.selected = selected
        vc.viewModel = model

        push(viewController: vc)
    }
}
