//
//  EventsViewController.swift
//  EventsDemoApp
//
//  Created by Edwin Weru on 04/08/2022.
//

import UIKit

class EventsViewController: UIViewController {
    var viewModel: EventsViewModel!

    init() {
        super.init(nibName: nil, bundle: nil)
        tabBarItem = UITabBarItem(
            title: "Events",
            image: UIImage(named: "002-calendar"),
            selectedImage: UIImage(named: "002-calendar")
        )
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Events"
    }
}
