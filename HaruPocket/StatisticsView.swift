//
//  StatisticsView.swift
//  HaruPocket
//
//  Created by 장지현 on 5/13/25.
//

import SwiftUI
import Charts
import SwiftData

struct DataItem: Identifiable {
    let id: UUID
    let title: String
    let count: Int
    let money: Int
    let color: Color
}

/// 사용자의 소비 내역을 월별로 분석해 통계 차트로 보여주는 화면입니다.
///
/// - 날짜 선택 및 이전/다음 달 이동 기능을 제공합니다.
/// - 해당 월의 총 소비 금액을 요약하여 보여줍니다.
/// - 소비 내역이 없을 경우 안내 메시지와 이미지를 표시합니다.
/// - 월별로 소비 카테고리별 Top 5(최다/최고) 항목을 차트와 리스트로 시각화합니다.
/// - 월 변경, 차트 표시, 통계 요약 등 다양한 사용자 상호작용을 지원합니다.
struct StatisticsView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    @AppStorage("username") private var username: String = "default_user"
    @EnvironmentObject var spendingViewModel: SpendingViewModel
    @StateObject private var statisticsViewModel: StatisticsViewModel

    @State private var date = Date.now
    @State private var isExpenseListEmpty = false
    @State private var totalMoney: Int = 0
    @State private var top5ByCountItems: [DataItem] = []
    @State private var top5ByMoneyItems: [DataItem] = []

    let screenHeight = UIScreen.main.bounds.height

    init() {
        _statisticsViewModel = StateObject(wrappedValue: StatisticsViewModel(entries: []))
    }

    var body: some View {
        ScrollView {
            HStack {
                Button {
                    date = changeMonth(by: -1, from: date)
                } label: {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                        .foregroundColor(Color.lightPointColor)
                }

                Spacer()

                Text(formattedDate(from: date) ?? "\(date)")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .overlay {
                        DatePicker("날짜", selection: $date, displayedComponents: .date)
                            .labelsHidden()
                            .colorMultiply(.clear)
                    }

                Spacer()

                Button {
                    date = changeMonth(by: 1, from: date)
                } label: {
                    Image(systemName: "chevron.forward")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                        .foregroundColor(Color.lightPointColor)
                }
            }
            .padding(.top)
            .padding(.horizontal)


            if isExpenseListEmpty {
                VStack {
                    Text("아직 사용한 금액이 없어요!")
                        .font(.title2)
                        .padding()

                    Text("지갑 속 하루를 기록해볼까요?")
                        .font(.title)
                        .foregroundStyle(Color.lightPointColor)

                    Image("pocket")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                }
                .padding(.top, screenHeight/5)
            } else {
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text("이번 달에는 ")

                        Text("\(totalMoney)원 ")
                            .foregroundStyle(Color.lightMainColor)
                            .fontWeight(.semibold)

                        Text("썼어요!")

                    }
                    .font(.title2)
                    .padding()
                    .padding(.top, 20)

                    ChartView(title: "최대", dataItems: top5ByMoneyItems)

                    ChartView(title: "최다", dataItems: top5ByCountItems)
                }
                .onAppear {
                    spendingViewModel.loadEntry(context: context)

                    let (total, countItems, moneyItems) = computeStatistics()
                    totalMoney = total
                    top5ByCountItems = countItems
                    top5ByMoneyItems = moneyItems
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("통계")
                    .font(.title2)
            }
        }
        .scrollIndicators(.hidden)
        .onChange(of: date) {
            let (total, countItems, moneyItems) = computeStatistics()
            totalMoney = total
            top5ByCountItems = countItems
            top5ByMoneyItems = moneyItems
        }
    }
}

