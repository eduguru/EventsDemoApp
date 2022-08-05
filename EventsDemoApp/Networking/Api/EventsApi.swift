//
//  EventsApi.swift
//  EventsDemoApp
//
//  Created by Edwin Weru on 04/08/2022.
//

import Moya

enum EventsApi {
    case getEvents
}

extension EventsApi: TargetType {
    var baseURL: URL {
        let url = URL(string: Contants.instance.base_url)!

        return url
    }

    var path: String {
        return "getEvents"
    }

    var method: Method {
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
