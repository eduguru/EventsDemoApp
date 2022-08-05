//
//  UIViewController.swift
//  Little Agent
//
//  Created by edwin weru on 17/12/2020.
//

import AVFoundation
import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: - extension

extension UIViewController {
    static func topMostViewController() -> UIViewController? {
        if #available(iOS 13.0, *) {
            let keyWindow = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
            return keyWindow?.rootViewController?.topMostViewController()
        }

        return UIApplication.shared.keyWindow?.rootViewController?.topMostViewController()
    }

    func topMostViewController() -> UIViewController? {
        if let navigationController = self as? UINavigationController {
            return navigationController.topViewController?.topMostViewController()
        } else if let tabBarController = self as? UITabBarController {
            if let selectedViewController = tabBarController.selectedViewController {
                return selectedViewController.topMostViewController()
            }
            return tabBarController.topMostViewController()
        } else if let presentedViewController = self.presentedViewController {
            return presentedViewController.topMostViewController()
        } else {
            return self
        }
    }
}

// extension for resetting the window on a UIKit application
extension UIViewController {
    private func resetWindow(with vc: UIViewController?) {
        if #available(iOS 13.0, *) {
            guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else {
                fatalError("could not get scene delegate ")
            }

            sceneDelegate.window?.rootViewController = vc
        } else {
            // Fallback on earlier versions
        }
    }

    func showViewController(with id: String) {
        if #available(iOS 13.0, *) {
            let vc = storyboard?.instantiateViewController(identifier: id)

            resetWindow(with: vc)
        } else {
            // Fallback on earlier versions
        }
    }
}

// example case of resetting the window from a login view controller
// this will transition from a login vc to a navigation controller with the app logic
// @IBAction func explore(_ sender: UIButton) {
//  showViewController(with: "BBQNavController")
// }
