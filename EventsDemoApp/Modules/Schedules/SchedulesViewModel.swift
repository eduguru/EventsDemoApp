//
//  SchedulesViewModel.swift
//  EventsDemoApp
//
//  Created by Edwin Weru on 04/08/2022.
//

import Foundation
import RxSwift

class SchedulesViewModel {
    static let instance = SchedulesViewModel()

    var scheduleSubject = BehaviorSubject<[ScheduleResponse]>(value: [])
    private let schedulesServices: SchedulesServices = .instance
    private let disposeBag = DisposeBag()

    init() {
        schedulesServices.getSchedules()
            .asObservable()
            .subscribe(onNext: { [weak self] in
                self?.scheduleSubject.onNext($0)
                print($0)
            }, onError: { [weak self] err in
                print("an error occured", err)
            })
            .disposed(by: disposeBag)
    }

    deinit {
        print("deinit")
    }
}
