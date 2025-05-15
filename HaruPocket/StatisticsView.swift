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
                    spendingViewModel.username = username
                    spendingViewModel.loadEntry(context: context)

                    Task {
                        await spendingViewModel.insertSampleData(context: context)
                    }
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
    func computeStatistics()
    -> (totalMoney: Int, top5ByCountItems: [DataItem], top5ByMoneyItems: [DataItem]) {
        let filteredEntries = spendingViewModel.spending.filter {
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

    func formattedDate(from date: Date?, format: String = "yyyy년 MM월") -> String? {
        guard let date else { return nil }

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = format
        let formattedDate = formatter.string(from: date)

        return formattedDate
    }

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
