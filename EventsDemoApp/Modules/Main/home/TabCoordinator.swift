//
//  TabBarCoordinator.swift
//  KuneFood
//
//  Created by Edwin Weru on 02/09/2021.
//

import UIKit

final class TabCoordinator: Coordinator {
    lazy var coordinator01 = EventsCoodinator(parentCoordinator: self)
    lazy var coordinator02 = SchedulesCoordinator(parentCoordinator: self)

    lazy var mainController: HomeViewController = {
        let vc = HomeViewController()

        vc.viewControllers = {
            var childViewControllers: [UIViewController] = []

            childViewControllers.append(coordinator01.primaryViewController())
            childViewControllers.append(coordinator02.primaryViewController())

            return childViewControllers
        }()

        return vc
    }()

    private func logout() {
        parentCoordinator?.dismiss()
        dismiss()
    }

    override func start() {
        let navController = BaseNavigationController(rootViewController: mainController)
        navController.modalPresentationStyle = .fullScreen

        navController.setNavigationBarHidden(true, animated: true)
        present(viewController: navController, animated: true)

        navigationController = navController
    }

    private func showHomeTab() {
        guard let index = mainController.viewControllers?.firstIndex(where: { $0 is EventsViewController }) else { return }
        mainController.selectedIndex = index
    }
}
