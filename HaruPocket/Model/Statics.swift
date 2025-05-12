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
    var name: String
    private var colorHex: String
    var totalAmount: Int
    var categoryAmount: Int
    var categoryCount: Int

    var color: Color {
        get { Color(hexString: colorHex) }
        set { colorHex = newValue.toHex() ?? "#000000" }
    }

    init(
        id: UUID = UUID(),
        name: String,
        color: Color,
        totalAmount: Int,
        categoryAmount: Int,
        categoryCount: Int,
    ) {
        self.id = id
        self.name = name
        self.colorHex = color.toHex() ?? "#000000"
        self.totalAmount = totalAmount
        self.categoryAmount = categoryAmount
        self.categoryCount = categoryCount
    }
}
