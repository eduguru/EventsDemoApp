//
//  EventsViewController.swift
//  EventsDemoApp
//
//  Created by Edwin Weru on 04/08/2022.
//

import RxCocoa
import RxSwift
import UIKit

class EventsViewController: UIViewController {
    @IBOutlet var tableView: UITableView!

    var goToEvent: (EventModel?) -> Void = { _ in }
    var viewModel: EventsViewModel!
    private let disposeBag = DisposeBag()

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
        setupTableView()
    }

    private func setupTableView() {
        tableView.register(EventsTableViewCell.nib(), forCellReuseIdentifier: EventsTableViewCell.reuseIdentifier)
        tableView.rowHeight = 120
        viewModel.eventsSubject
            .asObservable()
            .bind(to: tableView.rx.items(
                cellIdentifier: EventsTableViewCell.reuseIdentifier,
                cellType: EventsTableViewCell.self
            )) { [weak self] _, item, cell in
                cell.configure(with: EventModel(model: item))
            }
            .disposed(by: disposeBag)

        tableView.rx.modelSelected(EventsResponse.self)
            .subscribe(onNext: { [weak self] item in
                let model = EventModel(model: item)
                self?.goToEvent(model)
            })
            .disposed(by: disposeBag)
    }
}
