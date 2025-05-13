//
//  Statics.swift
//  HaruPocket
//
//  Created by 윤혜주 on 5/12/25.
//

import Foundation
import SwiftUI
import SwiftData

/// 통계에 대한 데이터베이스입니다. 통계 소비건수, 소비액 등을 저장합니다. 
@Model
class Statics {
    @Attribute(.unique) var id: UUID
    var userID: String
    var categoryName: String
    private var colorHex: String
    var totalAmount: Int
    var categoryAmount: Int
    var categoryCount: Int

    var color: Color {
        get { Color(colorHex) }
        set { colorHex = newValue.toHex() ?? "#000000" }
    }

    init(
        id: UUID = UUID(),
        userID: String,
        categoryName: String,
        color: Color,
        totalAmount: Int = 0,
        categoryAmount: Int = 0,
        categoryCount: Int = 0
    ) {
        self.id = id
        self.userID = userID
        self.categoryName = categoryName
        self.colorHex = color.toHex() ?? "#000000"
        self.totalAmount = totalAmount
        self.categoryAmount = categoryAmount
        self.categoryCount = categoryCount
    }
}

extension Statics {
    static func fetchOrCreate(
        context: ModelContext,
        userID: String,
        categoryName: String,
        categoryColor: Color
    ) -> Statics {
        let descriptor = FetchDescriptor<Statics>(
            predicate: #Predicate {
                $0.userID == userID && $0.categoryName == categoryName
            }
        )

        if let existing = try? context.fetch(descriptor).first {
            return existing
        } else {
            let newStat = Statics(
                userID: userID,
                categoryName: categoryName,
                color: categoryColor
            )
            context.insert(newStat)
            return newStat
        }
    }

    func updateWith(entry: BasicEntry) {
        categoryAmount += entry.money
        categoryCount += 1
        totalAmount += entry.money
    }

    func removeEntry(_ entry: BasicEntry) {
        categoryAmount -= entry.money
        categoryCount = max(categoryCount - 1, 0)
        totalAmount = max(totalAmount - entry.money, 0)
    }
}
