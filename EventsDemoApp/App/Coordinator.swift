//
//  Coordinator.swift
//
//  Created by Edwin Weru

import UIKit

class Coordinator: NSObject {
    var completion: () -> Void = {}

    var subCoordinator: Coordinator?
    weak var parentCoordinator: Coordinator?
    weak var navigationController: UINavigationController?

    init(navigationController: UINavigationController?, completion: (() -> Void)?) {
        self.navigationController = navigationController

        if let completion = completion {
            self.completion = completion
        }
    }

    convenience init(viewController: UIViewController, completion: (() -> Void)?) {
        self.init(navigationController: viewController.navigationController, completion: completion)
    }

    init(parentCoordinator: Coordinator) {
        self.completion = parentCoordinator.completion
        self.navigationController = parentCoordinator.navigationController

        super.init()

        parentCoordinator.subCoordinator = self
        self.parentCoordinator = parentCoordinator
    }

    func start() {}

    func start(subCoordinator: Coordinator) {
        self.subCoordinator = subCoordinator
        self.subCoordinator?.start()
    }

    func completeSubWorkflow() {
        self.subCoordinator = nil
    }

    func present(viewController: UIViewController, animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController?.present(viewController, animated: animated, completion: completion)
    }

    func dismiss(animated: Bool = true, completion: (() -> Void)? = nil) {
        navigationController?.dismiss(animated: animated, completion: completion)
    }

    func push(viewController: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(viewController, animated: animated)
    }

    func pop(animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }

    func finishWorkflow() {
        if let parentWorkflow = parentCoordinator {
            parentWorkflow.completeSubWorkflow()
        } else {
            completeSubWorkflow()
            completion()
        }
    }

    func topViewController() -> UIViewController? {
        var topController: UIViewController? = navigationController
        while let presentedViewController = topController?.presentedViewController {
            topController = presentedViewController
        }

        return topController
    }

    func popBack<T: UIViewController>(toControllerType: T.Type) -> UIViewController? {
        navigationController?.viewControllers.first(where: { $0.isKind(of: toControllerType) })
    }

    deinit {
        print("--- \(self) deinit")
    }
}
