//
//  EventsResponse.swift
//  EventsDemoApp
//
//  Created by Edwin Weru on 04/08/2022.
//

import Foundation

struct EventsResponse: Codable {
    let id: String
    let title: String
    let subtitle: String
    let date: String
    let imageUrl: String
    let videoUrl: String
}
