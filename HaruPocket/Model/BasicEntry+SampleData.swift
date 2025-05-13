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
                content: "음식 관련으로 브런치 카페에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-04-16"),
                money: 2546000,
                userID: "default_user",
                category: category(named: "음식")
            ),

            BasicEntry(
                title: "영화관람",
                content: "영화관람 하면서 하루를 마무리했다. 문화생활 항목으로 기록!",
                date: date("2025-03-07"),
                money: 530000,
                userID: "default_user",
                category: category(named: "문화생활")
            ),

            BasicEntry(
                title: "신발 구매",
                content: "신발 구매는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-03-14"),
                money: 1525000,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),

            BasicEntry(
                title: "고양이 모래",
                content: "고양이 모래 하면서 하루를 마무리했다. 반려동물 항목으로 기록!",
                date: date("2025-05-25"),
                money: 3271000,
                userID: "default_user",
                category: category(named: "반려동물")
            ),

            BasicEntry(
                title: "맛집 투어",
                content: "맛집 투어 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-04-22"),
                money: 266000,
                userID: "default_user",
                category: category(named: "여행")
            ),

            BasicEntry(
                title: "서점 구경",
                content: "아침부터 서점 구경 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-06-28"),
                money: 3257000,
                userID: "default_user",
                category: category(named: "문화생활")
            ),

            BasicEntry(
                title: "호텔 예약",
                content: "여행 관련으로 호텔 예약에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-08-01"),
                money: 4143000,
                userID: "default_user",
                category: category(named: "여행")
            ),

            BasicEntry(
                title: "뮤지컬",
                content: "뮤지컬는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-07-23"),
                money: 3440000,
                userID: "default_user",
                category: category(named: "문화생활")
            ),

            BasicEntry(
                title: "기차 예매",
                content: "아침부터 기차 예매 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-06-17"),
                money: 4870000,
                userID: "default_user",
                category: category(named: "교통")
            ),

            BasicEntry(
                title: "분식집 떡볶이",
                content: "아침부터 분식집 떡볶이 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-06-07"),
                money: 1228000,
                userID: "default_user",
                category: category(named: "음식")
            ),

            BasicEntry(
                title: "편지지 구매",
                content: "편지지 구매 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-08-30"),
                money: 2185000,
                userID: "default_user",
                category: category(named: "선물")
            ),

            BasicEntry(
                title: "기타 비용",
                content: "기타 비용 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-03-06"),
                money: 1813000,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),

            BasicEntry(
                title: "옷 쇼핑",
                content: "옷 쇼핑 하면서 하루를 마무리했다. 쇼핑 항목으로 기록!",
                date: date("2025-04-30"),
                money: 4704000,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),

            BasicEntry(
                title: "신발 구매",
                content: "신발 구매 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-08-30"),
                money: 4431000,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),

            BasicEntry(
                title: "김밥천국 김밥",
                content: "아침부터 김밥천국 김밥 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-04-03"),
                money: 2596000,
                userID: "default_user",
                category: category(named: "음식")
            ),

            BasicEntry(
                title: "PT 비용",
                content: "PT 비용는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-08-09"),
                money: 523000,
                userID: "default_user",
                category: category(named: "운동")
            ),

            BasicEntry(
                title: "장난감",
                content: "장난감 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-06-04"),
                money: 1762000,
                userID: "default_user",
                category: category(named: "반려동물")
            ),

            BasicEntry(
                title: "강아지 사료",
                content: "강아지 사료 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-08-05"),
                money: 386000,
                userID: "default_user",
                category: category(named: "반려동물")
            ),

            BasicEntry(
                title: "미용비",
                content: "문득 미용비 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-07-05"),
                money: 3786000,
                userID: "default_user",
                category: category(named: "반려동물")
            ),

            BasicEntry(
                title: "약국 구매",
                content: "오늘은 약국 구매에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-07-26"),
                money: 2886000,
                userID: "default_user",
                category: category(named: "건강")
            ),

            BasicEntry(
                title: "현금 인출",
                content: "문득 현금 인출 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-07-16"),
                money: 3139000,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),

            BasicEntry(
                title: "콘서트",
                content: "콘서트 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-03-27"),
                money: 3136000,
                userID: "default_user",
                category: category(named: "문화생활")
            ),

            BasicEntry(
                title: "택시비",
                content: "오늘은 택시비에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-08-06"),
                money: 1233000,
                userID: "default_user",
                category: category(named: "교통")
            ),

            BasicEntry(
                title: "예비비",
                content: "문득 예비비 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-06-21"),
                money: 89000,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),

            BasicEntry(
                title: "영화관람",
                content: "오늘은 영화관람에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-05-12"),
                money: 4755000,
                userID: "default_user",
                category: category(named: "문화생활")
            ),

            BasicEntry(
                title: "뮤지컬",
                content: "뮤지컬 하면서 하루를 마무리했다. 문화생활 항목으로 기록!",
                date: date("2025-07-01"),
                money: 2157000,
                userID: "default_user",
                category: category(named: "문화생활")
            ),

            BasicEntry(
                title: "저녁 치킨",
                content: "저녁 치킨 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-05-26"),
                money: 3443000,
                userID: "default_user",
                category: category(named: "음식")
            ),

            BasicEntry(
                title: "문구류 구매",
                content: "쇼핑 관련으로 문구류 구매에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-07-06"),
                money: 2258000,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),

            BasicEntry(
                title: "호텔 예약",
                content: "문득 호텔 예약 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-05-06"),
                money: 3191000,
                userID: "default_user",
                category: category(named: "여행")
            ),

            BasicEntry(
                title: "꽃다발",
                content: "문득 꽃다발 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-06-06"),
                money: 1842000,
                userID: "default_user",
                category: category(named: "선물")
            ),

            BasicEntry(
                title: "현금 인출",
                content: "오늘은 현금 인출에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-05-02"),
                money: 3702000,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),

            BasicEntry(
                title: "기념일 선물",
                content: "선물 관련으로 기념일 선물에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-07-07"),
                money: 1674000,
                userID: "default_user",
                category: category(named: "선물")
            ),

            BasicEntry(
                title: "헬스장 등록",
                content: "헬스장 등록 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-05-15"),
                money: 4726000,
                userID: "default_user",
                category: category(named: "운동")
            ),

            BasicEntry(
                title: "전시회",
                content: "전시회 하면서 하루를 마무리했다. 문화생활 항목으로 기록!",
                date: date("2025-06-27"),
                money: 2753000,
                userID: "default_user",
                category: category(named: "문화생활")
            ),

            BasicEntry(
                title: "도서 구매",
                content: "도서 구매 하면서 하루를 마무리했다. 공부 항목으로 기록!",
                date: date("2025-04-10"),
                money: 377000,
                userID: "default_user",
                category: category(named: "공부")
            ),

            BasicEntry(
                title: "관광지 입장료",
                content: "관광지 입장료 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-06-07"),
                money: 3930000,
                userID: "default_user",
                category: category(named: "여행")
            ),

            BasicEntry(
                title: "지하철 요금",
                content: "지하철 요금 하면서 하루를 마무리했다. 교통 항목으로 기록!",
                date: date("2025-06-01"),
                money: 1391000,
                userID: "default_user",
                category: category(named: "교통")
            ),

            BasicEntry(
                title: "비행기 예매",
                content: "문득 비행기 예매 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-03-30"),
                money: 964000,
                userID: "default_user",
                category: category(named: "여행")
            ),

            BasicEntry(
                title: "예비비",
                content: "문득 예비비 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-05-09"),
                money: 28000,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),

            BasicEntry(
                title: "요가 클래스",
                content: "운동 관련으로 요가 클래스에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-05-09"),
                money: 229000,
                userID: "default_user",
                category: category(named: "운동")
            ),

            BasicEntry(
                title: "꽃다발",
                content: "문득 꽃다발 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-05-28"),
                money: 2900000,
                userID: "default_user",
                category: category(named: "선물")
            ),

            BasicEntry(
                title: "자격증 응시료",
                content: "아침부터 자격증 응시료 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-04-11"),
                money: 1565000,
                userID: "default_user",
                category: category(named: "공부")
            ),

            BasicEntry(
                title: "꽃다발",
                content: "아침부터 꽃다발 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-03-09"),
                money: 755000,
                userID: "default_user",
                category: category(named: "선물")
            ),

            BasicEntry(
                title: "기차 예매",
                content: "오늘은 기차 예매에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-07-10"),
                money: 4072000,
                userID: "default_user",
                category: category(named: "교통")
            ),

            BasicEntry(
                title: "저녁 치킨",
                content: "음식 관련으로 저녁 치킨에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-04-06"),
                money: 974000,
                userID: "default_user",
                category: category(named: "음식")
            ),

            BasicEntry(
                title: "자격증 응시료",
                content: "아침부터 자격증 응시료 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-07-16"),
                money: 4060000,
                userID: "default_user",
                category: category(named: "공부")
            ),

            BasicEntry(
                title: "기념일 선물",
                content: "오늘은 기념일 선물에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-08-15"),
                money: 3183000,
                userID: "default_user",
                category: category(named: "선물")
            ),

            BasicEntry(
                title: "김밥천국 김밥",
                content: "김밥천국 김밥 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-07-01"),
                money: 478000,
                userID: "default_user",
                category: category(named: "음식")
            ),

            BasicEntry(
                title: "비행기 예매",
                content: "비행기 예매 하면서 하루를 마무리했다. 여행 항목으로 기록!",
                date: date("2025-06-29"),
                money: 4796000,
                userID: "default_user",
                category: category(named: "여행")
            ),

            BasicEntry(
                title: "예비비",
                content: "예비비는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-04-13"),
                money: 2646000,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),

            BasicEntry(
                title: "편지지 구매",
                content: "문득 편지지 구매 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-05-05"),
                money: 1819000,
                userID: "default_user",
                category: category(named: "선물")
            ),

            BasicEntry(
                title: "브런치 카페",
                content: "문득 브런치 카페 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-04-30"),
                money: 3285000,
                userID: "default_user",
                category: category(named: "음식")
            ),

            BasicEntry(
                title: "꽃다발",
                content: "아침부터 꽃다발 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-07-28"),
                money: 1273000,
                userID: "default_user",
                category: category(named: "선물")
            ),

            BasicEntry(
                title: "콘서트",
                content: "콘서트 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-08-03"),
                money: 672000,
                userID: "default_user",
                category: category(named: "문화생활")
            ),

            BasicEntry(
                title: "기타",
                content: "아침부터 기타 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-08-28"),
                money: 4570000,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),

            BasicEntry(
                title: "요가 클래스",
                content: "요가 클래스는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-08-14"),
                money: 4995000,
                userID: "default_user",
                category: category(named: "운동")
            ),

            BasicEntry(
                title: "맛집 투어",
                content: "여행 관련으로 맛집 투어에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-06-07"),
                money: 3992000,
                userID: "default_user",
                category: category(named: "여행")
            ),

            BasicEntry(
                title: "운동화",
                content: "운동화 하면서 하루를 마무리했다. 운동 항목으로 기록!",
                date: date("2025-03-15"),
                money: 73000,
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
                money: 595000,
                userID: "default_user",
                category: category(named: "운동")
            ),

            BasicEntry(
                title: "약국 구매",
                content: "건강 관련으로 약국 구매에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-05-30"),
                money: 1671000,
                userID: "default_user",
                category: category(named: "건강")
            ),

            BasicEntry(
                title: "자격증 응시료",
                content: "자격증 응시료 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-05-18"),
                money: 357000,
                userID: "default_user",
                category: category(named: "공부")
            ),

            BasicEntry(
                title: "요가 클래스",
                content: "요가 클래스 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-03-09"),
                money: 2511000,
                userID: "default_user",
                category: category(named: "운동")
            ),

            BasicEntry(
                title: "브런치 카페",
                content: "브런치 카페 하면서 하루를 마무리했다. 음식 항목으로 기록!",
                date: date("2025-08-04"),
                money: 3548000,
                userID: "default_user",
                category: category(named: "음식")
            ),

            BasicEntry(
                title: "자격증 응시료",
                content: "자격증 응시료 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-05-06"),
                money: 1042000,
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
                date: date("2025-06-22"),
                money: 3791000,
                userID: "default_user",
                category: category(named: "여행")
            ),

            BasicEntry(
                title: "전시회",
                content: "아침부터 전시회 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-08-21"),
                money: 4114000,
                userID: "default_user",
                category: category(named: "문화생활")
            ),

            BasicEntry(
                title: "스터디카페",
                content: "스터디카페는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-07-27"),
                money: 1081000,
                userID: "default_user",
                category: category(named: "공부")
            ),

            BasicEntry(
                title: "택시비",
                content: "오늘은 택시비에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-03-08"),
                money: 2872000,
                userID: "default_user",
                category: category(named: "교통")
            ),

            BasicEntry(
                title: "영화관람",
                content: "영화관람 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-03-07"),
                money: 3009000,
                userID: "default_user",
                category: category(named: "문화생활")
            ),

            BasicEntry(
                title: "도서 구매",
                content: "도서 구매는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-05-15"),
                money: 622000,
                userID: "default_user",
                category: category(named: "공부")
            ),

            BasicEntry(
                title: "건강검진",
                content: "문득 건강검진 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-08-15"),
                money: 4941000,
                userID: "default_user",
                category: category(named: "건강")
            ),

            BasicEntry(
                title: "약국 구매",
                content: "약국 구매는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-08-18"),
                money: 3376000,
                userID: "default_user",
                category: category(named: "건강")
            ),

            BasicEntry(
                title: "옷 쇼핑",
                content: "오늘은 옷 쇼핑에 돈을 썼다. 예상보다 적게 나왔다.",
                date: date("2025-03-24"),
                money: 46000,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),

            BasicEntry(
                title: "렌터카 결제",
                content: "렌터카 결제 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-06-25"),
                money: 997000,
                userID: "default_user",
                category: category(named: "교통")
            ),

            BasicEntry(
                title: "버스 교통카드",
                content: "문득 버스 교통카드 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-03-18"),
                money: 3669000,
                userID: "default_user",
                category: category(named: "교통")
            ),

            BasicEntry(
                title: "스터디카페",
                content: "스터디카페는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-08-06"),
                money: 1042000,
                userID: "default_user",
                category: category(named: "공부")
            ),

            BasicEntry(
                title: "화장품 구매",
                content: "화장품 구매 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-08-22"),
                money: 4115000,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),

            BasicEntry(
                title: "도서 구매",
                content: "문득 도서 구매 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-04-03"),
                money: 1077000,
                userID: "default_user",
                category: category(named: "공부")
            ),

            BasicEntry(
                title: "헬스장 등록",
                content: "문득 헬스장 등록 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-08-02"),
                money: 2676000,
                userID: "default_user",
                category: category(named: "운동")
            ),

            BasicEntry(
                title: "택시비",
                content: "아침부터 택시비 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-06-28"),
                money: 3769000,
                userID: "default_user",
                category: category(named: "교통")
            ),

            BasicEntry(
                title: "편지지 구매",
                content: "문득 편지지 구매 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-07-07"),
                money: 2101000,
                userID: "default_user",
                category: category(named: "선물")
            ),

            BasicEntry(
                title: "지하철 요금",
                content: "지하철 요금 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-08-01"),
                money: 3763000,
                userID: "default_user",
                category: category(named: "교통")
            ),

            BasicEntry(
                title: "서점 구경",
                content: "서점 구경는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-07-20"),
                money: 2953000,
                userID: "default_user",
                category: category(named: "문화생활")
            ),

            BasicEntry(
                title: "강의 수강",
                content: "강의 수강 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-08-12"),
                money: 2283000,
                userID: "default_user",
                category: category(named: "공부")
            ),

            BasicEntry(
                title: "고양이 모래",
                content: "고양이 모래 하면서 하루를 마무리했다. 반려동물 항목으로 기록!",
                date: date("2025-08-02"),
                money: 952000,
                userID: "default_user",
                category: category(named: "반려동물")
            ),

            BasicEntry(
                title: "한의원 방문",
                content: "건강 관련으로 한의원 방문에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-07-11"),
                money: 1810000,
                userID: "default_user",
                category: category(named: "건강")
            ),

            BasicEntry(
                title: "기념일 선물",
                content: "기념일 선물 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-06-29"),
                money: 435000,
                userID: "default_user",
                category: category(named: "선물")
            ),

            BasicEntry(
                title: "저녁 치킨",
                content: "아침부터 저녁 치킨 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-05-18"),
                money: 715000,
                userID: "default_user",
                category: category(named: "음식")
            ),

            BasicEntry(
                title: "브런치 카페",
                content: "문득 브런치 카페 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-03-28"),
                money: 3410000,
                userID: "default_user",
                category: category(named: "음식")
            ),

            BasicEntry(
                title: "기차 예매",
                content: "기차 예매 하면서 하루를 마무리했다. 교통 항목으로 기록!",
                date: date("2025-06-09"),
                money: 3838000,
                userID: "default_user",
                category: category(named: "교통")
            ),

            BasicEntry(
                title: "뮤지컬",
                content: "뮤지컬는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-04-05"),
                money: 1103000,
                userID: "default_user",
                category: category(named: "문화생활")
            ),

            BasicEntry(
                title: "기프트 카드",
                content: "선물 관련으로 기프트 카드에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-05-16"),
                money: 114000,
                userID: "default_user",
                category: category(named: "선물")
            ),

            BasicEntry(
                title: "운동화",
                content: "운동화 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-03-19"),
                money: 4189000,
                userID: "default_user",
                category: category(named: "운동")
            ),

            BasicEntry(
                title: "버스 교통카드",
                content: "버스 교통카드 하면서 하루를 마무리했다. 교통 항목으로 기록!",
                date: date("2025-03-04"),
                money: 4969000,
                userID: "default_user",
                category: category(named: "교통")
            ),

            BasicEntry(
                title: "약국 구매",
                content: "아침부터 약국 구매 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-07-06"),
                money: 1554000,
                userID: "default_user",
                category: category(named: "건강")
            ),

            BasicEntry(
                title: "예비비",
                content: "오늘은 예비비에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-04-28"),
                money: 3438000,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),

            BasicEntry(
                title: "미용비",
                content: "문득 미용비 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-05-20"),
                money: 885000,
                userID: "default_user",
                category: category(named: "반려동물")
            ),

            BasicEntry(
                title: "PT 비용",
                content: "오늘은 PT 비용에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-05-23"),
                money: 4417000,
                userID: "default_user",
                category: category(named: "운동")
            ),

            BasicEntry(
                title: "기념일 선물",
                content: "오늘은 기념일 선물에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-05-31"),
                money: 1779000,
                userID: "default_user",
                category: category(named: "선물")
            ),

            BasicEntry(
                title: "버스 교통카드",
                content: "교통 관련으로 버스 교통카드에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-05-21"),
                money: 1005000,
                userID: "default_user",
                category: category(named: "교통")
            ),

            BasicEntry(
                title: "전시회",
                content: "아침부터 전시회 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-05-27"),
                money: 2241000,
                userID: "default_user",
                category: category(named: "문화생활")
            ),

            BasicEntry(
                title: "지하철 요금",
                content: "지하철 요금는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-07-02"),
                money: 1343000,
                userID: "default_user",
                category: category(named: "교통")
            ),

            BasicEntry(
                title: "스터디카페",
                content: "오늘은 스터디카페에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-06-03"),
                money: 3108000,
                userID: "default_user",
                category: category(named: "공부")
            ),

            BasicEntry(
                title: "도서 구매",
                content: "문득 도서 구매 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-04-01"),
                money: 341000,
                userID: "default_user",
                category: category(named: "공부")
            ),

            BasicEntry(
                title: "기타 비용",
                content: "기타 비용 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-08-21"),
                money: 1615000,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),

            BasicEntry(
                title: "옷 쇼핑",
                content: "옷 쇼핑 하면서 하루를 마무리했다. 쇼핑 항목으로 기록!",
                date: date("2025-05-05"),
                money: 2023000,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),

            BasicEntry(
                title: "관광지 입장료",
                content: "관광지 입장료 하면서 하루를 마무리했다. 여행 항목으로 기록!",
                date: date("2025-04-29"),
                money: 3550000,
                userID: "default_user",
                category: category(named: "여행")
            ),

            BasicEntry(
                title: "콘서트",
                content: "오늘은 콘서트에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-04-08"),
                money: 4241000,
                userID: "default_user",
                category: category(named: "문화생활")
            ),

            BasicEntry(
                title: "꽃다발",
                content: "문득 꽃다발 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-06-07"),
                money: 2266000,
                userID: "default_user",
                category: category(named: "선물")
            ),

            BasicEntry(
                title: "문구류 구매",
                content: "문구류 구매 하면서 하루를 마무리했다. 쇼핑 항목으로 기록!",
                date: date("2025-07-06"),
                money: 3877000,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),

            BasicEntry(
                title: "강의 수강",
                content: "오늘은 강의 수강에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-03-22"),
                money: 2422000,
                userID: "default_user",
                category: category(named: "공부")
            ),

            BasicEntry(
                title: "보조식품 구매",
                content: "아침부터 보조식품 구매 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-03-13"),
                money: 815000,
                userID: "default_user",
                category: category(named: "건강")
            ),

            BasicEntry(
                title: "기차 예매",
                content: "문득 기차 예매 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-06-06"),
                money: 4625000,
                userID: "default_user",
                category: category(named: "교통")
            ),

            BasicEntry(
                title: "한의원 방문",
                content: "한의원 방문 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-06-10"),
                money: 176000,
                userID: "default_user",
                category: category(named: "건강")
            ),

            BasicEntry(
                title: "비행기 예매",
                content: "비행기 예매 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-06-11"),
                money: 1677000,
                userID: "default_user",
                category: category(named: "여행")
            ),

            BasicEntry(
                title: "관광지 입장료",
                content: "관광지 입장료 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-06-25"),
                money: 1351000,
                userID: "default_user",
                category: category(named: "여행")
            ),

            BasicEntry(
                title: "병원 진료",
                content: "건강 관련으로 병원 진료에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-06-03"),
                money: 3835000,
                userID: "default_user",
                category: category(named: "건강")
            ),

            BasicEntry(
                title: "강아지 사료",
                content: "아침부터 강아지 사료 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-07-13"),
                money: 3035000,
                userID: "default_user",
                category: category(named: "반려동물")
            ),

            BasicEntry(
                title: "스터디카페",
                content: "공부 관련으로 스터디카페에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-05-03"),
                money: 1011000,
                userID: "default_user",
                category: category(named: "공부")
            ),

            BasicEntry(
                title: "시험 접수비",
                content: "문득 시험 접수비 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-07-13"),
                money: 2497000,
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
                date: date("2025-06-01"),
                money: 1257000,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),

            BasicEntry(
                title: "자격증 응시료",
                content: "아침부터 자격증 응시료 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-06-26"),
                money: 4993000,
                userID: "default_user",
                category: category(named: "공부")
            ),

            BasicEntry(
                title: "서점 구경",
                content: "오늘은 서점 구경에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-08-15"),
                money: 2657000,
                userID: "default_user",
                category: category(named: "문화생활")
            ),

            BasicEntry(
                title: "시험 접수비",
                content: "시험 접수비는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-08-04"),
                money: 1956000,
                userID: "default_user",
                category: category(named: "공부")
            ),

            BasicEntry(
                title: "필라테스",
                content: "필라테스는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-04-24"),
                money: 4386000,
                userID: "default_user",
                category: category(named: "운동")
            ),

            BasicEntry(
                title: "편지지 구매",
                content: "오늘은 편지지 구매에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-05-07"),
                money: 882000,
                userID: "default_user",
                category: category(named: "선물")
            ),

            BasicEntry(
                title: "호텔 예약",
                content: "호텔 예약 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-08-10"),
                money: 12000,
                userID: "default_user",
                category: category(named: "여행")
            ),

            BasicEntry(
                title: "기타",
                content: "기타는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-04-08"),
                money: 3833000,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),

            BasicEntry(
                title: "저녁 치킨",
                content: "문득 저녁 치킨 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-08-05"),
                money: 4985000,
                userID: "default_user",
                category: category(named: "음식")
            ),

            BasicEntry(
                title: "콘서트",
                content: "아침부터 콘서트 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-07-20"),
                money: 3493000,
                userID: "default_user",
                category: category(named: "문화생활")
            ),

            BasicEntry(
                title: "렌터카",
                content: "렌터카는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-03-06"),
                money: 4270000,
                userID: "default_user",
                category: category(named: "여행")
            ),

            BasicEntry(
                title: "가전제품 구매",
                content: "가전제품 구매 하면서 하루를 마무리했다. 쇼핑 항목으로 기록!",
                date: date("2025-03-08"),
                money: 82000,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),

            BasicEntry(
                title: "보조식품 구매",
                content: "건강 관련으로 보조식품 구매에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-06-17"),
                money: 4184000,
                userID: "default_user",
                category: category(named: "건강")
            ),

            BasicEntry(
                title: "예비비",
                content: "예비비는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-06-28"),
                money: 1875000,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),

            BasicEntry(
                title: "뮤지컬",
                content: "오늘은 뮤지컬에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-04-25"),
                money: 2012000,
                userID: "default_user",
                category: category(named: "문화생활")
            ),

            BasicEntry(
                title: "잡비",
                content: "문득 잡비 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-05-31"),
                money: 822000,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),

            BasicEntry(
                title: "콘서트",
                content: "콘서트 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-08-26"),
                money: 2751000,
                userID: "default_user",
                category: category(named: "문화생활")
            ),

            BasicEntry(
                title: "영화관람",
                content: "오늘은 영화관람에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-07-14"),
                money: 2248000,
                userID: "default_user",
                category: category(named: "문화생활")
            ),

            BasicEntry(
                title: "미용비",
                content: "오늘은 미용비에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-07-27"),
                money: 2665000,
                userID: "default_user",
                category: category(named: "반려동물")
            ),

            BasicEntry(
                title: "강의 수강",
                content: "강의 수강 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-06-06"),
                money: 3645000,
                userID: "default_user",
                category: category(named: "공부")
            ),

            BasicEntry(
                title: "필라테스",
                content: "오늘은 필라테스에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-05-13"),
                money: 4701000,
                userID: "default_user",
                category: category(named: "운동")
            ),

            BasicEntry(
                title: "비행기 예매",
                content: "오늘은 비행기 예매에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-08-23"),
                money: 2899000,
                userID: "default_user",
                category: category(named: "여행")
            ),

            BasicEntry(
                title: "PT 비용",
                content: "운동 관련으로 PT 비용에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-07-12"),
                money: 1945000,
                userID: "default_user",
                category: category(named: "운동")
            ),

            BasicEntry(
                title: "옷 쇼핑",
                content: "옷 쇼핑 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-07-13"),
                money: 690000,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),

            BasicEntry(
                title: "자격증 응시료",
                content: "오늘은 자격증 응시료에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-06-18"),
                money: 2973000,
                userID: "default_user",
                category: category(named: "공부")
            ),

            BasicEntry(
                title: "보조식품 구매",
                content: "보조식품 구매 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-04-06"),
                money: 1797000,
                userID: "default_user",
                category: category(named: "건강")
            ),

            BasicEntry(
                title: "강의 수강",
                content: "강의 수강는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-08-30"),
                money: 3501000,
                userID: "default_user",
                category: category(named: "공부")
            ),

            BasicEntry(
                title: "기타",
                content: "기타 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-05-30"),
                money: 1160000,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),

            BasicEntry(
                title: "화장품 구매",
                content: "쇼핑 관련으로 화장품 구매에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-08-21"),
                money: 4614000,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),

            BasicEntry(
                title: "건강검진",
                content: "건강검진는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-08-22"),
                money: 2494000,
                userID: "default_user",
                category: category(named: "건강")
            ),

            BasicEntry(
                title: "관광지 입장료",
                content: "관광지 입장료 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-04-12"),
                money: 1579000,
                userID: "default_user",
                category: category(named: "여행")
            ),

            BasicEntry(
                title: "강의 수강",
                content: "강의 수강 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-08-15"),
                money: 524000,
                userID: "default_user",
                category: category(named: "공부")
            ),

            BasicEntry(
                title: "기프트 카드",
                content: "기프트 카드 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-08-27"),
                money: 542000,
                userID: "default_user",
                category: category(named: "선물")
            ),

            BasicEntry(
                title: "동물병원",
                content: "아침부터 동물병원 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-04-27"),
                money: 4701000,
                userID: "default_user",
                category: category(named: "반려동물")
            ),

            BasicEntry(
                title: "영화관람",
                content: "오늘은 영화관람에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-06-02"),
                money: 4175000,
                userID: "default_user",
                category: category(named: "문화생활")
            ),

            BasicEntry(
                title: "지하철 요금",
                content: "아침부터 지하철 요금 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-06-05"),
                money: 3795000,
                userID: "default_user",
                category: category(named: "교통")
            ),

            BasicEntry(
                title: "신발 구매",
                content: "신발 구매 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-06-09"),
                money: 1921000,
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
                date: date("2025-07-11"),
                money: 1566000,
                userID: "default_user",
                category: category(named: "여행")
            ),

            BasicEntry(
                title: "장난감",
                content: "장난감 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-06-09"),
                money: 4048000,
                userID: "default_user",
                category: category(named: "반려동물")
            ),

            BasicEntry(
                title: "자격증 응시료",
                content: "문득 자격증 응시료 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-06-19"),
                money: 3089000,
                userID: "default_user",
                category: category(named: "공부")
            ),

            BasicEntry(
                title: "브런치 카페",
                content: "브런치 카페 하면서 하루를 마무리했다. 음식 항목으로 기록!",
                date: date("2025-03-13"),
                money: 3445000,
                userID: "default_user",
                category: category(named: "음식")
            ),

            BasicEntry(
                title: "버스 교통카드",
                content: "오늘은 버스 교통카드에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-03-26"),
                money: 3070000,
                userID: "default_user",
                category: category(named: "교통")
            ),

            BasicEntry(
                title: "필라테스",
                content: "필라테스 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-08-27"),
                money: 4727000,
                userID: "default_user",
                category: category(named: "운동")
            ),

            BasicEntry(
                title: "가전제품 구매",
                content: "가전제품 구매 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-05-21"),
                money: 1699000,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),

            BasicEntry(
                title: "렌터카",
                content: "렌터카 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-06-26"),
                money: 1738000,
                userID: "default_user",
                category: category(named: "여행")
            ),

            BasicEntry(
                title: "기차 예매",
                content: "교통 관련으로 기차 예매에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-08-24"),
                money: 3023000,
                userID: "default_user",
                category: category(named: "교통")
            ),

            BasicEntry(
                title: "미용비",
                content: "아침부터 미용비 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-05-02"),
                money: 2957000,
                userID: "default_user",
                category: category(named: "반려동물")
            ),

            BasicEntry(
                title: "운동화",
                content: "운동화는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-04-30"),
                money: 682000,
                userID: "default_user",
                category: category(named: "운동")
            ),

            BasicEntry(
                title: "자격증 응시료",
                content: "자격증 응시료 하면서 하루를 마무리했다. 공부 항목으로 기록!",
                date: date("2025-03-17"),
                money: 2463000,
                userID: "default_user",
                category: category(named: "공부")
            ),

            BasicEntry(
                title: "시험 접수비",
                content: "문득 시험 접수비 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-08-02"),
                money: 702000,
                userID: "default_user",
                category: category(named: "공부")
            ),

            BasicEntry(
                title: "김밥천국 김밥",
                content: "아침부터 김밥천국 김밥 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-04-06"),
                money: 398000,
                userID: "default_user",
                category: category(named: "음식")
            ),

            BasicEntry(
                title: "관광지 입장료",
                content: "관광지 입장료 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-05-27"),
                money: 2214000,
                userID: "default_user",
                category: category(named: "여행")
            ),

            BasicEntry(
                title: "김밥천국 김밥",
                content: "문득 김밥천국 김밥 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-07-29"),
                money: 699000,
                userID: "default_user",
                category: category(named: "음식")
            ),

            BasicEntry(
                title: "잡비",
                content: "잡비 하면서 하루를 마무리했다. 카테고리 없음 항목으로 기록!",
                date: date("2025-08-27"),
                money: 4586000,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),

            BasicEntry(
                title: "편지지 구매",
                content: "편지지 구매 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-07-12"),
                money: 4466000,
                userID: "default_user",
                category: category(named: "선물")
            ),

            BasicEntry(
                title: "강의 수강",
                content: "강의 수강 하면서 하루를 마무리했다. 공부 항목으로 기록!",
                date: date("2025-05-19"),
                money: 1667000,
                userID: "default_user",
                category: category(named: "공부")
            ),

            BasicEntry(
                title: "자격증 응시료",
                content: "문득 자격증 응시료 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-05-07"),
                money: 394000,
                userID: "default_user",
                category: category(named: "공부")
            ),

            BasicEntry(
                title: "기타",
                content: "아침부터 기타 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-08-14"),
                money: 2097000,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),

            BasicEntry(
                title: "문구류 구매",
                content: "쇼핑 관련으로 문구류 구매에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-07-30"),
                money: 1456000,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),

            BasicEntry(
                title: "강의 수강",
                content: "강의 수강 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-06-08"),
                money: 3022000,
                userID: "default_user",
                category: category(named: "공부")
            ),

            BasicEntry(
                title: "시험 접수비",
                content: "공부 관련으로 시험 접수비에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-03-23"),
                money: 4681000,
                userID: "default_user",
                category: category(named: "공부")
            ),

            BasicEntry(
                title: "기타",
                content: "카테고리 없음 관련으로 기타에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-06-14"),
                money: 4871000,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),

            BasicEntry(
                title: "도서 구매",
                content: "도서 구매 하면서 하루를 마무리했다. 공부 항목으로 기록!",
                date: date("2025-04-30"),
                money: 1677000,
                userID: "default_user",
                category: category(named: "공부")
            ),

            BasicEntry(
                title: "편지지 구매",
                content: "오늘은 편지지 구매에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-07-24"),
                money: 2011000,
                userID: "default_user",
                category: category(named: "선물")
            ),

            BasicEntry(
                title: "서점 구경",
                content: "오늘은 서점 구경에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-05-26"),
                money: 2470000,
                userID: "default_user",
                category: category(named: "문화생활")
            ),

            BasicEntry(
                title: "병원 진료",
                content: "병원 진료 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-08-05"),
                money: 2304000,
                userID: "default_user",
                category: category(named: "건강")
            ),

            BasicEntry(
                title: "옷 쇼핑",
                content: "아침부터 옷 쇼핑 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-07-13"),
                money: 3213000,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),

            BasicEntry(
                title: "호텔 예약",
                content: "호텔 예약 하면서 하루를 마무리했다. 여행 항목으로 기록!",
                date: date("2025-04-10"),
                money: 1223000,
                userID: "default_user",
                category: category(named: "여행")
            ),

            BasicEntry(
                title: "스터디카페",
                content: "아침부터 스터디카페 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-06-03"),
                money: 2978000,
                userID: "default_user",
                category: category(named: "공부")
            ),

            BasicEntry(
                title: "고양이 모래",
                content: "반려동물 관련으로 고양이 모래에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-04-22"),
                money: 3090000,
                userID: "default_user",
                category: category(named: "반려동물")
            ),

            BasicEntry(
                title: "기타 비용",
                content: "문득 기타 비용 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-03-05"),
                money: 1603000,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),

            BasicEntry(
                title: "기타 비용",
                content: "기타 비용는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-03-08"),
                money: 4847000,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),

            BasicEntry(
                title: "병원 진료",
                content: "오늘은 병원 진료에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-06-28"),
                money: 620000,
                userID: "default_user",
                category: category(named: "건강")
            ),

            BasicEntry(
                title: "헬스장 등록",
                content: "운동 관련으로 헬스장 등록에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-08-01"),
                money: 1284000,
                userID: "default_user",
                category: category(named: "운동")
            ),

            BasicEntry(
                title: "한의원 방문",
                content: "아침부터 한의원 방문 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-05-12"),
                money: 1751000,
                userID: "default_user",
                category: category(named: "건강")
            ),

            BasicEntry(
                title: "보조식품 구매",
                content: "보조식품 구매 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-06-29"),
                money: 2925000,
                userID: "default_user",
                category: category(named: "건강")
            ),

            BasicEntry(
                title: "콘서트",
                content: "문득 콘서트 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-04-21"),
                money: 1393000,
                userID: "default_user",
                category: category(named: "문화생활")
            ),

            BasicEntry(
                title: "분식집 떡볶이",
                content: "문득 분식집 떡볶이 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-07-23"),
                money: 2071000,
                userID: "default_user",
                category: category(named: "음식")
            ),

            BasicEntry(
                title: "택시비",
                content: "오늘은 택시비에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-06-07"),
                money: 4396000,
                userID: "default_user",
                category: category(named: "교통")
            ),

            BasicEntry(
                title: "택시비",
                content: "문득 택시비 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-05-01"),
                money: 1504000,
                userID: "default_user",
                category: category(named: "교통")
            ),

            BasicEntry(
                title: "기념일 선물",
                content: "문득 기념일 선물 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-08-13"),
                money: 4572000,
                userID: "default_user",
                category: category(named: "선물")
            ),

            BasicEntry(
                title: "편지지 구매",
                content: "아침부터 편지지 구매 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-06-19"),
                money: 1868000,
                userID: "default_user",
                category: category(named: "선물")
            ),

            BasicEntry(
                title: "지하철 요금",
                content: "지하철 요금 하면서 하루를 마무리했다. 교통 항목으로 기록!",
                date: date("2025-05-25"),
                money: 680000,
                userID: "default_user",
                category: category(named: "교통")
            ),

            BasicEntry(
                title: "가전제품 구매",
                content: "아침부터 가전제품 구매 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-08-10"),
                money: 2126000,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),

            BasicEntry(
                title: "예비비",
                content: "카테고리 없음 관련으로 예비비에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-05-09"),
                money: 1986000,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),

            BasicEntry(
                title: "기차 예매",
                content: "기차 예매 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-08-24"),
                money: 4995000,
                userID: "default_user",
                category: category(named: "교통")
            ),

            BasicEntry(
                title: "맥도날드 햄버거",
                content: "맥도날드 햄버거는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-08-08"),
                money: 270000,
                userID: "default_user",
                category: category(named: "음식")
            ),

            BasicEntry(
                title: "운동화",
                content: "운동화 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-03-23"),
                money: 4354000,
                userID: "default_user",
                category: category(named: "운동")
            ),

            BasicEntry(
                title: "렌터카 결제",
                content: "아침부터 렌터카 결제 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-04-11"),
                money: 3222000,
                userID: "default_user",
                category: category(named: "교통")
            ),

            BasicEntry(
                title: "김밥천국 김밥",
                content: "김밥천국 김밥 하면서 하루를 마무리했다. 음식 항목으로 기록!",
                date: date("2025-07-06"),
                money: 4905000,
                userID: "default_user",
                category: category(named: "음식")
            ),

            BasicEntry(
                title: "꽃다발",
                content: "꽃다발 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-03-02"),
                money: 781000,
                userID: "default_user",
                category: category(named: "선물")
            ),

            BasicEntry(
                title: "택시비",
                content: "교통 관련으로 택시비에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-04-01"),
                money: 3001000,
                userID: "default_user",
                category: category(named: "교통")
            ),

            BasicEntry(
                title: "장난감",
                content: "장난감 하면서 하루를 마무리했다. 반려동물 항목으로 기록!",
                date: date("2025-07-23"),
                money: 912000,
                userID: "default_user",
                category: category(named: "반려동물")
            ),

            BasicEntry(
                title: "지하철 요금",
                content: "지하철 요금 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-06-22"),
                money: 4947000,
                userID: "default_user",
                category: category(named: "교통")
            ),

            BasicEntry(
                title: "병원 진료",
                content: "병원 진료 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-07-14"),
                money: 957000,
                userID: "default_user",
                category: category(named: "건강")
            ),

            BasicEntry(
                title: "렌터카 결제",
                content: "렌터카 결제는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-05-03"),
                money: 2164000,
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
                date: date("2025-07-22"),
                money: 2365000,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),

            BasicEntry(
                title: "전시회",
                content: "문화생활 관련으로 전시회에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-07-18"),
                money: 4703000,
                userID: "default_user",
                category: category(named: "문화생활")
            ),

            BasicEntry(
                title: "한의원 방문",
                content: "오늘은 한의원 방문에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-06-06"),
                money: 2567000,
                userID: "default_user",
                category: category(named: "건강")
            ),

            BasicEntry(
                title: "운동화",
                content: "운동화 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-07-31"),
                money: 2386000,
                userID: "default_user",
                category: category(named: "운동")
            ),

            BasicEntry(
                title: "시험 접수비",
                content: "시험 접수비 하면서 하루를 마무리했다. 공부 항목으로 기록!",
                date: date("2025-03-24"),
                money: 1163000,
                userID: "default_user",
                category: category(named: "공부")
            ),

            BasicEntry(
                title: "시험 접수비",
                content: "아침부터 시험 접수비 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-06-22"),
                money: 82000,
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
                date: date("2025-07-23"),
                money: 3831000,
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
                date: date("2025-07-09"),
                money: 326000,
                userID: "default_user",
                category: category(named: "문화생활")
            ),

            BasicEntry(
                title: "스터디카페",
                content: "아침부터 스터디카페 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-06-04"),
                money: 3922000,
                userID: "default_user",
                category: category(named: "공부")
            ),

            BasicEntry(
                title: "관광지 입장료",
                content: "관광지 입장료 하면서 하루를 마무리했다. 여행 항목으로 기록!",
                date: date("2025-08-08"),
                money: 4841000,
                userID: "default_user",
                category: category(named: "여행")
            ),

            BasicEntry(
                title: "비행기 예매",
                content: "비행기 예매 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-04-15"),
                money: 2527000,
                userID: "default_user",
                category: category(named: "여행")
            ),

            BasicEntry(
                title: "맛집 투어",
                content: "오늘은 맛집 투어에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-08-27"),
                money: 4031000,
                userID: "default_user",
                category: category(named: "여행")
            ),

            BasicEntry(
                title: "화장품 구매",
                content: "문득 화장품 구매 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-06-27"),
                money: 4869000,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),

            BasicEntry(
                title: "분식집 떡볶이",
                content: "음식 관련으로 분식집 떡볶이에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-07-26"),
                money: 1082000,
                userID: "default_user",
                category: category(named: "음식")
            ),

            BasicEntry(
                title: "렌터카",
                content: "렌터카 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-08-23"),
                money: 4048000,
                userID: "default_user",
                category: category(named: "여행")
            ),

            BasicEntry(
                title: "전시회",
                content: "문화생활 관련으로 전시회에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-06-11"),
                money: 2422000,
                userID: "default_user",
                category: category(named: "문화생활")
            ),

            BasicEntry(
                title: "렌터카",
                content: "렌터카 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-04-13"),
                money: 4601000,
                userID: "default_user",
                category: category(named: "여행")
            ),

            BasicEntry(
                title: "버스 교통카드",
                content: "교통 관련으로 버스 교통카드에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-06-06"),
                money: 343000,
                userID: "default_user",
                category: category(named: "교통")
            ),

            BasicEntry(
                title: "지하철 요금",
                content: "오늘은 지하철 요금에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-04-29"),
                money: 3891000,
                userID: "default_user",
                category: category(named: "교통")
            ),

            BasicEntry(
                title: "뮤지컬",
                content: "뮤지컬 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-05-08"),
                money: 296000,
                userID: "default_user",
                category: category(named: "문화생활")
            ),

            BasicEntry(
                title: "고양이 모래",
                content: "아침부터 고양이 모래 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-06-25"),
                money: 768000,
                userID: "default_user",
                category: category(named: "반려동물")
            ),

            BasicEntry(
                title: "뮤지컬",
                content: "뮤지컬 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-06-30"),
                money: 4563000,
                userID: "default_user",
                category: category(named: "문화생활")
            ),

            BasicEntry(
                title: "기타",
                content: "기타 하면서 하루를 마무리했다. 카테고리 없음 항목으로 기록!",
                date: date("2025-06-10"),
                money: 1989000,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),

            BasicEntry(
                title: "가전제품 구매",
                content: "문득 가전제품 구매 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-07-19"),
                money: 4365000,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),

            BasicEntry(
                title: "꽃다발",
                content: "선물 관련으로 꽃다발에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-08-12"),
                money: 1993000,
                userID: "default_user",
                category: category(named: "선물")
            ),

            BasicEntry(
                title: "브런치 카페",
                content: "브런치 카페 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-05-28"),
                money: 832000,
                userID: "default_user",
                category: category(named: "음식")
            ),

            BasicEntry(
                title: "필라테스",
                content: "필라테스 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-03-01"),
                money: 1492000,
                userID: "default_user",
                category: category(named: "운동")
            ),

            BasicEntry(
                title: "기프트 카드",
                content: "기프트 카드는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-07-15"),
                money: 2529000,
                userID: "default_user",
                category: category(named: "선물")
            ),

            BasicEntry(
                title: "운동화",
                content: "문득 운동화 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-03-01"),
                money: 1673000,
                userID: "default_user",
                category: category(named: "운동")
            ),

            BasicEntry(
                title: "렌터카",
                content: "렌터카는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-03-03"),
                money: 4617000,
                userID: "default_user",
                category: category(named: "여행")
            ),

            BasicEntry(
                title: "렌터카",
                content: "렌터카 하면서 하루를 마무리했다. 여행 항목으로 기록!",
                date: date("2025-03-28"),
                money: 4749000,
                userID: "default_user",
                category: category(named: "여행")
            ),

            BasicEntry(
                title: "편지지 구매",
                content: "문득 편지지 구매 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-04-10"),
                money: 3001000,
                userID: "default_user",
                category: category(named: "선물")
            ),

            BasicEntry(
                title: "조카 장난감",
                content: "오늘은 조카 장난감에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-04-02"),
                money: 2441000,
                userID: "default_user",
                category: category(named: "선물")
            ),

            BasicEntry(
                title: "헬스장 등록",
                content: "헬스장 등록는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-08-21"),
                money: 517000,
                userID: "default_user",
                category: category(named: "운동")
            ),

            BasicEntry(
                title: "기념일 선물",
                content: "선물 관련으로 기념일 선물에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-03-15"),
                money: 3093000,
                userID: "default_user",
                category: category(named: "선물")
            ),

            BasicEntry(
                title: "택시비",
                content: "오늘은 택시비에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-03-06"),
                money: 856000,
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
                date: date("2025-06-28"),
                money: 4665000,
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
                date: date("2025-06-09"),
                money: 2003000,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),

            BasicEntry(
                title: "관광지 입장료",
                content: "문득 관광지 입장료 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-04-06"),
                money: 4159000,
                userID: "default_user",
                category: category(named: "여행")
            ),

            BasicEntry(
                title: "보조식품 구매",
                content: "보조식품 구매 하면서 하루를 마무리했다. 건강 항목으로 기록!",
                date: date("2025-07-27"),
                money: 2869000,
                userID: "default_user",
                category: category(named: "건강")
            ),

            BasicEntry(
                title: "잡비",
                content: "잡비는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-03-31"),
                money: 70000,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),

            BasicEntry(
                title: "편지지 구매",
                content: "오늘은 편지지 구매에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-06-29"),
                money: 2748000,
                userID: "default_user",
                category: category(named: "선물")
            ),

            BasicEntry(
                title: "맥도날드 햄버거",
                content: "음식 관련으로 맥도날드 햄버거에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-07-30"),
                money: 19000,
                userID: "default_user",
                category: category(named: "음식")
            ),

            BasicEntry(
                title: "조카 장난감",
                content: "아침부터 조카 장난감 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-04-30"),
                money: 3168000,
                userID: "default_user",
                category: category(named: "선물")
            ),

            BasicEntry(
                title: "도서 구매",
                content: "도서 구매 하면서 하루를 마무리했다. 공부 항목으로 기록!",
                date: date("2025-08-31"),
                money: 3767000,
                userID: "default_user",
                category: category(named: "공부")
            ),

            BasicEntry(
                title: "문구류 구매",
                content: "문구류 구매 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-03-18"),
                money: 2260000,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),

            BasicEntry(
                title: "강아지 사료",
                content: "아침부터 강아지 사료 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-07-14"),
                money: 3254000,
                userID: "default_user",
                category: category(named: "반려동물")
            ),

            BasicEntry(
                title: "시험 접수비",
                content: "시험 접수비 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-04-28"),
                money: 4936000,
                userID: "default_user",
                category: category(named: "공부")
            ),

            BasicEntry(
                title: "강의 수강",
                content: "문득 강의 수강 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-07-13"),
                money: 785000,
                userID: "default_user",
                category: category(named: "공부")
            ),

            BasicEntry(
                title: "강의 수강",
                content: "강의 수강 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-05-30"),
                money: 1097000,
                userID: "default_user",
                category: category(named: "공부")
            ),

            BasicEntry(
                title: "보조식품 구매",
                content: "보조식품 구매 지출이 좀 컸지만 좋은 경험이었다고 생각한다.",
                date: date("2025-05-22"),
                money: 4997000,
                userID: "default_user",
                category: category(named: "건강")
            ),

            BasicEntry(
                title: "조카 장난감",
                content: "오늘은 조카 장난감에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-06-27"),
                money: 4462000,
                userID: "default_user",
                category: category(named: "선물")
            ),

            BasicEntry(
                title: "호텔 예약",
                content: "호텔 예약는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-04-10"),
                money: 1063000,
                userID: "default_user",
                category: category(named: "여행")
            ),

            BasicEntry(
                title: "장난감",
                content: "오늘은 장난감에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-05-30"),
                money: 2200000,
                userID: "default_user",
                category: category(named: "반려동물")
            ),

            BasicEntry(
                title: "PT 비용",
                content: "운동 관련으로 PT 비용에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-04-12"),
                money: 3065000,
                userID: "default_user",
                category: category(named: "운동")
            ),

            BasicEntry(
                title: "필라테스",
                content: "아침부터 필라테스 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-03-05"),
                money: 2330000,
                userID: "default_user",
                category: category(named: "운동")
            ),

            BasicEntry(
                title: "분식집 떡볶이",
                content: "분식집 떡볶이는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-04-19"),
                money: 3153000,
                userID: "default_user",
                category: category(named: "음식")
            ),

            BasicEntry(
                title: "전시회",
                content: "전시회 하면서 하루를 마무리했다. 문화생활 항목으로 기록!",
                date: date("2025-08-05"),
                money: 3554000,
                userID: "default_user",
                category: category(named: "문화생활")
            ),

            BasicEntry(
                title: "가전제품 구매",
                content: "아침부터 가전제품 구매 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-07-21"),
                money: 4173000,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),

            BasicEntry(
                title: "기차 예매",
                content: "기차 예매 하면서 하루를 마무리했다. 교통 항목으로 기록!",
                date: date("2025-04-07"),
                money: 1985000,
                userID: "default_user",
                category: category(named: "교통")
            ),

            BasicEntry(
                title: "맛집 투어",
                content: "맛집 투어는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-05-13"),
                money: 1127000,
                userID: "default_user",
                category: category(named: "여행")
            ),

            BasicEntry(
                title: "기타",
                content: "문득 기타 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-06-27"),
                money: 3538000,
                userID: "default_user",
                category: category(named: "카테고리 없음")
            ),

            BasicEntry(
                title: "보조식품 구매",
                content: "보조식품 구매 했는데 꽤 만족스러웠다. 돈은 아깝지 않았다.",
                date: date("2025-03-02"),
                money: 2407000,
                userID: "default_user",
                category: category(named: "건강")
            ),

            BasicEntry(
                title: "약국 구매",
                content: "문득 약국 구매 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-05-15"),
                money: 4876000,
                userID: "default_user",
                category: category(named: "건강")
            ),

            BasicEntry(
                title: "호텔 예약",
                content: "아침부터 호텔 예약 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-04-27"),
                money: 4691000,
                userID: "default_user",
                category: category(named: "여행")
            ),

            BasicEntry(
                title: "렌터카 결제",
                content: "렌터카 결제는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-04-20"),
                money: 1970000,
                userID: "default_user",
                category: category(named: "교통")
            ),

            BasicEntry(
                title: "옷 쇼핑",
                content: "아침부터 옷 쇼핑 준비하느라 정신 없었지만 잘 마무리되었다.",
                date: date("2025-05-20"),
                money: 430000,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),

            BasicEntry(
                title: "꽃다발",
                content: "꽃다발는 필수 지출이었다. 어쩔 수 없이 쓰게 됐다.",
                date: date("2025-07-21"),
                money: 860000,
                userID: "default_user",
                category: category(named: "선물")
            ),

            BasicEntry(
                title: "편지지 구매",
                content: "오늘은 편지지 구매에 돈을 썼다. 예상보다 많이 나왔다.",
                date: date("2025-08-30"),
                money: 564000,
                userID: "default_user",
                category: category(named: "선물")
            ),

            BasicEntry(
                title: "기념일 선물",
                content: "기념일 선물 하면서 하루를 마무리했다. 선물 항목으로 기록!",
                date: date("2025-05-09"),
                money: 1374000,
                userID: "default_user",
                category: category(named: "선물")
            ),

            BasicEntry(
                title: "가전제품 구매",
                content: "가전제품 구매 하면서 하루를 마무리했다. 쇼핑 항목으로 기록!",
                date: date("2025-07-26"),
                money: 3344000,
                userID: "default_user",
                category: category(named: "쇼핑")
            ),

            BasicEntry(
                title: "콘서트",
                content: "문화생활 관련으로 콘서트에 돈을 썼다. 잘한 선택이었길!",
                date: date("2025-04-25"),
                money: 3223000,
                userID: "default_user",
                category: category(named: "문화생활")
            ),

            BasicEntry(
                title: "필라테스",
                content: "문득 필라테스 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-04-12"),
                money: 1792000,
                userID: "default_user",
                category: category(named: "운동")
            ),

            BasicEntry(
                title: "가전제품 구매",
                content: "문득 가전제품 구매 하고 싶어서 바로 결제했다. 충동적이었지만 기분은 좋다.",
                date: date("2025-06-16"),
                money: 57000,
                userID: "default_user",
                category: category(named: "쇼핑")
            )
        ]
    }
}
