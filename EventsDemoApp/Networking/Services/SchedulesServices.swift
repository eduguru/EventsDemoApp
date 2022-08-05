//
//  SchedulesServices.swift
//  EventsDemoApp
//
//  Created by Edwin Weru on 05/08/2022.
//

import Foundation
import Moya
import RxSwift

protocol SchedulesServicesImpl {
    func getSchedules() -> Observable<[ScheduleResponse]>
}

class SchedulesServices: SchedulesServicesImpl {
    static let instance = SchedulesServices()

    func getSchedules() -> Observable<[ScheduleResponse]> {
        let provider = MoyaProvider<SchedulesApi>()

        return Observable<[ScheduleResponse]>.create { observer in

            provider.request(.getSchedules) { result in
                switch result {
                case let .success(response):
                    let data: String = .init(data: response.data, encoding: .utf8) ?? ""
                    let decoder = JSONDecoder()
                    let jsonData: Data = .init(data.utf8)

                    do {
                        let responseObject = try decoder.decode([ScheduleResponse].self, from: jsonData)

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
