//
//  CartItemsViewModel.swift
//  AutoCarDemo
//
//  Created by Edwin Weru on 21/07/2022.
//

import Foundation
import RxSwift

class EventsViewModel {
    static let instance = EventsViewModel()

    var eventsSubject = BehaviorSubject<[EventsResponse]>(value: [])
    private let eventsService: EventsServices = .instance
    private let disposeBag = DisposeBag()

    init() {
        eventsService.getEvents()
            .asObservable()
            .subscribe(onNext: { [weak self] in
                self?.eventsSubject.onNext($0)
                print($0)
            }, onError: { [weak self] err in
                print("an error occured", err)
            })
            .disposed(by: disposeBag)
    }
}
