//
//  CategoryListView.swift
//  HaruPocket
//
//  Created by YC on 5/13/25.
//


import SwiftUI
import SwiftData

struct CategoryListView: View {
    @Environment(\.modelContext) private var context
    @AppStorage("username") private var username: String = "default_user"

    @State private var showCateogryComposeView = false

    @StateObject private var spendingViewModel = SpendingViewModel()

    @Environment(\.dismiss) var dismiss

    // 수정사항
    let category: Category

    var body: some View {
        List {
            // 사용자의 항목 중 현재 카테고리에 해당하는 항목만 필터링하고, 날짜 기준 최신순으로 정렬
            let filtereditems = spendingViewModel.spending
                .filter { ($0.userID == spendingViewModel.username) && ($0.category?.name == category.name) }
            // 최신 날짜가 먼저 오도록 정렬
                .sorted { $0.date > $1.date }



            ForEach(filtereditems) { item in
                if let index = spendingViewModel.spending.firstIndex(where: { $0.id == item.id }) {
                    NavigationLink {
                        DetailView(basics: $spendingViewModel.spending[index])
                    } label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.title)
                                // 날짜를 yyyy.MM.dd 형식으로 표시
                                Text(formattedDate(item.date))
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Text("\(item.money)원")
                                .foregroundColor(.gray)
                        }
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
        .listStyle(.plain)
        .onAppear {
            spendingViewModel.username = username
            spendingViewModel.loadCategory(context: context)
            spendingViewModel.loadEntry(context: context)
            spendingViewModel.updateStatics(context: context)

            Task {
                await spendingViewModel.insertSampleData(context: context)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
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
                Text(category.name)
                    .font(.title2)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showCateogryComposeView = true
                } label: {
                    Image(systemName: "pencil")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.lightPointColor)
                }
            }
        }
        .navigationDestination(isPresented: $showCateogryComposeView) {
            CategoryEditView()
        }
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
        CategoryListView(category: Category(
            name: "음식",
            color: .blue,
            emoji: "💡",
            userID: "default_user"
        ) )
        .modelContainer(
            for: [BasicEntry.self, Category.self, Statics.self],
            inMemory: true
        )
    }
}
