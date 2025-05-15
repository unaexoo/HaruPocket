//
//  BasicEntry+SampleData.swift
//  HaruPocket
//
//  Created by 장지현 on 5/13/25.
//

import Foundation
import SwiftUI
import SwiftData

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
                title: "브런치 카페",
                content: "친구들과 맛있는 브런치를 먹었다. 고마운게 많아서 내가 사줬다.",
                date: date("2025-01-01"),
                money: 69000,
                imageFileName: "SampleImage/brunch.jpg", userID: "default_user",
                category: category(named: "음식")
            ),

            BasicEntry(
                title: "서점 구경",
                content: "아침에 서점 구경갔다가 책을 구매했다.",
                date: date("2025-05-14"),
                money: 68900,
                imageFileName: "SampleImage/book.jpg", userID: "default_user",
                category: category(named: "문화생활")
            ),

            BasicEntry(
                title: "꽃다발",
                content: "지나가다 꽃을 보고 어머니가 생각나서 구매했다.",
                date: date("2025-05-14"),
                money: 59000,
                imageFileName: "SampleImage/flower.jpg", userID: "default_user",
                category: category(named: "선물")
            ),

            BasicEntry(
                title: "조카 선물",
                content: "조카에게 장난감 선물을 사줬다. 좋아하는 모습을 보니 기분이 좋다.",
                date: date("2025-05-15"),
                money: 49900,
                imageFileName: "SampleImage/gift.jpg", userID: "default_user",
                category: category(named: "선물")
            ),

            BasicEntry(
                title: "헬스장 등록",
                content: "건강관리를 시작하려고 헬스장 12개월을 결제했다. 꼭 자주 가야지!",
                date: date("2025-05-14"),
                money: 330000,
                imageFileName: "SampleImage/gym.jpg", userID: "default_user",
                category: category(named: "운동")
            ),

            BasicEntry(
                title: "뮤지컬",
                content: "보고싶었던 뮤지컬을 드디어 봤다!",
                date: date("2025-01-02"),
                money: 191600,
                imageFileName: "SampleImage/musical.jpg", userID: "default_user",
                category: category(named: "문화생활")
            ),

            BasicEntry(
                title: "전시회",
                content: "전시회 하면서 하루를 마무리했다. 문화생활 항목으로 기록!",
                date: date("2025-05-14"),
                money: 75900,
                imageFileName: "SampleImage/exhibition.jpg", userID: "default_user",
                category: category(named: "문화생활")
            ),

            BasicEntry(
                title: "신발 구매",
                content: "신발 구매 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-05-15"),
                money: 129000,
                imageFileName: "SampleImage/shopping.jpg", userID: "default_user",
                category: category(named: "쇼핑")
            ),

            BasicEntry(
                title: "저녁 치킨",
                content: "오늘 저녁은 치킨이닭!",
                date: date("2025-05-15"),
                money: 38000,
                imageFileName: "SampleImage/friedChicken.jpg", userID: "default_user",
                category: category(named: "음식")
            ),

            BasicEntry(
                title: "BBQ 치킨 파티",
                content: "BBQ 치킨 파티하면서 친구들과 좋은 시간을 보냈다.",
                date: date("2025-01-03"),
                money: 92000,
                imageFileName: "SampleImage/bbq.jpg", userID: "default_user",
                category: category(named: "음식")
            ),

            BasicEntry(
                title: "브런치 카페",
                content: "음식 관련으로 브런치 카페에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-04-16"),
                money: 69000,
                userID: "default_user",
                category: category(named: "음식")
            ),


            BasicEntry(
                title: "영화관람",
                content: "영화관람 하면서 하루를 마무리했다. 문화생활 항목으로 기록!",
                date: date("2025-03-07"),
                money: 18800,
                userID: "default_user",
                category: category(named: "문화생활")
            ),


            BasicEntry(
                title: "신발 구매",
                content: "신발 구매는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-03-14"),
                money: 191100,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),


            BasicEntry(
                title: "고양이 모래",
                content: "고양이 모래 하면서 하루를 마무리했다. 반려동물 항목으로 기록!",
                date: date("2025-01-04"),
                money: 37000,
                userID: "default_user",
                category: category(named: "반려동물")
            ),


            BasicEntry(
                title: "맛집 투어",
                content: "맛집 투어 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-04-22"),
                money: 14700,
                userID: "default_user",
                category: category(named: "여행")
            ),


            BasicEntry(
                title: "서점 구경",
                content: "아침부터 서점 구경 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-01-05"),
                money: 68900,
                userID: "default_user",
                category: category(named: "문화생활")
            ),


            BasicEntry(
                title: "호텔 예약",
                content: "여행 관련으로 호텔 예약에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-01-06"),
                money: 157900,
                userID: "default_user",
                category: category(named: "여행")
            ),


            BasicEntry(
                title: "뮤지컬",
                content: "뮤지컬는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-01-07"),
                money: 191600,
                userID: "default_user",
                category: category(named: "문화생활")
            ),


            BasicEntry(
                title: "기차 예매",
                content: "아침부터 기차 예매 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-01-08"),
                money: 41500,
                userID: "default_user",
                category: category(named: "교통")
            ),


            BasicEntry(
                title: "분식집 떡볶이",
                content: "아침부터 분식집 떡볶이 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-01-09"),
                money: 13700,
                userID: "default_user",
                category: category(named: "음식")
            ),


            BasicEntry(
                title: "편지지 구매",
                content: "편지지 구매 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-01-10"),
                money: 13700,
                userID: "default_user",
                category: category(named: "선물")
            ),


            BasicEntry(
                title: "기타 비용",
                content: "기타 비용 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-03-06"),
                money: 14000,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),


            BasicEntry(
                title: "옷 쇼핑",
                content: "옷 쇼핑 하면서 하루를 마무리했다. 쇼핑 항목으로 기록!",
                date: date("2025-04-30"),
                money: 247800,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),


            BasicEntry(
                title: "신발 구매",
                content: "신발 구매 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-01-10"),
                money: 10100,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),


            BasicEntry(
                title: "김밥천국 김밥",
                content: "아침부터 김밥천국 김밥 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-04-03"),
                money: 10600,
                userID: "default_user",
                category: category(named: "음식")
            ),


            BasicEntry(
                title: "PT 비용",
                content: "PT 비용는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-01-11"),
                money: 176800,
                userID: "default_user",
                category: category(named: "운동")
            ),


            BasicEntry(
                title: "장난감",
                content: "장난감 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-01-12"),
                money: 5600,
                userID: "default_user",
                category: category(named: "반려동물")
            ),


            BasicEntry(
                title: "강아지 사료",
                content: "강아지 사료 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-01-13"),
                money: 156800,
                userID: "default_user",
                category: category(named: "반려동물")
            ),


            BasicEntry(
                title: "미용비",
                content: "문득 미용비 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-01-14"),
                money: 170400,
                userID: "default_user",
                category: category(named: "반려동물")
            ),


            BasicEntry(
                title: "약국 구매",
                content: "오늘은 약국 구매에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-01-15"),
                money: 195100,
                userID: "default_user",
                category: category(named: "건강")
            ),


            BasicEntry(
                title: "현금 인출",
                content: "문득 현금 인출 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-01-16"),
                money: 151800,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),


            BasicEntry(
                title: "콘서트",
                content: "콘서트 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-03-27"),
                money: 103100,
                userID: "default_user",
                category: category(named: "문화생활")
            ),


            BasicEntry(
                title: "택시비",
                content: "오늘은 택시비에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-01-17"),
                money: 5900,
                userID: "default_user",
                category: category(named: "교통")
            ),


            BasicEntry(
                title: "예비비",
                content: "문득 예비비 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-01-18"),
                money: 14800,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),


            BasicEntry(
                title: "영화관람",
                content: "오늘은 영화관람에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-05-12"),
                money: 38400,
                userID: "default_user",
                category: category(named: "문화생활")
            ),


            BasicEntry(
                title: "뮤지컬",
                content: "뮤지컬 하면서 하루를 마무리했다. 문화생활 항목으로 기록!",
                date: date("2025-01-19"),
                money: 120400,
                userID: "default_user",
                category: category(named: "문화생활")
            ),


            BasicEntry(
                title: "저녁 치킨",
                content: "저녁 치킨 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-01-20"),
                money: 3443000,
                userID: "default_user",
                category: category(named: "음식")
            ),


            BasicEntry(
                title: "문구류 구매",
                content: "쇼핑 관련으로 문구류 구매에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-01-21"),
                money: 7000,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),


            BasicEntry(
                title: "호텔 예약",
                content: "문득 호텔 예약 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-05-06"),
                money: 187500,
                userID: "default_user",
                category: category(named: "여행")
            ),


            BasicEntry(
                title: "꽃다발",
                content: "문득 꽃다발 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-01-22"),
                money: 5900,
                userID: "default_user",
                category: category(named: "선물")
            ),


            BasicEntry(
                title: "현금 인출",
                content: "오늘은 현금 인출에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-05-02"),
                money: 145700,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),


            BasicEntry(
                title: "기념일 선물",
                content: "선물 관련으로 기념일 선물에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-01-23"),
                money: 1674000,
                userID: "default_user",
                category: category(named: "선물")
            ),


            BasicEntry(
                title: "헬스장 등록",
                content: "헬스장 등록 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-01-24"),
                money: 32300,
                userID: "default_user",
                category: category(named: "운동")
            ),


            BasicEntry(
                title: "전시회",
                content: "전시회 하면서 하루를 마무리했다. 문화생활 항목으로 기록!",
                date: date("2025-01-25"),
                money: 75900,
                userID: "default_user",
                category: category(named: "문화생활")
            ),


            BasicEntry(
                title: "도서 구매",
                content: "도서 구매 하면서 하루를 마무리했다. 공부 항목으로 기록!",
                date: date("2025-04-10"),
                money: 100900,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "관광지 입장료",
                content: "관광지 입장료 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-01-09"),
                money: 130700,
                userID: "default_user",
                category: category(named: "여행")
            ),


            BasicEntry(
                title: "지하철 요금",
                content: "지하철 요금 하면서 하루를 마무리했다. 교통 항목으로 기록!",
                date: date("2025-01-26"),
                money: 67400,
                userID: "default_user",
                category: category(named: "교통")
            ),


            BasicEntry(
                title: "비행기 예매",
                content: "문득 비행기 예매 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-03-30"),
                money: 315900,
                userID: "default_user",
                category: category(named: "여행")
            ),


            BasicEntry(
                title: "예비비",
                content: "문득 예비비 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-05-09"),
                money: 9000,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),


            BasicEntry(
                title: "요가 클래스",
                content: "운동 관련으로 요가 클래스에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-05-09"),
                money: 158400,
                userID: "default_user",
                category: category(named: "운동")
            ),


            BasicEntry(
                title: "꽃다발",
                content: "문득 꽃다발 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-01-27"),
                money: 13500,
                userID: "default_user",
                category: category(named: "선물")
            ),


            BasicEntry(
                title: "자격증 응시료",
                content: "아침부터 자격증 응시료 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-04-11"),
                money: 191800,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "꽃다발",
                content: "아침부터 꽃다발 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-03-09"),
                money: 6800,
                userID: "default_user",
                category: category(named: "선물")
            ),


            BasicEntry(
                title: "기차 예매",
                content: "오늘은 기차 예매에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-01-28"),
                money: 32700,
                userID: "default_user",
                category: category(named: "교통")
            ),


            BasicEntry(
                title: "저녁 치킨",
                content: "음식 관련으로 저녁 치킨에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-04-06"),
                money: 149400,
                userID: "default_user",
                category: category(named: "음식")
            ),


            BasicEntry(
                title: "자격증 응시료",
                content: "아침부터 자격증 응시료 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-01-16"),
                money: 45000,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "기념일 선물",
                content: "오늘은 기념일 선물에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-01-24"),
                money: 189400,
                userID: "default_user",
                category: category(named: "선물")
            ),


            BasicEntry(
                title: "김밥천국 김밥",
                content: "김밥천국 김밥 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-01-19"),
                money: 5200,
                userID: "default_user",
                category: category(named: "음식")
            ),


            BasicEntry(
                title: "비행기 예매",
                content: "비행기 예매 하면서 하루를 마무리했다. 여행 항목으로 기록!",
                date: date("2025-01-29"),
                money: 218700,
                userID: "default_user",
                category: category(named: "여행")
            ),


            BasicEntry(
                title: "예비비",
                content: "예비비는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-04-13"),
                money: 12900,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),


            BasicEntry(
                title: "편지지 구매",
                content: "문득 편지지 구매 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-05-05"),
                money: 8000,
                userID: "default_user",
                category: category(named: "선물")
            ),


            BasicEntry(
                title: "브런치 카페",
                content: "문득 브런치 카페 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-04-30"),
                money: 43800,
                userID: "default_user",
                category: category(named: "음식")
            ),


            BasicEntry(
                title: "꽃다발",
                content: "아침부터 꽃다발 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-01-30"),
                money: 6900,
                userID: "default_user",
                category: category(named: "선물")
            ),


            BasicEntry(
                title: "콘서트",
                content: "콘서트 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-02-01"),
                money: 88700,
                userID: "default_user",
                category: category(named: "문화생활")
            ),


            BasicEntry(
                title: "기타",
                content: "아침부터 기타 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-02-02"),
                money: 14400,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),


            BasicEntry(
                title: "요가 클래스",
                content: "요가 클래스는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-02-03"),
                money: 4995000,
                userID: "default_user",
                category: category(named: "운동")
            ),


            BasicEntry(
                title: "맛집 투어",
                content: "여행 관련으로 맛집 투어에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-01-09"),
                money: 131300,
                userID: "default_user",
                category: category(named: "여행")
            ),


            BasicEntry(
                title: "운동화",
                content: "운동화 하면서 하루를 마무리했다. 운동 항목으로 기록!",
                date: date("2025-03-15"),
                money: 226600,
                userID: "default_user",
                category: category(named: "운동")
            ),


            BasicEntry(
                title: "약국 구매",
                content: "문득 약국 구매 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-03-09"),
                money: 1188000,
                userID: "default_user",
                category: category(named: "건강")
            ),


            BasicEntry(
                title: "필라테스",
                content: "필라테스 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-04-13"),
                money: 147400,
                userID: "default_user",
                category: category(named: "운동")
            ),


            BasicEntry(
                title: "약국 구매",
                content: "건강 관련으로 약국 구매에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-02-04"),
                money: 61500,
                userID: "default_user",
                category: category(named: "건강")
            ),


            BasicEntry(
                title: "자격증 응시료",
                content: "자격증 응시료 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-02-05"),
                money: 32900,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "요가 클래스",
                content: "요가 클래스 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-03-09"),
                money: 184200,
                userID: "default_user",
                category: category(named: "운동")
            ),


            BasicEntry(
                title: "브런치 카페",
                content: "브런치 카페 하면서 하루를 마무리했다. 음식 항목으로 기록!",
                date: date("2025-02-06"),
                money: 78200,
                userID: "default_user",
                category: category(named: "음식")
            ),


            BasicEntry(
                title: "자격증 응시료",
                content: "자격증 응시료 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-05-06"),
                money: 85100,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "서점 구경",
                content: "아침부터 서점 구경 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-04-03"),
                money: 4995000,
                userID: "default_user",
                category: category(named: "문화생활")
            ),


            BasicEntry(
                title: "비행기 예매",
                content: "여행 관련으로 비행기 예매에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-02-07"),
                money: 288400,
                userID: "default_user",
                category: category(named: "여행")
            ),


            BasicEntry(
                title: "전시회",
                content: "아침부터 전시회 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-02-08"),
                money: 64000,
                userID: "default_user",
                category: category(named: "문화생활")
            ),


            BasicEntry(
                title: "스터디카페",
                content: "스터디카페는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-02-09"),
                money: 49800,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "택시비",
                content: "오늘은 택시비에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-03-08"),
                money: 68100,
                userID: "default_user",
                category: category(named: "교통")
            ),


            BasicEntry(
                title: "영화관람",
                content: "영화관람 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-03-07"),
                money: 106000,
                userID: "default_user",
                category: category(named: "문화생활")
            ),


            BasicEntry(
                title: "도서 구매",
                content: "도서 구매는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-03-15"),
                money: 73100,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "건강검진",
                content: "문득 건강검진 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-01-24"),
                money: 56200,
                userID: "default_user",
                category: category(named: "건강")
            ),


            BasicEntry(
                title: "약국 구매",
                content: "약국 구매는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-02-10"),
                money: 3376000,
                userID: "default_user",
                category: category(named: "건강")
            ),


            BasicEntry(
                title: "옷 쇼핑",
                content: "오늘은 옷 쇼핑에 돈을 썼다. 예상보다 적게 나왔다.",
                date: date("2025-03-24"),
                money: 288100,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),


            BasicEntry(
                title: "렌터카 결제",
                content: "렌터카 결제 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-02-11"),
                money: 294400,
                userID: "default_user",
                category: category(named: "교통")
            ),


            BasicEntry(
                title: "버스 교통카드",
                content: "문득 버스 교통카드 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-03-18"),
                money: 78000,
                userID: "default_user",
                category: category(named: "교통")
            ),


            BasicEntry(
                title: "스터디카페",
                content: "스터디카페는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-01-17"),
                money: 294800,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "화장품 구매",
                content: "화장품 구매 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-02-12"),
                money: 7000,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),


            BasicEntry(
                title: "도서 구매",
                content: "문득 도서 구매 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-04-03"),
                money: 76200,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "헬스장 등록",
                content: "문득 헬스장 등록 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-02-13"),
                money: 12800,
                userID: "default_user",
                category: category(named: "운동")
            ),


            BasicEntry(
                title: "택시비",
                content: "아침부터 택시비 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-01-05"),
                money: 49600,
                userID: "default_user",
                category: category(named: "교통")
            ),


            BasicEntry(
                title: "편지지 구매",
                content: "문득 편지지 구매 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-01-23"),
                money: 10900,
                userID: "default_user",
                category: category(named: "선물")
            ),


            BasicEntry(
                title: "지하철 요금",
                content: "지하철 요금 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-01-06"),
                money: 12300,
                userID: "default_user",
                category: category(named: "교통")
            ),


            BasicEntry(
                title: "서점 구경",
                content: "서점 구경는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-02-14"),
                money: 96000,
                userID: "default_user",
                category: category(named: "문화생활")
            ),


            BasicEntry(
                title: "강의 수강",
                content: "강의 수강 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-02-15"),
                money: 21600,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "고양이 모래",
                content: "고양이 모래 하면서 하루를 마무리했다. 반려동물 항목으로 기록!",
                date: date("2025-02-13"),
                money: 143900,
                userID: "default_user",
                category: category(named: "반려동물")
            ),


            BasicEntry(
                title: "한의원 방문",
                content: "건강 관련으로 한의원 방문에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-02-16"),
                money: 35800,
                userID: "default_user",
                category: category(named: "건강")
            ),


            BasicEntry(
                title: "기념일 선물",
                content: "기념일 선물 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-01-29"),
                money: 435000,
                userID: "default_user",
                category: category(named: "선물")
            ),


            BasicEntry(
                title: "저녁 치킨",
                content: "아침부터 저녁 치킨 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-02-05"),
                money: 145300,
                userID: "default_user",
                category: category(named: "음식")
            ),


            BasicEntry(
                title: "브런치 카페",
                content: "문득 브런치 카페 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-03-28"),
                money: 137100,
                userID: "default_user",
                category: category(named: "음식")
            ),


            BasicEntry(
                title: "기차 예매",
                content: "기차 예매 하면서 하루를 마무리했다. 교통 항목으로 기록!",
                date: date("2025-02-17"),
                money: 32000,
                userID: "default_user",
                category: category(named: "교통")
            ),


            BasicEntry(
                title: "뮤지컬",
                content: "뮤지컬는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-04-05"),
                money: 65900,
                userID: "default_user",
                category: category(named: "문화생활")
            ),


            BasicEntry(
                title: "기프트 카드",
                content: "선물 관련으로 기프트 카드에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-02-18"),
                money: 114000,
                userID: "default_user",
                category: category(named: "선물")
            ),


            BasicEntry(
                title: "운동화",
                content: "운동화 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-03-19"),
                money: 94300,
                userID: "default_user",
                category: category(named: "운동")
            ),


            BasicEntry(
                title: "버스 교통카드",
                content: "버스 교통카드 하면서 하루를 마무리했다. 교통 항목으로 기록!",
                date: date("2025-03-04"),
                money: 182100,
                userID: "default_user",
                category: category(named: "교통")
            ),


            BasicEntry(
                title: "약국 구매",
                content: "아침부터 약국 구매 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-01-21"),
                money: 43300,
                userID: "default_user",
                category: category(named: "건강")
            ),


            BasicEntry(
                title: "예비비",
                content: "오늘은 예비비에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-04-28"),
                money: 10600,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),


            BasicEntry(
                title: "미용비",
                content: "문득 미용비 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-02-19"),
                money: 18100,
                userID: "default_user",
                category: category(named: "반려동물")
            ),


            BasicEntry(
                title: "PT 비용",
                content: "오늘은 PT 비용에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-02-20"),
                money: 110600,
                userID: "default_user",
                category: category(named: "운동")
            ),


            BasicEntry(
                title: "기념일 선물",
                content: "오늘은 기념일 선물에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-02-21"),
                money: 193500,
                userID: "default_user",
                category: category(named: "선물")
            ),


            BasicEntry(
                title: "버스 교통카드",
                content: "교통 관련으로 버스 교통카드에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-02-22"),
                money: 129900,
                userID: "default_user",
                category: category(named: "교통")
            ),


            BasicEntry(
                title: "전시회",
                content: "아침부터 전시회 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-02-23"),
                money: 63600,
                userID: "default_user",
                category: category(named: "문화생활")
            ),


            BasicEntry(
                title: "지하철 요금",
                content: "지하철 요금는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-02-24"),
                money: 42700,
                userID: "default_user",
                category: category(named: "교통")
            ),


            BasicEntry(
                title: "스터디카페",
                content: "오늘은 스터디카페에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-02-25"),
                money: 102600,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "도서 구매",
                content: "문득 도서 구매 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-04-01"),
                money: 46800,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "기타 비용",
                content: "기타 비용 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-02-08"),
                money: 13800,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),


            BasicEntry(
                title: "옷 쇼핑",
                content: "옷 쇼핑 하면서 하루를 마무리했다. 쇼핑 항목으로 기록!",
                date: date("2025-05-05"),
                money: 178300,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),


            BasicEntry(
                title: "관광지 입장료",
                content: "관광지 입장료 하면서 하루를 마무리했다. 여행 항목으로 기록!",
                date: date("2025-04-29"),
                money: 300400,
                userID: "default_user",
                category: category(named: "여행")
            ),


            BasicEntry(
                title: "콘서트",
                content: "오늘은 콘서트에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-04-08"),
                money: 35700,
                userID: "default_user",
                category: category(named: "문화생활")
            ),


            BasicEntry(
                title: "꽃다발",
                content: "문득 꽃다발 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-01-09"),
                money: 11600,
                userID: "default_user",
                category: category(named: "선물")
            ),


            BasicEntry(
                title: "문구류 구매",
                content: "문구류 구매 하면서 하루를 마무리했다. 쇼핑 항목으로 기록!",
                date: date("2025-01-21"),
                money: 13300,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),


            BasicEntry(
                title: "강의 수강",
                content: "오늘은 강의 수강에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-03-22"),
                money: 99700,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "보조식품 구매",
                content: "아침부터 보조식품 구매 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-03-13"),
                money: 120600,
                userID: "default_user",
                category: category(named: "건강")
            ),


            BasicEntry(
                title: "기차 예매",
                content: "문득 기차 예매 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-01-22"),
                money: 50200,
                userID: "default_user",
                category: category(named: "교통")
            ),


            BasicEntry(
                title: "한의원 방문",
                content: "한의원 방문 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-02-26"),
                money: 47900,
                userID: "default_user",
                category: category(named: "건강")
            ),


            BasicEntry(
                title: "비행기 예매",
                content: "비행기 예매 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-02-27"),
                money: 317200,
                userID: "default_user",
                category: category(named: "여행")
            ),


            BasicEntry(
                title: "관광지 입장료",
                content: "관광지 입장료 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-02-11"),
                money: 205700,
                userID: "default_user",
                category: category(named: "여행")
            ),


            BasicEntry(
                title: "병원 진료",
                content: "건강 관련으로 병원 진료에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-02-25"),
                money: 42400,
                userID: "default_user",
                category: category(named: "건강")
            ),


            BasicEntry(
                title: "강아지 사료",
                content: "아침부터 강아지 사료 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-02-28"),
                money: 72800,
                userID: "default_user",
                category: category(named: "반려동물")
            ),


            BasicEntry(
                title: "스터디카페",
                content: "공부 관련으로 스터디카페에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-05-03"),
                money: 239400,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "시험 접수비",
                content: "문득 시험 접수비 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-02-28"),
                money: 67500,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "기념일 선물",
                content: "아침부터 기념일 선물 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-03-29"),
                money: 4774000,
                userID: "default_user",
                category: category(named: "선물")
            ),


            BasicEntry(
                title: "문구류 구매",
                content: "오늘은 문구류 구매에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-01-26"),
                money: 7300,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),


            BasicEntry(
                title: "자격증 응시료",
                content: "아침부터 자격증 응시료 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-03-01"),
                money: 277200,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "서점 구경",
                content: "오늘은 서점 구경에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-01-24"),
                money: 16900,
                userID: "default_user",
                category: category(named: "문화생활")
            ),


            BasicEntry(
                title: "시험 접수비",
                content: "시험 접수비는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-02-06"),
                money: 96500,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "필라테스",
                content: "필라테스는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-04-24"),
                money: 75000,
                userID: "default_user",
                category: category(named: "운동")
            ),


            BasicEntry(
                title: "편지지 구매",
                content: "오늘은 편지지 구매에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-05-07"),
                money: 4800,
                userID: "default_user",
                category: category(named: "선물")
            ),


            BasicEntry(
                title: "호텔 예약",
                content: "호텔 예약 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-03-02"),
                money: 283600,
                userID: "default_user",
                category: category(named: "여행")
            ),


            BasicEntry(
                title: "기타",
                content: "기타는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-04-08"),
                money: 7600,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),


            BasicEntry(
                title: "저녁 치킨",
                content: "문득 저녁 치킨 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-01-13"),
                money: 54600,
                userID: "default_user",
                category: category(named: "음식")
            ),


            BasicEntry(
                title: "콘서트",
                content: "아침부터 콘서트 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-02-14"),
                money: 20300,
                userID: "default_user",
                category: category(named: "문화생활")
            ),


            BasicEntry(
                title: "렌터카",
                content: "렌터카는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-03-06"),
                money: 155000,
                userID: "default_user",
                category: category(named: "여행")
            ),


            BasicEntry(
                title: "가전제품 구매",
                content: "가전제품 구매 하면서 하루를 마무리했다. 쇼핑 항목으로 기록!",
                date: date("2025-03-08"),
                money: 4700,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),


            BasicEntry(
                title: "보조식품 구매",
                content: "건강 관련으로 보조식품 구매에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-01-08"),
                money: 4184000,
                userID: "default_user",
                category: category(named: "건강")
            ),


            BasicEntry(
                title: "예비비",
                content: "예비비는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-01-05"),
                money: 6100,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),


            BasicEntry(
                title: "뮤지컬",
                content: "오늘은 뮤지컬에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-04-25"),
                money: 162400,
                userID: "default_user",
                category: category(named: "문화생활")
            ),


            BasicEntry(
                title: "잡비",
                content: "문득 잡비 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-02-21"),
                money: 822000,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),


            BasicEntry(
                title: "콘서트",
                content: "콘서트 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-03-01"),
                money: 52700,
                userID: "default_user",
                category: category(named: "문화생활")
            ),


            BasicEntry(
                title: "영화관람",
                content: "오늘은 영화관람에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-03-02"),
                money: 75000,
                userID: "default_user",
                category: category(named: "문화생활")
            ),


            BasicEntry(
                title: "미용비",
                content: "오늘은 미용비에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-02-09"),
                money: 57500,
                userID: "default_user",
                category: category(named: "반려동물")
            ),


            BasicEntry(
                title: "강의 수강",
                content: "강의 수강 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-01-22"),
                money: 216900,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "필라테스",
                content: "오늘은 필라테스에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-05-05"),
                money: 116800,
                userID: "default_user",
                category: category(named: "운동")
            ),


            BasicEntry(
                title: "비행기 예매",
                content: "오늘은 비행기 예매에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-03-03"),
                money: 192600,
                userID: "default_user",
                category: category(named: "여행")
            ),


            BasicEntry(
                title: "PT 비용",
                content: "운동 관련으로 PT 비용에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-03-04"),
                money: 167400,
                userID: "default_user",
                category: category(named: "운동")
            ),


            BasicEntry(
                title: "옷 쇼핑",
                content: "옷 쇼핑 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-02-28"),
                money: 113200,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),


            BasicEntry(
                title: "자격증 응시료",
                content: "오늘은 자격증 응시료에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-03-05"),
                money: 131100,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "보조식품 구매",
                content: "보조식품 구매 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-04-06"),
                money: 167200,
                userID: "default_user",
                category: category(named: "건강")
            ),


            BasicEntry(
                title: "강의 수강",
                content: "강의 수강는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-01-10"),
                money: 206400,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "기타",
                content: "기타 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-02-04"),
                money: 6400,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),


            BasicEntry(
                title: "화장품 구매",
                content: "쇼핑 관련으로 화장품 구매에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-02-08"),
                money: 6100,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),


            BasicEntry(
                title: "건강검진",
                content: "건강검진는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-02-12"),
                money: 49400,
                userID: "default_user",
                category: category(named: "건강")
            ),


            BasicEntry(
                title: "관광지 입장료",
                content: "관광지 입장료 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-04-12"),
                money: 363000,
                userID: "default_user",
                category: category(named: "여행")
            ),


            BasicEntry(
                title: "강의 수강",
                content: "강의 수강 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-01-24"),
                money: 268500,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "기프트 카드",
                content: "기프트 카드 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-03-06"),
                money: 161900,
                userID: "default_user",
                category: category(named: "선물")
            ),


            BasicEntry(
                title: "동물병원",
                content: "아침부터 동물병원 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-04-27"),
                money: 120300,
                userID: "default_user",
                category: category(named: "반려동물")
            ),


            BasicEntry(
                title: "영화관람",
                content: "오늘은 영화관람에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-03-07"),
                money: 114500,
                userID: "default_user",
                category: category(named: "문화생활")
            ),


            BasicEntry(
                title: "지하철 요금",
                content: "아침부터 지하철 요금 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-03-08"),
                money: 19900,
                userID: "default_user",
                category: category(named: "교통")
            ),


            BasicEntry(
                title: "신발 구매",
                content: "신발 구매 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-02-17"),
                money: 158000,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),


            BasicEntry(
                title: "신발 구매",
                content: "오늘은 신발 구매에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-03-05"),
                money: 634000,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),


            BasicEntry(
                title: "잡비",
                content: "카테고리 없음 관련으로 잡비에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-03-12"),
                money: 1879000,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),


            BasicEntry(
                title: "렌터카",
                content: "렌터카 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-02-16"),
                money: 345300,
                userID: "default_user",
                category: category(named: "여행")
            ),


            BasicEntry(
                title: "장난감",
                content: "장난감 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-02-17"),
                money: 10400,
                userID: "default_user",
                category: category(named: "반려동물")
            ),


            BasicEntry(
                title: "자격증 응시료",
                content: "문득 자격증 응시료 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-03-09"),
                money: 30500,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "브런치 카페",
                content: "브런치 카페 하면서 하루를 마무리했다. 음식 항목으로 기록!",
                date: date("2025-03-13"),
                money: 111100,
                userID: "default_user",
                category: category(named: "음식")
            ),


            BasicEntry(
                title: "버스 교통카드",
                content: "오늘은 버스 교통카드에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-03-26"),
                money: 20900,
                userID: "default_user",
                category: category(named: "교통")
            ),


            BasicEntry(
                title: "필라테스",
                content: "필라테스 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-03-06"),
                money: 124500,
                userID: "default_user",
                category: category(named: "운동")
            ),


            BasicEntry(
                title: "가전제품 구매",
                content: "가전제품 구매 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-02-22"),
                money: 8300,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),


            BasicEntry(
                title: "렌터카",
                content: "렌터카 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-03-01"),
                money: 215000,
                userID: "default_user",
                category: category(named: "여행")
            ),


            BasicEntry(
                title: "기차 예매",
                content: "교통 관련으로 기차 예매에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-03-10"),
                money: 20500,
                userID: "default_user",
                category: category(named: "교통")
            ),


            BasicEntry(
                title: "미용비",
                content: "아침부터 미용비 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-05-02"),
                money: 148300,
                userID: "default_user",
                category: category(named: "반려동물")
            ),


            BasicEntry(
                title: "운동화",
                content: "운동화는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-04-30"),
                money: 31900,
                userID: "default_user",
                category: category(named: "운동")
            ),


            BasicEntry(
                title: "자격증 응시료",
                content: "자격증 응시료 하면서 하루를 마무리했다. 공부 항목으로 기록!",
                date: date("2025-03-17"),
                money: 145400,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "시험 접수비",
                content: "문득 시험 접수비 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-02-13"),
                money: 13200,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "김밥천국 김밥",
                content: "아침부터 김밥천국 김밥 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-04-06"),
                money: 11000,
                userID: "default_user",
                category: category(named: "음식")
            ),


            BasicEntry(
                title: "관광지 입장료",
                content: "관광지 입장료 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-02-23"),
                money: 186200,
                userID: "default_user",
                category: category(named: "여행")
            ),


            BasicEntry(
                title: "김밥천국 김밥",
                content: "문득 김밥천국 김밥 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-03-11"),
                money: 3800,
                userID: "default_user",
                category: category(named: "음식")
            ),


            BasicEntry(
                title: "잡비",
                content: "잡비 하면서 하루를 마무리했다. 카테고리 없음 항목으로 기록!",
                date: date("2025-03-06"),
                money: 104300,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),


            BasicEntry(
                title: "편지지 구매",
                content: "편지지 구매 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-03-04"),
                money: 9400,
                userID: "default_user",
                category: category(named: "선물")
            ),


            BasicEntry(
                title: "강의 수강",
                content: "강의 수강 하면서 하루를 마무리했다. 공부 항목으로 기록!",
                date: date("2025-03-12"),
                money: 115200,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "자격증 응시료",
                content: "문득 자격증 응시료 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-05-07"),
                money: 266800,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "기타",
                content: "아침부터 기타 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-02-03"),
                money: 3300,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),


            BasicEntry(
                title: "문구류 구매",
                content: "쇼핑 관련으로 문구류 구매에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-03-13"),
                money: 11000,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),


            BasicEntry(
                title: "강의 수강",
                content: "강의 수강 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-03-14"),
                money: 25700,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "시험 접수비",
                content: "공부 관련으로 시험 접수비에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-03-23"),
                money: 139200,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "기타",
                content: "카테고리 없음 관련으로 기타에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-03-15"),
                money: 7900,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),


            BasicEntry(
                title: "도서 구매",
                content: "도서 구매 하면서 하루를 마무리했다. 공부 항목으로 기록!",
                date: date("2025-04-30"),
                money: 160900,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "편지지 구매",
                content: "오늘은 편지지 구매에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-03-16"),
                money: 10600,
                userID: "default_user",
                category: category(named: "선물")
            ),


            BasicEntry(
                title: "서점 구경",
                content: "오늘은 서점 구경에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-01-20"),
                money: 26200,
                userID: "default_user",
                category: category(named: "문화생활")
            ),


            BasicEntry(
                title: "병원 진료",
                content: "병원 진료 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-01-13"),
                money: 95800,
                userID: "default_user",
                category: category(named: "건강")
            ),


            BasicEntry(
                title: "옷 쇼핑",
                content: "아침부터 옷 쇼핑 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-02-28"),
                money: 189500,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),


            BasicEntry(
                title: "호텔 예약",
                content: "호텔 예약 하면서 하루를 마무리했다. 여행 항목으로 기록!",
                date: date("2025-04-10"),
                money: 177200,
                userID: "default_user",
                category: category(named: "여행")
            ),


            BasicEntry(
                title: "스터디카페",
                content: "아침부터 스터디카페 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-02-25"),
                money: 274800,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "고양이 모래",
                content: "반려동물 관련으로 고양이 모래에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-04-22"),
                money: 78300,
                userID: "default_user",
                category: category(named: "반려동물")
            ),


            BasicEntry(
                title: "기타 비용",
                content: "문득 기타 비용 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-03-05"),
                money: 9400,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),


            BasicEntry(
                title: "기타 비용",
                content: "기타 비용는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-03-08"),
                money: 3300,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),


            BasicEntry(
                title: "병원 진료",
                content: "오늘은 병원 진료에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-01-05"),
                money: 101700,
                userID: "default_user",
                category: category(named: "건강")
            ),


            BasicEntry(
                title: "헬스장 등록",
                content: "운동 관련으로 헬스장 등록에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-01-06"),
                money: 154100,
                userID: "default_user",
                category: category(named: "운동")
            ),


            BasicEntry(
                title: "한의원 방문",
                content: "아침부터 한의원 방문 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-05-12"),
                money: 108200,
                userID: "default_user",
                category: category(named: "건강")
            ),


            BasicEntry(
                title: "보조식품 구매",
                content: "보조식품 구매 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-01-29"),
                money: 2925000,
                userID: "default_user",
                category: category(named: "건강")
            ),


            BasicEntry(
                title: "콘서트",
                content: "문득 콘서트 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-04-21"),
                money: 100700,
                userID: "default_user",
                category: category(named: "문화생활")
            ),


            BasicEntry(
                title: "분식집 떡볶이",
                content: "문득 분식집 떡볶이 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-01-07"),
                money: 10000,
                userID: "default_user",
                category: category(named: "음식")
            ),


            BasicEntry(
                title: "택시비",
                content: "오늘은 택시비에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-01-09"),
                money: 25100,
                userID: "default_user",
                category: category(named: "교통")
            ),


            BasicEntry(
                title: "택시비",
                content: "문득 택시비 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-05-01"),
                money: 67000,
                userID: "default_user",
                category: category(named: "교통")
            ),


            BasicEntry(
                title: "기념일 선물",
                content: "문득 기념일 선물 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-03-17"),
                money: 4572000,
                userID: "default_user",
                category: category(named: "선물")
            ),


            BasicEntry(
                title: "편지지 구매",
                content: "아침부터 편지지 구매 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-03-09"),
                money: 5600,
                userID: "default_user",
                category: category(named: "선물")
            ),


            BasicEntry(
                title: "지하철 요금",
                content: "지하철 요금 하면서 하루를 마무리했다. 교통 항목으로 기록!",
                date: date("2025-01-04"),
                money: 17500,
                userID: "default_user",
                category: category(named: "교통")
            ),


            BasicEntry(
                title: "가전제품 구매",
                content: "아침부터 가전제품 구매 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-03-02"),
                money: 4800,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),


            BasicEntry(
                title: "예비비",
                content: "카테고리 없음 관련으로 예비비에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-05-09"),
                money: 13000,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),


            BasicEntry(
                title: "기차 예매",
                content: "기차 예매 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-03-10"),
                money: 37600,
                userID: "default_user",
                category: category(named: "교통")
            ),


            BasicEntry(
                title: "맥도날드 햄버거",
                content: "맥도날드 햄버거는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-03-18"),
                money: 7700,
                userID: "default_user",
                category: category(named: "음식")
            ),


            BasicEntry(
                title: "운동화",
                content: "운동화 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-03-23"),
                money: 242300,
                userID: "default_user",
                category: category(named: "운동")
            ),


            BasicEntry(
                title: "렌터카 결제",
                content: "아침부터 렌터카 결제 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-04-11"),
                money: 398000,
                userID: "default_user",
                category: category(named: "교통")
            ),


            BasicEntry(
                title: "김밥천국 김밥",
                content: "김밥천국 김밥 하면서 하루를 마무리했다. 음식 항목으로 기록!",
                date: date("2025-01-21"),
                money: 14900,
                userID: "default_user",
                category: category(named: "음식")
            ),


            BasicEntry(
                title: "꽃다발",
                content: "꽃다발 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-03-02"),
                money: 11500,
                userID: "default_user",
                category: category(named: "선물")
            ),


            BasicEntry(
                title: "택시비",
                content: "교통 관련으로 택시비에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-04-01"),
                money: 38900,
                userID: "default_user",
                category: category(named: "교통")
            ),


            BasicEntry(
                title: "장난감",
                content: "장난감 하면서 하루를 마무리했다. 반려동물 항목으로 기록!",
                date: date("2025-01-07"),
                money: 13700,
                userID: "default_user",
                category: category(named: "반려동물")
            ),


            BasicEntry(
                title: "지하철 요금",
                content: "지하철 요금 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-02-07"),
                money: 25800,
                userID: "default_user",
                category: category(named: "교통")
            ),


            BasicEntry(
                title: "병원 진료",
                content: "병원 진료 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-03-02"),
                money: 70900,
                userID: "default_user",
                category: category(named: "건강")
            ),


            BasicEntry(
                title: "렌터카 결제",
                content: "렌터카 결제는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-05-03"),
                money: 267800,
                userID: "default_user",
                category: category(named: "교통")
            ),


            BasicEntry(
                title: "요가 클래스",
                content: "요가 클래스 하면서 하루를 마무리했다. 운동 항목으로 기록!",
                date: date("2025-03-08"),
                money: 1431000,
                userID: "default_user",
                category: category(named: "운동")
            ),


            BasicEntry(
                title: "화장품 구매",
                content: "화장품 구매 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-03-19"),
                money: 3200,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),


            BasicEntry(
                title: "전시회",
                content: "문화생활 관련으로 전시회에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-03-20"),
                money: 18100,
                userID: "default_user",
                category: category(named: "문화생활")
            ),


            BasicEntry(
                title: "한의원 방문",
                content: "오늘은 한의원 방문에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-01-22"),
                money: 22800,
                userID: "default_user",
                category: category(named: "건강")
            ),


            BasicEntry(
                title: "운동화",
                content: "운동화 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-03-21"),
                money: 239600,
                userID: "default_user",
                category: category(named: "운동")
            ),


            BasicEntry(
                title: "시험 접수비",
                content: "시험 접수비 하면서 하루를 마무리했다. 공부 항목으로 기록!",
                date: date("2025-03-24"),
                money: 97900,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "시험 접수비",
                content: "아침부터 시험 접수비 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-02-07"),
                money: 169500,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "현금 인출",
                content: "현금 인출 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-03-22"),
                money: 4354000,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),


            BasicEntry(
                title: "렌터카 결제",
                content: "렌터카 결제 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-01-07"),
                money: 218400,
                userID: "default_user",
                category: category(named: "교통")
            ),


            BasicEntry(
                title: "저녁 치킨",
                content: "문득 저녁 치킨 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-03-11"),
                money: 561000,
                userID: "default_user",
                category: category(named: "음식")
            ),


            BasicEntry(
                title: "뮤지컬",
                content: "문득 뮤지컬 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-03-22"),
                money: 121100,
                userID: "default_user",
                category: category(named: "문화생활")
            ),


            BasicEntry(
                title: "스터디카페",
                content: "아침부터 스터디카페 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-01-12"),
                money: 88700,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "관광지 입장료",
                content: "관광지 입장료 하면서 하루를 마무리했다. 여행 항목으로 기록!",
                date: date("2025-03-18"),
                money: 328900,
                userID: "default_user",
                category: category(named: "여행")
            ),


            BasicEntry(
                title: "비행기 예매",
                content: "비행기 예매 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-04-15"),
                money: 322500,
                userID: "default_user",
                category: category(named: "여행")
            ),


            BasicEntry(
                title: "맛집 투어",
                content: "오늘은 맛집 투어에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-03-06"),
                money: 114700,
                userID: "default_user",
                category: category(named: "여행")
            ),


            BasicEntry(
                title: "화장품 구매",
                content: "문득 화장품 구매 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-01-25"),
                money: 12100,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),


            BasicEntry(
                title: "분식집 떡볶이",
                content: "음식 관련으로 분식집 떡볶이에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-01-15"),
                money: 11800,
                userID: "default_user",
                category: category(named: "음식")
            ),


            BasicEntry(
                title: "렌터카",
                content: "렌터카 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-03-03"),
                money: 303300,
                userID: "default_user",
                category: category(named: "여행")
            ),


            BasicEntry(
                title: "전시회",
                content: "문화생활 관련으로 전시회에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-02-27"),
                money: 96000,
                userID: "default_user",
                category: category(named: "문화생활")
            ),


            BasicEntry(
                title: "렌터카",
                content: "렌터카 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-04-13"),
                money: 204000,
                userID: "default_user",
                category: category(named: "여행")
            ),


            BasicEntry(
                title: "버스 교통카드",
                content: "교통 관련으로 버스 교통카드에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-01-22"),
                money: 343000,
                userID: "default_user",
                category: category(named: "교통")
            ),


            BasicEntry(
                title: "지하철 요금",
                content: "오늘은 지하철 요금에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-04-29"),
                money: 69400,
                userID: "default_user",
                category: category(named: "교통")
            ),


            BasicEntry(
                title: "뮤지컬",
                content: "뮤지컬 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-05-08"),
                money: 184400,
                userID: "default_user",
                category: category(named: "문화생활")
            ),


            BasicEntry(
                title: "고양이 모래",
                content: "아침부터 고양이 모래 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-02-11"),
                money: 168700,
                userID: "default_user",
                category: category(named: "반려동물")
            ),


            BasicEntry(
                title: "뮤지컬",
                content: "뮤지컬 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-03-23"),
                money: 78600,
                userID: "default_user",
                category: category(named: "문화생활")
            ),


            BasicEntry(
                title: "기타",
                content: "기타 하면서 하루를 마무리했다. 카테고리 없음 항목으로 기록!",
                date: date("2025-02-26"),
                money: 6400,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),


            BasicEntry(
                title: "가전제품 구매",
                content: "문득 가전제품 구매 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-03-24"),
                money: 5200,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),


            BasicEntry(
                title: "꽃다발",
                content: "선물 관련으로 꽃다발에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-02-15"),
                money: 13900,
                userID: "default_user",
                category: category(named: "선물")
            ),


            BasicEntry(
                title: "브런치 카페",
                content: "브런치 카페 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-01-27"),
                money: 42900,
                userID: "default_user",
                category: category(named: "음식")
            ),


            BasicEntry(
                title: "필라테스",
                content: "필라테스 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-03-01"),
                money: 170400,
                userID: "default_user",
                category: category(named: "운동")
            ),


            BasicEntry(
                title: "기프트 카드",
                content: "기프트 카드는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-03-25"),
                money: 198700,
                userID: "default_user",
                category: category(named: "선물")
            ),


            BasicEntry(
                title: "운동화",
                content: "문득 운동화 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-03-01"),
                money: 151700,
                userID: "default_user",
                category: category(named: "운동")
            ),


            BasicEntry(
                title: "렌터카",
                content: "렌터카는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-03-03"),
                money: 251300,
                userID: "default_user",
                category: category(named: "여행")
            ),


            BasicEntry(
                title: "렌터카",
                content: "렌터카 하면서 하루를 마무리했다. 여행 항목으로 기록!",
                date: date("2025-03-28"),
                money: 347900,
                userID: "default_user",
                category: category(named: "여행")
            ),


            BasicEntry(
                title: "편지지 구매",
                content: "문득 편지지 구매 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-04-10"),
                money: 8600,
                userID: "default_user",
                category: category(named: "선물")
            ),


            BasicEntry(
                title: "조카 장난감",
                content: "오늘은 조카 장난감에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-04-02"),
                money: 5400,
                userID: "default_user",
                category: category(named: "선물")
            ),


            BasicEntry(
                title: "헬스장 등록",
                content: "헬스장 등록는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-02-08"),
                money: 157600,
                userID: "default_user",
                category: category(named: "운동")
            ),


            BasicEntry(
                title: "기념일 선물",
                content: "선물 관련으로 기념일 선물에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-03-15"),
                money: 84300,
                userID: "default_user",
                category: category(named: "선물")
            ),


            BasicEntry(
                title: "택시비",
                content: "오늘은 택시비에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-03-06"),
                money: 14200,
                userID: "default_user",
                category: category(named: "교통")
            ),


            BasicEntry(
                title: "고양이 모래",
                content: "반려동물 관련으로 고양이 모래에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-04-07"),
                money: 4122000,
                userID: "default_user",
                category: category(named: "반려동물")
            ),


            BasicEntry(
                title: "한의원 방문",
                content: "한의원 방문 하면서 하루를 마무리했다. 건강 항목으로 기록!",
                date: date("2025-01-05"),
                money: 75900,
                userID: "default_user",
                category: category(named: "건강")
            ),


            BasicEntry(
                title: "요가 클래스",
                content: "문득 요가 클래스 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-04-12"),
                money: 2537000,
                userID: "default_user",
                category: category(named: "운동")
            ),


            BasicEntry(
                title: "옷 쇼핑",
                content: "쇼핑 관련으로 옷 쇼핑에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-02-17"),
                money: 193000,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),


            BasicEntry(
                title: "관광지 입장료",
                content: "문득 관광지 입장료 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-04-06"),
                money: 354900,
                userID: "default_user",
                category: category(named: "여행")
            ),


            BasicEntry(
                title: "보조식품 구매",
                content: "보조식품 구매 하면서 하루를 마무리했다. 건강 항목으로 기록!",
                date: date("2025-02-09"),
                money: 123700,
                userID: "default_user",
                category: category(named: "건강")
            ),


            BasicEntry(
                title: "잡비",
                content: "잡비는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-03-31"),
                money: 196300,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),


            BasicEntry(
                title: "편지지 구매",
                content: "오늘은 편지지 구매에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-01-29"),
                money: 6900,
                userID: "default_user",
                category: category(named: "선물")
            ),


            BasicEntry(
                title: "맥도날드 햄버거",
                content: "음식 관련으로 맥도날드 햄버거에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-03-13"),
                money: 11800,
                userID: "default_user",
                category: category(named: "음식")
            ),


            BasicEntry(
                title: "조카 장난감",
                content: "아침부터 조카 장난감 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-04-30"),
                money: 8200,
                userID: "default_user",
                category: category(named: "선물")
            ),


            BasicEntry(
                title: "도서 구매",
                content: "도서 구매 하면서 하루를 마무리했다. 공부 항목으로 기록!",
                date: date("2025-03-26"),
                money: 3767000,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "문구류 구매",
                content: "문구류 구매 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-03-18"),
                money: 4700,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),


            BasicEntry(
                title: "강아지 사료",
                content: "아침부터 강아지 사료 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-03-02"),
                money: 87600,
                userID: "default_user",
                category: category(named: "반려동물")
            ),


            BasicEntry(
                title: "시험 접수비",
                content: "시험 접수비 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-04-28"),
                money: 207200,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "강의 수강",
                content: "문득 강의 수강 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-02-28"),
                money: 150700,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "강의 수강",
                content: "강의 수강 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-02-04"),
                money: 63200,
                userID: "default_user",
                category: category(named: "공부")
            ),


            BasicEntry(
                title: "보조식품 구매",
                content: "보조식품 구매 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-03-27"),
                money: 106800,
                userID: "default_user",
                category: category(named: "건강")
            ),


            BasicEntry(
                title: "조카 장난감",
                content: "오늘은 조카 장난감에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-01-25"),
                money: 8600,
                userID: "default_user",
                category: category(named: "선물")
            ),


            BasicEntry(
                title: "호텔 예약",
                content: "호텔 예약는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-04-10"),
                money: 327900,
                userID: "default_user",
                category: category(named: "여행")
            ),


            BasicEntry(
                title: "장난감",
                content: "오늘은 장난감에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-02-04"),
                money: 4200,
                userID: "default_user",
                category: category(named: "반려동물")
            ),


            BasicEntry(
                title: "PT 비용",
                content: "운동 관련으로 PT 비용에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-04-12"),
                money: 213500,
                userID: "default_user",
                category: category(named: "운동")
            ),


            BasicEntry(
                title: "필라테스",
                content: "아침부터 필라테스 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-03-05"),
                money: 41500,
                userID: "default_user",
                category: category(named: "운동")
            ),


            BasicEntry(
                title: "분식집 떡볶이",
                content: "분식집 떡볶이는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-04-19"),
                money: 9500,
                userID: "default_user",
                category: category(named: "음식")
            ),


            BasicEntry(
                title: "전시회",
                content: "전시회 하면서 하루를 마무리했다. 문화생활 항목으로 기록!",
                date: date("2025-01-13"),
                money: 19600,
                userID: "default_user",
                category: category(named: "문화생활")
            ),


            BasicEntry(
                title: "가전제품 구매",
                content: "아침부터 가전제품 구매 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-03-28"),
                money: 5800,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),


            BasicEntry(
                title: "기차 예매",
                content: "기차 예매 하면서 하루를 마무리했다. 교통 항목으로 기록!",
                date: date("2025-04-07"),
                money: 69900,
                userID: "default_user",
                category: category(named: "교통")
            ),


            BasicEntry(
                title: "맛집 투어",
                content: "맛집 투어는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-01-20"),
                money: 34800,
                userID: "default_user",
                category: category(named: "여행")
            ),


            BasicEntry(
                title: "기타",
                content: "문득 기타 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-01-25"),
                money: 6100,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),


            BasicEntry(
                title: "보조식품 구매",
                content: "보조식품 구매 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-03-02"),
                money: 153200,
                userID: "default_user",
                category: category(named: "건강")
            ),


            BasicEntry(
                title: "약 구매",
                content: "문득 영양제를 구매 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-04-15"),
                money: 189700,
                userID: "default_user",
                category: category(named: "건강")
            ),


            BasicEntry(
                title: "호텔 예약",
                content: "아침부터 호텔 예약 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-04-27"),
                money: 388400,
                userID: "default_user",
                category: category(named: "여행")
            ),


            BasicEntry(
                title: "렌터카 결제",
                content: "렌터카 결제는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-04-20"),
                money: 390000,
                userID: "default_user",
                category: category(named: "교통")
            ),


            BasicEntry(
                title: "옷 쇼핑",
                content: "아침부터 옷 쇼핑 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-02-19"),
                money: 40900,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),


            BasicEntry(
                title: "꽃다발",
                content: "꽃다발는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-03-28"),
                money: 12200,
                userID: "default_user",
                category: category(named: "선물")
            ),


            BasicEntry(
                title: "편지지 구매",
                content: "오늘은 편지지 구매에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-01-10"),
                money: 9200,
                userID: "default_user",
                category: category(named: "선물")
            ),


            BasicEntry(
                title: "기념일 선물",
                content: "기념일 선물 하면서 하루를 마무리했다. 선물 항목으로 기록!",
                date: date("2025-05-09"),
                money: 182300,
                userID: "default_user",
                category: category(named: "선물")
            ),


            BasicEntry(
                title: "가전제품 구매",
                content: "가전제품 구매 하면서 하루를 마무리했다. 쇼핑 항목으로 기록!",
                date: date("2025-01-15"),
                money: 10600,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),


            BasicEntry(
                title: "콘서트",
                content: "문화생활 관련으로 콘서트에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-04-25"),
                money: 13900,
                userID: "default_user",
                category: category(named: "문화생활")
            ),


            BasicEntry(
                title: "필라테스",
                content: "문득 필라테스 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-04-12"),
                money: 172600,
                userID: "default_user",
                category: category(named: "운동")
            ),


            BasicEntry(
                title: "가전제품 구매",
                content: "문득 가전제품 구매 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-02-18"),
                money: 9000,
                userID: "default_user",
                category: category(named: "쇼핑")
            )
        ]
    }
}
