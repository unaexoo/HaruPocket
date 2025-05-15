//
//  BasicEntry.swift
//  HaruPocket
//
//  Created by 윤혜주 on 5/12/25.
//

import Foundation
import SwiftData
import SwiftUI

/// `BasicEntry`는 소비 일기의 단일 항목을 나타내는 SwiftData 모델입니다.
/// - 소비 내역의 제목, 내용, 작성일, 소비 금액, 이미지 경로, 사용자 ID, 카테고리 정보를 저장합니다.
@Model
class BasicEntry {

    /// 각 항목을 고유하게 식별하는 UUID입니다.
    @Attribute(.unique) var id: UUID

    /// 소비 내역의 제목입니다.
    var title: String

    /// 소비 내용에 대한 설명 또는 메모입니다. (선택 사항)
    var content: String?

    /// 소비가 이루어진 날짜입니다.
    var date: Date

    /// 소비 금액입니다.
    var money: Int

    /// 이미지 파일의 이름 또는 경로입니다. (선택 사항)
    var imageFileName: String?

    /// 이 데이터를 작성한 사용자 ID입니다.
    var userID: String

    /// 소비가 속한 카테고리입니다. (N:1 관계, 선택적)
    @Relationship var category: Category?

    /// 기본 생성자입니다.
    /// - Parameters:
    ///   - id: UUID, 기본값은 새 UUID
    ///   - title: 소비 제목
    ///   - content: 소비 내용 (선택)
    ///   - date: 소비 날짜, 기본값은 현재 날짜
    ///   - money: 소비 금액
    ///   - imageFileName: 이미지 파일 경로 (선택)
    ///   - userID: 사용자 ID
    ///   - category: 연결된 카테고리 객체 (선택)
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

    /// 이미지 파일 경로(`imageFileName`)를 기반으로 이미지를 불러옵니다.
    /// - 문서 디렉토리에 있는 사용자 저장 이미지 또는 번들 리소스 이미지까지 탐색합니다.
    var image: UIImage? {
        guard let imageFileName else { return nil }

        // 1. 사용자 문서 디렉토리에서 로드
        let documentsURL = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        )[0]
        let fileURL = documentsURL.appendingPathComponent(imageFileName)

        if FileManager.default.fileExists(atPath: fileURL.path),
            let documentImage = UIImage(contentsOfFile: fileURL.path)
        {
            return documentImage
        }

        // 2. 번들 리소스 내 이미지 확인
        let pathComponents = imageFileName.split(separator: "/").map {
            String($0)
        }
        guard pathComponents.count == 2 else { return nil }

        let subdirectory = pathComponents[0]
        let fileNameWithExtension = pathComponents[1]

        let nameComponents = fileNameWithExtension.split(separator: ".")
        guard nameComponents.count == 2 else { return nil }

        let name = String(nameComponents[0])
        let ext = String(nameComponents[1])

        if let url = Bundle.main.url(
            forResource: name,
            withExtension: ext,
            subdirectory: subdirectory
        ) {
            return UIImage(contentsOfFile: url.path)
        } else {
            return nil
        }
    }
}
