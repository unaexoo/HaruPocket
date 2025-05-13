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

