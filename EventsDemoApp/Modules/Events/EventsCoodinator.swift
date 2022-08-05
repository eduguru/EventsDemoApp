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

        return vc
    }
}
