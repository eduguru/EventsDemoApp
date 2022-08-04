//
//  SchedulesViewController.swift
//  EventsDemoApp
//
//  Created by Edwin Weru on 04/08/2022.
//

import UIKit

class SchedulesViewController: UIViewController {
    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(
            title: "Schedules",
            image: UIImage(named: "001-calendar"),
            selectedImage: UIImage(named: "001-calendar")
        )
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Schedules"
    }
}
