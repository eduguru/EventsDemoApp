//
//  EventModel.swift
//  EventsDemoApp
//
//  Created by Edwin Weru on 05/08/2022.
//

import Foundation

struct EventModel {
    let id: String
    let title: String
    let subtitle: String
    let date: String
    let imageUrl: String
    let videoUrl: String

    init(model: EventsResponse) {
        self.id = model.id
        self.title = model.title
        self.subtitle = model.subtitle
        self.date = model.date
        self.imageUrl = model.imageUrl
        self.videoUrl = model.videoUrl
    }
}
