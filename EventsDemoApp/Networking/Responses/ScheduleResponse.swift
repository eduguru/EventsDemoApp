//
//  ScheduleResponse.swift
//  EventsDemoApp
//
//  Created by Edwin Weru on 05/08/2022.
//

import Foundation

struct ScheduleResponse: Codable {
    let id: String
    let title: String
    let subtitle: String
    let date: String
    let imageUrl: String
}