extension StatisticsView {
    /// 현재 선택된 월에 대한 통계 데이터를 계산합니다.
    /// 전체 금액, 최다 소비 카테고리 top5, 최고 소비 금액 카테고리 top5를 구합니다.
    /// - Returns: 총 사용 금액, 사용 횟수 기준 top5 항목 목록, 사용 금액 기준 top5 항목 목록
    func computeStatistics()
    -> (totalMoney: Int, top5ByCountItems: [DataItem], top5ByMoneyItems: [DataItem]) {
        let allSpending = spendingViewModel.spending
        let filteredEntries = allSpending.filter {
            $0.userID == spendingViewModel.username
        }

        let statisticsViewModel = StatisticsViewModel(entries: filteredEntries)

        let totalMoney = statisticsViewModel.totalMoneyForMonth(month: formattedDate(from: date, format: "yyyy-MM") ?? "2025-05")

        DispatchQueue.main.async {
            isExpenseListEmpty = (totalMoney == 0)
        }

        let (top5ByCount, top5ByMoney) = statisticsViewModel.entriesByCategoryForMonth(month: formattedDate(from: date, format: "yyyy-MM") ?? "2025-05")

        let top5ByCountItems: [DataItem] = top5ByCount.map {
            DataItem(id: UUID(), title: $0.0, count: $0.1.count, money: $0.1.money, color: $0.1.color)
        }

        let top5ByMoneyItems: [DataItem] = top5ByMoney.map {
            DataItem(id: UUID(), title: $0.0, count: $0.1.count, money: $0.1.money, color: $0.1.color)
        }

        return (totalMoney, top5ByCountItems, top5ByMoneyItems)
    }

    /// 주어진 날짜를 지정된 포맷으로 포맷팅합니다.
    /// - Parameters:
    ///   - date: 변환할 날짜
    ///   - format: 사용할 날짜 포맷 (기본값: "yyyy년 MM월")
    /// - Returns: 포맷팅된 날짜 문자열
    func formattedDate(from date: Date?, format: String = "yyyy년 MM월") -> String? {
        guard let date else { return nil }

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = format
        let formattedDate = formatter.string(from: date)

        return formattedDate
    }

    /// 기준 날짜에서 주어진 개월 수만큼 더하거나 뺀 날짜를 반환합니다.
    /// - Parameters:
    ///   - value: 더하거나 뺄 개월 수 (음수면 이전 달, 양수면 다음 달)
    ///   - date: 기준 날짜
    /// - Returns: 계산된 새로운 날짜
    func changeMonth(by value: Int, from date: Date) -> Date {
        Calendar.current.date(byAdding: .month, value: value, to: date) ?? date
    }
}

#Preview {
    NavigationStack {
        StatisticsView()
            .modelContainer(
                for: [BasicEntry.self, Category.self],
                inMemory: true
            )
            .environmentObject(SpendingViewModel())
    }
}

/// 소비 데이터를 시각화하여 파이 차트와 목록 형태로 보여주는 뷰입니다.
/// - title에 따라 '최다' 또는 '최대' 소비 정보를 구분해서 보여줍니다.
/// - 데이터 항목은 SectorMark를 이용해 원형 차트로 표현됩니다.
struct ChartView: View {
    let title: String
    let dataItems: [DataItem]

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.gray.opacity(0.05))
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Text("어디에 가장 ")

                    Text(title == "최다" ? "자주" : "많이")
                        .foregroundStyle(Color.lightMainColor)

                    Text(" 썼을까?")
                }
                .font(.title3)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top)
                .padding(.horizontal)

                Chart(dataItems) { element in
                    SectorMark(
                        angle: .value("angle", title == "최다" ? element.count : element.money),
                        innerRadius: .ratio(0.618),
                        angularInset: 1.5
                    )
                    .cornerRadius(10.0)
                    .foregroundStyle(element.color.opacity(0.7))
                }
                .chartLegend(alignment: .center, spacing: 18)
                .chartLegend(.hidden)
                .padding()
                .scaledToFit()
                .frame(width: 300, height: 300)

                Text(title == "최다" ? "이번 달 최다 소비 Top 5" : "이번 달 최고 소비 Top 5")
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top)

                VStack(alignment: .leading) {
                    ForEach(dataItems) { items in
                        HStack {
                            Circle()
                                .fill(items.color)
                                .frame(width: 10, height: 10)

                            Text(items.title)
                                .font(.callout)

                            Spacer()

                            Text(title == "최다" ? "\(items.count)건" : "\(items.money)원")
                                .font(.callout)
                                .foregroundStyle(.gray)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                .padding(.vertical, 10)

            }
            .padding(20)
        }
    }
}
