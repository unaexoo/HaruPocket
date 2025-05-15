//
//  StaticsViewModel.swift
//  HaruPocket
//
//  Created by 장지현 on 5/13/25.
//

import Foundation
import SwiftUI
import SwiftData

/// 뷰에서 사용하는 통계 관련 데이터를 처리하는 뷰모델 클래스입니다.
class StatisticsViewModel: ObservableObject {
    private var allEntries: [BasicEntry] = []

    /// 초기화 메서드로, 모든 소비 항목을 받아 저장합니다.
    /// - Parameter entries: 모든 소비 항목 리스트
    init(entries: [BasicEntry]) {
        self.allEntries = entries
    }

    /// 특정 월에 대한 전체 소비 금액을 계산합니다.
    /// - Parameter month: 계산할 월 (형식: "yyyy-MM")
    /// - Returns: 해당 월의 전체 소비 금액 합계
    func totalMoneyForMonth(month: String) -> Int {
        let filteredEntries = allEntries.filter { entry in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM"
            let entryMonth = dateFormatter.string(from: entry.date)
            return entryMonth == month
        }

        return filteredEntries.reduce(0) { $0 + $1.money }
    }

    /// 특정 월에 대한 카테고리별 소비 항목을 분석하여,
    /// 가장 많이 등장한 상위 5개 카테고리(top5ByCount)와
    /// 가장 많은 금액을 사용한 상위 5개 카테고리(top5ByMoney)를 반환합니다.
    /// - Parameter month: 분석할 월 (형식: "yyyy-MM")
    /// - Returns: 카테고리 이름과 관련 데이터(count, money, color)의 튜플 목록
    func entriesByCategoryForMonth(month: String)
    -> (top5ByCount: [(String, (count: Int, money: Int, color: Color))],
        top5ByMoney: [(String, (count: Int, money: Int, color: Color))]
    ) {
        let filteredEntries = allEntries.filter { entry in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM"
            let entryMonth = dateFormatter.string(from: entry.date)
            return entryMonth == month
        }

        var categorySummary: [String: (count: Int, money: Int, color: Color)] = [:]

        for entry in filteredEntries {
            guard let category = entry.category else { continue }

            let categoryName = category.name // assuming Category has a name property
            if categorySummary[categoryName] == nil {
                categorySummary[categoryName] = (count: 0, money: 0, color: category.color)
            }

            if var current = categorySummary[categoryName] {
                current.count += 1
                current.money += entry.money
                categorySummary[categoryName] = current
            }
        }

        return summarizeCategoryData(from: categorySummary)
    }

    /// 카테고리별 요약 데이터를 받아 상위 5개 카테고리를 두 가지 기준(횟수, 금액)으로 정렬하여 반환합니다.
    /// - Parameter categorySummary: 카테고리 이름을 키로, 해당 카테고리의 소비 횟수, 금액, 색상을 값으로 갖는 딕셔너리
    /// - Returns: 횟수 기준 상위 5개 카테고리와 금액 기준 상위 5개 카테고리 튜플
    func summarizeCategoryData(from categorySummary: [String: (count: Int, money: Int, color: Color)])
    -> (top5ByCount: [(String, (count: Int, money: Int, color: Color))],
        top5ByMoney: [(String, (count: Int, money: Int, color: Color))]
    ) {
        let sortedByCount = categorySummary.sorted {
            if $0.value.count != $1.value.count {
                return $0.value.count > $1.value.count
            } else {
                return $0.value.money > $1.value.money
            }
        }

        let sortedByMoney = categorySummary.sorted {
            $0.value.money > $1.value.money
        }

        let top5ByCount = sortedByCount.prefix(5)
        let top5ByMoney = sortedByMoney.prefix(5)


        return (Array(top5ByCount), Array(top5ByMoney))
    }
}
