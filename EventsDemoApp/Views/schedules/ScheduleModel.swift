//
//  ScheduleModel.swift
//  EventsDemoApp
//
//  Created by Edwin Weru on 05/08/2022.
//

import Foundation

struct ScheduleModel {
    let id: String
    let title: String
    let subtitle: String
    let date: String
    let imageUrl: String

    init(model: ScheduleResponse) {
        self.id = model.id
        self.title = model.title
        self.subtitle = model.subtitle
        self.date = model.date
        self.imageUrl = model.imageUrl
    }
}
