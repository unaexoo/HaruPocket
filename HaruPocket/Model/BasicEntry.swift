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
    var userID: String
    @Relationship var category: Category?  // N:1 관계

    init(
        id: UUID = UUID(),
        title: String,
        content: String? = nil,
        date: Date = Date(),
        money: Int,
        imageData: Data? = nil,
        userID: String,
        category: Category? = nil
    ) {
        self.id = id
        self.title = title
        self.content = content
        self.date = date
        self.money = money
        self.imageBase64 = imageData?.base64EncodedString()
        self.userID = userID
        self.category = category
    }

    var imageData: Data? {
        imageBase64.flatMap { Data(base64Encoded: $0) }
    }
}

extension BasicEntry {
    static func date(_ string: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.date(from: string) ?? Date()
    }

    static func sampleList(for userID: String, in context: ModelContext) async throws -> [BasicEntry] {
        let descriptor = FetchDescriptor<Category>(
            predicate: #Predicate { $0.userID == userID }
        )
        let categories = try context.fetch(descriptor)

        func category(named name: String) -> Category? {
            categories.first { $0.name == name }
        }

        return [
            BasicEntry(
                title: "스타벅스 아메리카노",
                content: "오늘은 무려 스타벅스 아아메를 마셨다.",
                date: date("2025-04-01"),
                money: 4500,
                userID: userID,
                category: category(named: "음식")
            ),
            BasicEntry(
                title: "어벤져스 영화 관람",
                content: "혼자 조조로 봤다",
                date: date("2025-04-03"),
                money: 12000,
                userID: userID,
                category: category(named: "문화생활")
            ),
            BasicEntry(
                title: "무신사 쇼핑",
                content: "봄 점퍼 구매",
                date: date("2025-04-03"),
                money: 89000,
                userID: userID,
                category: category(named: "쇼핑")
            ),
            BasicEntry(
                title: "부산 여행 기차표",
                content: "KTX 왕복 예매",
                date: date("2025-04-05"),
                money: 118000,
                userID: userID,
                category: category(named: "여행")
            ),
            BasicEntry(
                title: "부산 여행 숙소",
                content: "부산 숙소 예약",
                date: date("2025-04-05"),
                money: 300000,
                userID: userID,
                category: category(named: "여행")
            ),
            BasicEntry(
                title: "건강검진 병원 예약",
                content: "종합검진 예약금",
                date: date("2025-04-06"),
                money: 30000,
                userID: userID,
                category: category(named: "건강")
            ),
            BasicEntry(
                title: "Swift 공부 책 구입",
                content: "iOS 앱 개발 입문서",
                date: date("2025-04-07"),
                money: 28000,
                userID: userID,
                category: category(named: "공부")
            ),
            BasicEntry(
                title: "친구 생일 선물",
                content: "캔들 + 손편지",
                date: date("2025-04-08"),
                money: 22000,
                userID: userID,
                category: category(named: "선물")
            ),
            BasicEntry(
                title: "헬스장 등록",
                content: "1개월 등록",
                date: date("2025-04-09"),
                money: 60000,
                userID: userID,
                category: category(named: "운동")
            ),
            BasicEntry(
                title: "강아지 사료 구매",
                content: "로얄캐닌 사료",
                date: date("2025-04-10"),
                money: 34000,
                userID: userID,
                category: category(named: "반려동물")
            ),
            BasicEntry(
                title: "투썸 복숭아케이크",
                content: "회사 팀원이 생일파티",
                date: date("2025-05-01"),
                money: 38000,
                imageData: nil,
                userID: "default_user",
                category: category(named: "음식")
            ),
            BasicEntry(
                title: "조카 선물",
                content: "하츄핑을 사줬다",
                date: date("2025-05-05"),
                money: 50000,
                imageData: nil,
                userID: "default_user",
                category: category(named: "선물")
            ),
            BasicEntry(
                title: "어버이날 선물",
                content: "안마기를 사드렸다.",
                date: date("2025-05-08"),
                money: 200000,
                imageData: nil,
                userID: "default_user",
                category: category(named: "선물")
            ),
            BasicEntry(
                title: "스타벅스 아메리카노",
                content: "오늘은 무려 스타벅스 아아메를 마셨다.",
                date: date("2025-05-09"),
                money: 4500,
                imageData: nil,
                userID: "default_user",
                category: category(named: "음식")
            ),
            BasicEntry(
                title: "돈가스",
                content: "엄청 맛있다고 소문난 일식 돈가스를 먹었다.",
                date: date("2025-05-09"),
                money: 17000,
                imageData: nil,
                userID: "default_user",
                category: category(named: "음식")
            ),
            BasicEntry(
                title: "뮤지컬",
                content: "스트레스 받아서 뮤지컬을 예매했다, 무려 VVIP 좌석!",
                date: date("2025-05-09"),
                money: 180000,
                imageData: nil,
                userID: "default_user",
                category: category(named: "문화생활")
            ),
            BasicEntry(
                title: "뮤지컬 MD",
                content: nil,
                date: date("2025-05-09"),
                money: 40000,
                imageData: nil,
                userID: "default_user",
                category: category(named: "문화생활")
            ),
            BasicEntry(
                title: "립스틱",
                content: "백화점 갔다가 충동구매했다!",
                date: date("2025-05-10"),
                money: 55000,
                imageData: nil,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),
            BasicEntry(
                title: "더현대 디저트",
                content: "날씨가 좋아서 기분 좋았음.",
                date: date("2025-05-10"),
                money: 1300,
                imageData: nil,
                userID: "default_user",
                category: category(named: "음식")
            ),
            BasicEntry(
                title: "영화 관람",
                content: "드디어 보고 싶던 영화!",
                date: date("2025-05-12"),
                money: 12000,
                imageData: nil,
                userID: "default_user",
                category: category(named: "문화생활")
            ),
            BasicEntry(
                title: "바람막이",
                content: "아울렛에서 나이키 바람막이를 구매했다.",
                date: date("2025-05-13"),
                money: 69000,
                imageData: nil,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),
        ]
    }
}
