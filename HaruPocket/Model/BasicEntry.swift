//
//  BasicEntry.swift
//  HaruPocket
//
//  Created by 윤혜주 on 5/12/25.
//

import Foundation
import SwiftData
import SwiftUI

/// 기본 데이터들에 대한 데이터베이스 설정입니다. 소비 일기의 제목, 내용, 작성일, 소비 금액, 이미지를 저장합니다. 
@Model
class BasicEntry {
    @Attribute(.unique) var id: UUID
    var title: String
    var content: String?
    var date: Date
    var money: Int
    var imageBase64: String?  // SwiftData는 Data 저장 불가 → Base64 문자열

    @Relationship var category: Category?  // N:1 관계

    init(
        id: UUID = UUID(),
        title: String,
        content: String? = nil,
        date: Date = Date(),
        money: Int,
        imageData: Data? = nil,
        category: Category? = nil
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.date = date
        self.money = money
        self.imageBase64 = imageData?.base64EncodedString()
        self.category = category
    }

    var imageData: Data? {
        imageBase64.flatMap { Data(base64Encoded: $0) }
    }
}

