//
//  BaseNavigationController.swift
//
//  Created by Edwin Weru

import UIKit

class BaseNavigationController: UINavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarAppearance()
        view.backgroundColor = .aluminum
    }

    private func setupNavigationBarAppearance() {
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)

        navigationBar.tintColor = .colorPrimary
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        removeBackButtonTitle(for: viewController)
        super.pushViewController(viewController, animated: animated)
    }

    override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        viewControllers.forEach(removeBackButtonTitle(for:))
        super.setViewControllers(viewControllers, animated: animated)
    }

    private func removeBackButtonTitle(for viewController: UIViewController) {
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil)
    }
}
