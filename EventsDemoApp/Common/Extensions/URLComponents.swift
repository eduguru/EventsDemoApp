//
//  URLComponents.swift
//  Little Agent
//
//  Created by edwin weru on 22/06/2021.
//

import Foundation

extension URLComponents {
    mutating func setQueryItems(with parameters: [String: String]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
    }

//    mutating func setQueryItems(with parameters: [String: String]) {
//        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
//    }
}

extension URL {
    func params() -> [String: Any] {
        var dict = [String: Any]()

        if let components = URLComponents(url: self, resolvingAgainstBaseURL: false) {
            if let queryItems = components.queryItems {
                for item in queryItems {
                    dict[item.name] = item.value!
                }
            }
            return dict
        } else {
            return [:]
        }
    }
}
