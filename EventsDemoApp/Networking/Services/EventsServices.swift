//
//  EventsServices.swift
//  EventsDemoApp
//
//  Created by Edwin Weru on 04/08/2022.
//

import Foundation
import Moya
import RxSwift

protocol EventsServicesImpl {
    func getEvents() -> Observable<[EventsResponse]>
}

class EventsServices: EventsServicesImpl {
    static let instance = EventsServices()

    func getEvents() -> Observable<[EventsResponse]> {
        let provider = MoyaProvider<EventsApi>()

        return Observable<[EventsResponse]>.create { observer in

            provider.request(.getEvents) { result in
                switch result {
                case let .success(response):
                    let data: String = .init(data: response.data, encoding: .utf8) ?? ""
                    let decoder = JSONDecoder()
                    let jsonData: Data = .init(data.utf8)

                    do {
                        let responseObject = try decoder.decode([EventsResponse].self, from: jsonData)

                        observer.onNext(responseObject)
                        observer.onCompleted()
                    } catch {
                        print(error.localizedDescription)
                        observer.onError(error)
                    }

                case let .failure(error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
