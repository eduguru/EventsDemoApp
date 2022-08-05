//
//  Date.swift
//  KuneFood
//
//  Created by Edwin Weru on 08/02/2022.
//

import UIKit

extension Date {
    func timeAgoDisplay() -> String {
        let calendar = Calendar.current
        let minuteAgo = calendar.date(byAdding: .minute, value: -1, to: Date())!
        let hourAgo = calendar.date(byAdding: .hour, value: -1, to: Date())!
        let dayAgo = calendar.date(byAdding: .day, value: -1, to: Date())!
        let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date())!

        if minuteAgo < self {
            let diff = Calendar.current.dateComponents([.second], from: self, to: Date()).second ?? 0
            if diff == 1 {
                return "1 sec ago"
            } else {
                return "\(diff) secs ago"
            }
        } else if hourAgo < self {
            let diff = Calendar.current.dateComponents([.minute], from: self, to: Date()).minute ?? 0
            if diff == 1 {
                return "1 min ago"
            } else {
                return "\(diff) mins ago"
            }
        } else if dayAgo < self {
            let diff = Calendar.current.dateComponents([.hour], from: self, to: Date()).hour ?? 0
            if diff == 1 {
                return "1 hr ago"
            } else {
                return "\(diff) hrs ago"
            }
        } else if weekAgo < self {
            let diff = Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
            if diff == 1 {
                return "Yesterday"
            } else {
                return "\(diff) days ago"
            }
        }

        let diff = Calendar.current.dateComponents([.weekOfYear], from: self, to: Date()).weekOfYear ?? 0
        if diff == 1 {
            return "1 week ago"

        } else if diff > 4 {
            let presentFormatter = DateFormatter()
            presentFormatter.dateFormat = "MMMM dd"
            return presentFormatter.string(from: self)

        } else {
            return "\(diff) weeks ago"
        }
    }
}

extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow: Date { return Date().dayAfter }

//    var dayBefore: Date {
//        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
//    }
//    var dayAfter: Date {
//        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
//    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }

    var month: Int {
        return Calendar.current.component(.month, from: self)
    }

    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }

    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }

    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
}

// Now you can access these variables like so:
// let tomorrow = Date().dayAfter
// let yesterday = Date().dayBefore
