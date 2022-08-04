//
//  SchedulesCoordinator.swift
//  EventsDemoApp
//
//  Created by Edwin Weru on 04/08/2022.
//

import Foundation

class SchedulesCoordinator: Coordinator {
    func primaryViewController() -> SchedulesViewController {
        let vc = SchedulesViewController()
        // let model = ViewModel()

        return vc
    }
}
