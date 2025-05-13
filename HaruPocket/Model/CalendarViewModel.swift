//
//  CalendarViewModel.swift
//  HaruPocket
//
//  Created by 윤혜주 on 5/13/25.
//

import Foundation
import SwiftUI

final class CalendarViewModel: ObservableObject {
    @Published var currentMonthOffset: Int = 0
    @Published var selectedDate: Date = Calendar.current.startOfDay(for: Date())

    private let calendar = Calendar.current
    var username: String

    init(username: String) {
        self.username = username
    }

    var currentDate: Date {
        calendar.date(byAdding: .month, value: currentMonthOffset, to: Date())
            ?? Date()
    }

    func entries(on date: Date, in allEntries: [BasicEntry]) -> [BasicEntry] {
        let target = calendar.startOfDay(for: date)
        return allEntries.filter {
            calendar.isDate($0.date, inSameDayAs: target) && $0.userID == username
        }
    }


    func monthFormatter(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }

    func isToday(_ date: Date) -> Bool {
        calendar.isDateInToday(date)
    }

    func isSameDay(_ date1: Date?, _ date2: Date?) -> Bool {
        guard let d1 = date1, let d2 = date2 else { return false }
        return calendar.isDate(d1, inSameDayAs: d2)
    }

    func isCurrentMonth(_ date: Date) -> Bool {
        calendar.isDate(date, equalTo: currentDate, toGranularity: .month)
    }

    func daysInMonth() -> [Date] {
        guard
            let range = calendar.range(of: .day, in: .month, for: currentDate),
            let firstDay = calendar.date(
                from: calendar.dateComponents(
                    [.year, .month],
                    from: currentDate
                )
            )
        else {
            return []
        }

        let weekdayOffset = calendar.component(.weekday, from: firstDay) - 1
        let dates: [Date] = (0..<(range.count + weekdayOffset)).compactMap {
            calendar.date(byAdding: .day, value: $0 - weekdayOffset, to: firstDay)
        }.map {
            calendar.startOfDay(for: $0)
        }

        return dates
    }

}
