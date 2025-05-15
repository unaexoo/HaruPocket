//
//  StaticsViewModel.swift
//  HaruPocket
//
//  Created by 장지현 on 5/13/25.
//

import Foundation
import SwiftUI
import SwiftData

class StatisticsViewModel: ObservableObject {
    private var allEntries: [BasicEntry] = []

    init(entries: [BasicEntry]) {
        self.allEntries = entries
    }

    func totalMoneyForMonth(month: String) -> Int {
        let filteredEntries = allEntries.filter { entry in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM"
            let entryMonth = dateFormatter.string(from: entry.date)
            return entryMonth == month
        }

        return filteredEntries.reduce(0) { $0 + $1.money }
    }

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

