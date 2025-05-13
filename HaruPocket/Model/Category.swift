//
//  Category.swift
//  HaruPocket
//
//  Created by 윤혜주 on 5/12/25.
//

import SwiftUI
import SwiftData
import UIKit

/// 카테고리 데이터베이스입니다. 카테고리의 이름, 색상, 이모지 등의 데이터를 저장합니다.
@Model
class Category {
    @Attribute(.unique) var id: UUID
    var name: String
    private var colorHex: String
    var emoji: String
    var userID: String
    @Relationship(deleteRule: .cascade, inverse: \BasicEntry.category) var diary: [BasicEntry] = []

    init(id: UUID = UUID(), name: String, color: Color, emoji: String, userID: String) {
        self.id = id
        self.name = name
        self.colorHex = color.toHex() ?? "#000000"
        self.emoji = emoji
        self.userID = userID
    }

    var color: Color {
        get { Color(colorHex) }
        set { colorHex = newValue.toHex() ?? "#000000" }
    }
}

extension Category {
    static var sampleList: [Category] {
        return [
            Category(name: "음식", color: Color(hexString: "#FFB871"), emoji: "🍙", userID: "default_user"),
            Category(name: "교통", color: Color(hexString: "#3A4F7A"), emoji: "🚌", userID: "default_user"),
            Category(name: "문화생활", color: Color(hexString: "#A66DD4"), emoji: "🎬", userID: "default_user"),
            Category(name: "쇼핑", color: Color(hexString: "#2A936D"), emoji: "🛍️", userID: "default_user"),
            Category(name: "여행", color: Color(hexString: "#89E3D0"), emoji: "✈️", userID: "default_user"),
            Category(name: "건강", color: Color(hexString: "#FF9AA2"), emoji: "💊", userID: "default_user"),
            Category(name: "공부", color: Color(hexString: "#4B0082"), emoji: "📚", userID: "default_user"),
            Category(name: "선물", color: Color(hexString: "#FDD835"), emoji: "🎁", userID: "default_user"),
            Category(name: "운동", color: Color(hexString: "#00C853"), emoji: "🏋️‍♀️", userID: "default_user"),
            Category(name: "반려동물", color: Color(hexString: "#FFAB91"), emoji: "🐶", userID: "default_user"),
            Category(name: "카테고리 없음", color: Color(hexString: "#A040A0"), emoji: "❓", userID: "default_user"),
        ]
    }
}
