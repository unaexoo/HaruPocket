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
    var imageFileName: String?
    var userID: String
    @Relationship var category: Category?  // N:1 관계

    init(
        id: UUID = UUID(),
        title: String,
        content: String? = nil,
        date: Date = Date(),
        money: Int,
        imageFileName: String? = nil,
        userID: String,
        category: Category? = nil
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.date = date
        self.money = money
        self.imageFileName = imageFileName
        self.userID = userID
        self.category = category
    }

    var image: UIImage? {
        guard let imageFileName else { return nil }

        let pathComponents = imageFileName.split(separator: "/").map { String($0) }
        guard pathComponents.count == 2 else { return nil }

        let subdirectory = pathComponents[0]
        let fileNameWithExtension = pathComponents[1]

        let nameComponents = fileNameWithExtension.split(separator: ".")
        guard nameComponents.count == 2 else { return nil }

        let name = String(nameComponents[0])
        let ext = String(nameComponents[1])

        if let url = Bundle.main.url(forResource: name, withExtension: ext, subdirectory: subdirectory) {
            return UIImage(contentsOfFile: url.path)
        } else {
            return nil
        }
    }
}
