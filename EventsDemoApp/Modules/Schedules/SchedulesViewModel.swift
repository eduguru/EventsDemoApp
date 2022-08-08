//
//  SchedulesViewModel.swift
//  EventsDemoApp
//
//  Created by Edwin Weru on 04/08/2022.
//

import Foundation
import RxRelay
import RxSwift

class SchedulesViewModel {
    static let instance = SchedulesViewModel()

    var scheduleSubject = BehaviorRelay<[ScheduleResponse]>(value: [])
    private let schedulesServices: SchedulesServices = .instance
    private let disposeBag = DisposeBag()

    var timer: Timer?

    init() {
        timer = Timer.scheduledTimer(timeInterval: 30.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
        getSchedules()
    }

    @objc func fireTimer() {
        print("Timer fired!")
        getSchedules()
    }

    private func getSchedules() {
        schedulesServices.getSchedules()
            .asObservable()
            .subscribe(onNext: { [weak self] in
                self?.scheduleSubject.accept($0)
                print($0)
            }, onError: { [weak self] err in
                print("an error occured", err)
            })
            .disposed(by: disposeBag)
    }

    deinit {
        print("deinit")
        invalidateTimer()
    }

    func invalidateTimer() {
        timer?.invalidate()
    }
}
