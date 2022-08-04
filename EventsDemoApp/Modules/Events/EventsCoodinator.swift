//
//  CartCoodinator.swift
//  AutoCarDemo
//
//  Created by Edwin Weru on 21/07/2022.
//

import UIKit

class EventsCoodinator: Coordinator {
    func primaryViewController() -> EventsViewController {
        let vc = EventsViewController()
        // let model = ViewModel()

        return vc
    }
}
