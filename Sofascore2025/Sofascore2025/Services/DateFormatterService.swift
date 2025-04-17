//
//  DateFormatterService.swift
//  Sofascore2025
//
//  Created by Mario Brezovečki on 12.03.2025..
//

import Foundation

enum DateFormatterService {

    private static var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }()

    private static var fullDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy."
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter
    }()

    static func fullDateFormatted(_ timeStamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timeStamp))
        return fullDateFormatter.string(from: date)
    }

    static func timeFormatted(_ timeStamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(timeStamp))
        return dateFormatter.string(from: date)
    }

    static func timeRemaining(_ timeStamp: Int) -> String {
        let startingTime = TimeInterval(timeStamp)
        let currentTime = Date().timeIntervalSince1970
        let minutesDifference = (currentTime - startingTime) / 60
        return String(format: "%.0f", minutesDifference) + "′"
    }
}
