//
//  SchedulesViewController.swift
//  EventsDemoApp
//
//  Created by Edwin Weru on 04/08/2022.
//

import RxCocoa
import RxSwift
import UIKit

class SchedulesViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    var viewModel: SchedulesViewModel!
    private let disposeBag = DisposeBag()

    var controllerWillDisappear: () -> Void = {}

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
        setupTableView()
    }

    override func viewWillDisappear(_: Bool) {
        self.controllerWillDisappear()
    }

    private func setupTableView() {
        tableView.register(ScheduleTableViewCell.nib(), forCellReuseIdentifier: ScheduleTableViewCell.reuseIdentifier)
        tableView.rowHeight = 120

        viewModel.scheduleSubject
            .asObservable()
            .bind(to: tableView.rx.items(
                cellIdentifier: ScheduleTableViewCell.reuseIdentifier,
                cellType: ScheduleTableViewCell.self
            )) { [weak self] _, item, cell in
                cell.configure(with: ScheduleModel(model: item))
            }
            .disposed(by: disposeBag)
    }
}
