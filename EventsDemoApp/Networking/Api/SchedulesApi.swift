//
//  SchedulesApi.swift
//  EventsDemoApp
//
//  Created by Edwin Weru on 05/08/2022.
//

import Foundation
import Moya

enum SchedulesApi {
    case getSchedules
}

extension SchedulesApi: TargetType {
    var baseURL: URL {
        let url = URL(string: Contants.instance.base_url)!

        return url
    }

    var path: String {
        return "getSchedule"
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        return .requestParameters(parameters: [:], encoding: URLEncoding.default)
    }

    var headers: [String: String]? {
        let headers: [String: String] = [:]

        return headers
    }

    var validationType: ValidationType {
        return .successAndRedirectCodes
    }
}
