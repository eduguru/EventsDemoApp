//
//  AppDelegate.swift
//  EventsDemoApp
//
//  Created by Edwin Weru on 02/08/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    private var coordinator: AppCoordinator?
    private let blurView = UIVisualEffectView()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupCoordinator(application)

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
}

extension AppDelegate {
    private func setupCoordinator(_ application: UIApplication) {
        var window = application.windows.first(where: { $0.isKeyWindow })
        window?.resignKey()
        let navController = BaseNavigationController()
        navController.setNavigationBarHidden(true, animated: true)

        window = nil

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navController
        window?.backgroundColor = .white
        window?.makeKeyAndVisible()

        self.window = window

        coordinator = AppCoordinator(navigationController: navController, completion: nil)
        coordinator?.start()
    }
}
