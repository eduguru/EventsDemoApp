//
//  AppCoordinator.swift
//
//  Created by Edwin Weru
//

import UIKit

final class AppCoordinator: Coordinator {
    override func start() {
        goToApp()
    }

    private func goToApp() {
        let coordinator = TabCoordinator(parentCoordinator: self)
        coordinator.start()
    }
}
