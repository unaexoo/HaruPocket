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

    init() {
        _statisticsViewModel = StateObject(wrappedValue: StatisticsViewModel(entries: []))
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                let filteredEntries = spendingViewModel.spending.filter {
                    $0.userID == spendingViewModel.username
                }

                let statisticsViewModel = StatisticsViewModel(entries: filteredEntries)

                let totalMoney = statisticsViewModel.totalMoneyForMonth(month: "2025-05")

                let (top5ByCount, top5ByMoney) = statisticsViewModel.entriesByCategoryForMonth(month: "2025-05")

                let top5ByCountItems: [DataItem] = top5ByCount.map {
                    DataItem(id: UUID(), title: $0.0, count: $0.1.count, money: $0.1.money, color: $0.1.color)
                }

                let top5ByMoneyItems: [DataItem] = top5ByMoney.map {
                    DataItem(id: UUID(), title: $0.0, count: $0.1.count, money: $0.1.money, color: $0.1.color)
                }

                HStack(spacing: 0) {
                    Text("이번 달에는 ")

                    Text("\(totalMoney)원 ")
                        .foregroundStyle(Color.lightMainColor)

                    Text("썼어요!")

                }
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.vertical, 20)

                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.gray.opacity(0.05))
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)

                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Text("어디에 가장 ")

                            Text("자주 ")
                                .foregroundStyle(Color.lightMainColor)

                            Text("썼을까?")
                        }
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top)
                        .padding(.horizontal)

                        Chart(top5ByCountItems) { element in
                            SectorMark(
                                angle: .value("Count", element.count),
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

                        Text("이번 달 최다 소비")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                            .padding(.top)

                        VStack(alignment: .leading) {
                            ForEach(top5ByCountItems) { items in
                                HStack {
                                    Circle()
                                        .fill(items.color)
                                        .frame(width: 10, height: 10)

                                    Text(items.title)
                                        .font(.callout)

                                    Spacer()

                                    Text("\(items.count)건")
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

                ZStack {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.gray.opacity(0.05))
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)

                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Text("어디에 가장 ")

                            Text("많이 ")
                                .foregroundStyle(Color.lightMainColor)

                            Text("썼을까?")
                        }
                        .font(.title3)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top)
                        .padding(.horizontal)

                        Chart(top5ByMoneyItems) { element in
                            SectorMark(
                                angle: .value("Money", element.money),
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

                        Text("이번 달 최고 소비")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal)
                            .padding(.top)

                        VStack(alignment: .leading) {
                            ForEach(top5ByMoneyItems) { items in
                                HStack {
                                    Circle()
                                        .fill(items.color)
                                        .frame(width: 10, height: 10)

                                    Text(items.title)
                                        .font(.callout)

                                    Spacer()

                                    Text("\(items.money)원")
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
            .onAppear {
                spendingViewModel.username = username
                spendingViewModel.loadEntry(context: context)

                Task {
                    await spendingViewModel.insertSampleData(context: context)
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color.lightPointColor)
                    }
                }

                ToolbarItem(placement: .principal) {
                    Text("통계")
                        .font(.title2)
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}


#Preview {
    NavigationStack {
        StatisticsView()
            .modelContainer(
                for: [BasicEntry.self, Category.self, Statics.self],
                inMemory: true
            )
            .environmentObject(SpendingViewModel())
    }
}

