//
//  CategoryView.swift
//  HaruPocket
//
//  Created by YC on 5/12/25.
//

import SwiftUI

/// `CategoryView`는 사용자에게 등록된 모든 카테고리를 그리드 형태로 보여주는 뷰입니다.
/// - 각 카테고리는 이모지와 색상을 포함한 카드로 표현되며, 선택 시 해당 카테고리의 소비 내역 화면으로 이동합니다.
/// - 오른쪽 상단 버튼을 통해 카테고리 편집 화면으로 이동할 수 있으며,
/// - 오른쪽 하단 플로팅 버튼을 통해 새 카테고리를 추가할 수 있습니다.
struct CategoryView: View {
    @AppStorage("username") private var username: String = "default_user"

    @EnvironmentObject var spendingViewModel: SpendingViewModel

    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss

    @State private var showCategoryListComposeView = false
    @State private var showCategoryComposeView = false

    // 2열 세로 그리드를 위한 열(column) 구성 설정
    // .flexible()을 사용해 화면 너비에 맞게 유연하게 칼럼 너비가 조정됨
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
    }

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        let categories = spendingViewModel.categories
                            .filter { $0.userID == spendingViewModel.username }
                            .sorted {
                                if $0.name == "카테고리 없음" { return false }
                                if $1.name == "카테고리 없음" { return true }
                                return $0.name < $1.name
                            }

                        ForEach(categories, id: \.id) { category in
                            if let index = spendingViewModel.categories.firstIndex(where: { $0.id == category.id }) {

                                let binding = Binding<Category?>(
                                            get: { spendingViewModel.categories[index] },
                                            set: { newValue in
                                                if let newValue {
                                                    spendingViewModel.categories[index] = newValue
                                                }
                                            })

                                NavigationLink(destination: CategoryListView(category: binding)) {
                                    VStack(spacing: 8) {
                                        Text(category.emoji)
                                            .font(.system(size: 60))
                                        Text(category.name)
                                            .font(.title3)
                                            .foregroundColor(.black)
                                    }
                                    .frame(width: 160, height: 160)
                                    .background(category.color)
                                    .cornerRadius(25)
                                    .shadow(radius: 0.3)
                                }
                            }
                        }
                    }
                    .padding()
                }
                .scrollIndicators(.hidden)

                // 플로팅 버튼
                Button {
                    showCategoryComposeView = true
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.lightMainColor)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
                .padding()
            }

        }
        .onAppear {
            spendingViewModel.username = username
            spendingViewModel.loadCategory(context: context)

            Task {
                await spendingViewModel.insertSampleData(context: context)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("카테고리")
                    .font(.title2)
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showCategoryListComposeView = true
                } label: {
                    Image(systemName: "checklist")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color.lightPointColor)
                }
            }
        }
        .navigationDestination(isPresented: $showCategoryListComposeView) {
            CategoryListComposeView()
        }
        .navigationDestination(isPresented: $showCategoryComposeView) {
            CategoryComposeView(category: .constant(nil))
        }
    }
}


#Preview {
    NavigationStack {
        CategoryView()
    }
    .modelContainer(
        for: [BasicEntry.self, Category.self, Statics.self],
        inMemory: true
    )
    .environmentObject(SpendingViewModel())
}
