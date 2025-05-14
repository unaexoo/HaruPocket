//
//  Category+SampleData.swift
//  HaruPocket
//
//  Created by 장지현 on 5/13/25.
//

import Foundation
import SwiftUI

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
            Category(name: "카테고리 없음", color: Color(hexString: "#EBEBF0"), emoji: "❓", userID: "default_user"),
        ]
    }
}
