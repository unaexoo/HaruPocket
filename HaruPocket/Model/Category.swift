//
//  Category.swift
//  HaruPocket
//
//  Created by 윤혜주 on 5/12/25.
//

import SwiftData
import SwiftUI
import UIKit

/// `Category`는 소비 일기 항목이 속하는 카테고리를 정의하는 SwiftData 모델입니다.
/// - 이름, 색상, 이모지, 사용자 ID 등을 저장합니다.
/// - `BasicEntry`와의 1:N 관계를 가집니다.
@Model
class Category {

    /// 카테고리의 고유 식별자입니다.
    @Attribute(.unique) var id: UUID

    /// 카테고리 이름입니다. (예: "식비", "교통비")
    var name: String

    /// 색상을 HEX 문자열로 저장한 값입니다. 내부에서만 사용됩니다.
    private var colorHex: String

    /// 카테고리를 표현하는 이모지입니다.
    var emoji: String

    /// 사용자 고유 ID입니다. 사용자별로 카테고리를 분리 저장합니다.
    var userID: String

    /// 해당 카테고리에 연결된 소비 일기 배열입니다. (1:N 관계)
    /// - 삭제 규칙: 카테고리가 삭제되면 연결된 소비 일기도 함께 삭제됩니다.
    @Relationship(deleteRule: .cascade, inverse: \BasicEntry.category)
    var diary: [BasicEntry] = []

    /// 카테고리 모델 생성자입니다.
    /// - Parameters:
    ///   - id: UUID (기본값은 자동 생성)
    ///   - name: 카테고리 이름
    ///   - color: SwiftUI의 Color 값
    ///   - emoji: 이모지 문자열
    ///   - userID: 사용자 ID
    init(
        id: UUID = UUID(),
        name: String,
        color: Color,
        emoji: String,
        userID: String
    ) {
        self.id = id
        self.name = name
        self.colorHex = color.toHex() ?? "#000000"
        self.emoji = emoji
        self.userID = userID
    }

    /// SwiftUI `Color` 타입으로 변환된 카테고리 색상입니다.
    /// - 저장은 `colorHex`로 수행되고, 불러올 때는 변환하여 제공합니다.
    /// - `.Transient` 속성으로 저장소에 직접 저장되지 않습니다.
    @Transient
    var color: Color {
        get { Color(hexString: colorHex) }
        set { colorHex = newValue.toHex() ?? "#000000" }
    }
}
