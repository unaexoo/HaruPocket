//
//  CategoryListView.swift
//  HaruPocket
//
//  Created by YC on 5/13/25.
//


import SwiftUI
import SwiftData

/// `CategoryListView`는 특정 카테고리에 해당하는 소비 항목을 리스트로 보여주는 뷰입니다.
/// - category 값이 nil이면 전체 소비 기록을 보여주고,
/// - category가 지정되어 있으면 해당 카테고리와 일치하는 항목만 필터링하여 보여줍니다.
/// - 각 항목은 NavigationLink를 통해 상세 뷰로 이동할 수 있으며, 스와이프를 통해 삭제 기능도 제공합니다.
struct CategoryListView: View {
    @Environment(\.modelContext) private var context
    @AppStorage("username") private var username: String = "default_user"

    @EnvironmentObject var spendingViewModel: SpendingViewModel

    @Environment(\.dismiss) var dismiss

    // 수정사항
    @Binding var category: Category?

    private let columns = [
        GridItem(.adaptive(minimum: 600, maximum: .infinity), spacing: nil, alignment: nil),
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                // 필터링 조건:
                // - category가 nil이 아닌 경우:
                //     해당 사용자의 항목 중에서 category 이름이 현재 선택된 category와 일치하는 항목만 필터링
                // - category가 nil인 경우:
                //     사용자 ID만 확인하여 전체 소비 항목을 필터링 없이 모두 보여줌 (전체 보기 용도)
                let allSpending = spendingViewModel.spending
                let filtereditems = allSpending
                    .filter { category != nil ? ($0.userID == spendingViewModel.username) && ($0.category?.name == category?.name) : ($0.userID == spendingViewModel.username) }
                // 최신 날짜가 먼저 오도록 정렬
                    .sorted { $0.date > $1.date }

                ForEach(filtereditems) { item in
                    let entryID = item.id
                    if let index = allSpending.firstIndex(where: { $0.id == entryID }) {
                        NavigationLink {
                            DetailView(basics: $spendingViewModel.spending[index])
                        } label: {
                            VStack(spacing: 0) {
                                Divider()
                                    .padding(.horizontal, 20)

                                HStack {
                                    VStack(alignment: .leading) {
                                        Text(item.title)
                                            .foregroundStyle(Color.primary)

                                        // 날짜를 yyyy.MM.dd 형식으로 표시
                                        Text(formattedDate(item.date))
                                            .font(.footnote)
                                    }

                                    Spacer()

                                    Text("\(item.money)원")

                                    Image(systemName: "chevron.forward")
                                }
                                .foregroundStyle(.gray)
                                .padding(.top, 10)
                                .padding(.horizontal, 20)
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        // SwiftData에서 해당 항목 삭제
                                        context.delete(item)
                                        try? context.save()

                                        // ViewModel에서도 제거
                                        spendingViewModel.spending.remove(at: index)
                                    } label: {
                                        Label("삭제", systemImage: "trash")
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .listStyle(.plain)
            .onAppear {
                spendingViewModel.loadEntry(context: context)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                if category != nil {
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
                }
                ToolbarItem(placement: .principal) {
                    Text(category?.name ?? "나의 모든 소비 기록")
                        .font(.title2)
                }
            }
        }
        .scrollIndicators(.hidden)
    }

    // 날짜를 yyyy.MM.dd 형식으로 변환해주는 포맷터 함수
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
    }
}


#Preview {
    NavigationStack {
        CategoryListView(category: .constant(Category(
            name: "음식",
            color: .blue,
            emoji: "💡",
            userID: "default_user"
        )))
        .modelContainer(
            for: [BasicEntry.self, Category.self],
            inMemory: true
        )
        .environmentObject(SpendingViewModel())
    }
}

#Preview {
    NavigationStack {
        CategoryListView(category: .constant(nil))
            .modelContainer(
                for: [BasicEntry.self, Category.self],
                inMemory: true
            )
            .environmentObject(SpendingViewModel())
    }
}
