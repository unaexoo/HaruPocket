//
//  CalendarViewModel.swift
//  HaruPocket
//
//  Created by 윤혜주 on 5/13/25.
//

import Foundation
import SwiftUI

/// `CalendarViewModel`은 달력 관련 로직을 관리하는 뷰 모델입니다.
/// - 현재 월 오프셋, 선택된 날짜, 날짜 비교, 월 이동, 날짜 포맷 등의 기능을 제공합니다.
/// - 사용자 ID를 기준으로 날짜별 소비 내역 필터링 기능도 포함되어 있습니다.
final class CalendarViewModel: ObservableObject {
    /// 기준 월에서 몇 개월 떨어져 있는지를 나타냅니다. (0이면 현재 월)
    @Published var currentMonthOffset: Int = 0

    /// 현재 선택된 날짜입니다. 기본값은 오늘 날짜의 시작 시점입니다.
    @Published var selectedDate: Date = Calendar.current.startOfDay(for: Date())

    /// 내부 달력 객체입니다. 기본값은 시스템 달력입니다.
    private let calendar = Calendar.current

    /// 사용자 고유 식별자 (userID)
    var username: String

    /// 생성자에서 사용자 이름을 받아 초기화합니다.
    init(username: String) {
        self.username = username
    }

    /// 현재 월에 해당하는 날짜를 반환합니다.
    var currentDate: Date {
        calendar.date(byAdding: .month, value: currentMonthOffset, to: Date())
            ?? Date()
    }

    /// 주어진 날짜에 해당하는 사용자 소비 내역을 필터링합니다.
    /// - Parameters:
    ///   - date: 검색할 날짜
    ///   - allEntries: 전체 소비 일기 배열
    /// - Returns: 해당 날짜에 기록된 소비 일기 리스트
    func entries(on date: Date, in allEntries: [BasicEntry]) -> [BasicEntry] {
        let target = calendar.startOfDay(for: date)
        return allEntries.filter {
            calendar.isDate($0.date, inSameDayAs: target)
                && $0.userID == username
        }
    }

    /// 특정 날짜의 월 시작 날짜를 반환합니다.
    /// - Parameter date: 기준 날짜
    /// - Returns: 해당 월의 1일 날짜
    func startOfMonth(for date: Date) -> Date {
        calendar.date(
            from: calendar.dateComponents([.year, .month], from: date)
        ) ?? date
    }

    /// 지정된 날짜로 월을 이동합니다.
    /// - Parameter date: 이동할 날짜
    func move(to date: Date) {
        let current = currentDate
        let target = startOfMonth(for: date)

        let components = calendar.dateComponents(
            [.month],
            from: startOfMonth(for: current),
            to: target
        )
        currentMonthOffset += components.month ?? 0
    }

    /// 월 이름을 "M월" 형식으로 포맷팅하여 문자열로 반환합니다.
    /// - Parameter date: 포맷할 날짜
    /// - Returns: "5월"과 같은 문자열
    func monthFormatter(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }

    /// 해당 날짜가 오늘인지 확인합니다.
    /// - Parameter date: 확인할 날짜
    /// - Returns: 오늘이면 true, 아니면 false
    func isToday(_ date: Date) -> Bool {
        calendar.isDateInToday(date)
    }

    /// 두 날짜가 같은 날인지 비교합니다.
    /// - Parameters:
    ///   - date1: 비교할 첫 번째 날짜
    ///   - date2: 비교할 두 번째 날짜
    /// - Returns: 동일한 날짜이면 true, 아니면 false
    func isSameDay(_ date1: Date?, _ date2: Date?) -> Bool {
        guard let d1 = date1, let d2 = date2 else { return false }
        return calendar.isDate(d1, inSameDayAs: d2)
    }

    /// 주어진 날짜가 현재 월에 해당하는지 확인합니다.
    /// - Parameter date: 비교할 날짜
    /// - Returns: 현재 월이면 true
    func isCurrentMonth(_ date: Date) -> Bool {
        calendar.isDate(date, equalTo: currentDate, toGranularity: .month)
    }

    /// 현재 월에 표시할 모든 날짜 배열을 생성합니다.
    /// - 이전 월의 공백 날짜까지 포함하여 일요일 시작 기준으로 정렬합니다.
    /// - Returns: 날짜 배열 (Date 타입)
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
            calendar.date(
                byAdding: .day,
                value: $0 - weekdayOffset,
                to: firstDay
            )
        }.map {
            calendar.startOfDay(for: $0)
        }

        return dates
    }

}
