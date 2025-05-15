//
//  SelectCategoryView.swift
//  HaruPocket
//
//  Created by 장지현 on 5/13/25.
//

import SwiftUI

/// 사용자가 카테고리를 선택할 수 있는 화면입니다.
/// 기존 카테고리를 리스트에서 선택하거나 새 카테고리를 추가할 수 있습니다.
struct SelectCategoryView: View {
    @AppStorage("username") private var username: String = "default_user"

    @EnvironmentObject var spendingViewModel: SpendingViewModel

    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) private var colorScheme

    @State private var selected: Category? = nil
    @State private var showCategoryComposeView = false

    let onSelect: (Category?) -> Void

    var body: some View {
        NavigationStack {
            VStack {
                let allCategories = spendingViewModel.categories
                // 현재 사용자에 해당하는 카테고리만 필터링하고 이름 기준으로 정렬
                let categories = allCategories.filter {
                    $0.userID == spendingViewModel.username
                }
                    .sorted { $0.name < $1.name }

                // 카테고리 리스트 및 새 카테고리 추가 버튼 표시
                List(selection: $selected) {
                    Button {
                        showCategoryComposeView = true
                    } label: {
                        Label("새로운 카테고리", systemImage: "plus")
                    }
                    .foregroundStyle(.primary)

                    ForEach(categories) { category in
                        HStack {
                            Circle()
                                .fill(category.color)
                                .frame(width: 10, height: 10)
                                .padding(.trailing)

                            Text(category.name)
                                .foregroundColor(selected == category ? Color.lightPointColor : .primary)

                            Spacer()

                            if selected == category {
                                Image(systemName: "checkmark")
                                    .foregroundColor(Color.lightPointColor)
                            }
                        }
                        .listRowBackground(Color.clear)
                        .tag(category)
                    }
                }
                .scrollIndicators(.hidden)
            }
            // 뷰가 나타날 때 카테고리를 로드합니다.
            .onAppear {
                spendingViewModel.loadCategory(context: context)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
            .toolbar {
                // 취소 버튼: 화면 닫기
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("취소")
                            .font(.title3)
                            .foregroundColor(Color.lightPointColor)
                    }
                }

                // 타이틀 표시
                ToolbarItem(placement: .principal) {
                    Text("카테고리 선택")
                        .font(.title2)
                }

                // 완료 버튼: 선택한 카테고리 전달
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        onSelect(selected)
                    } label: {
                        Text("완료")
                            .font(.title3)
                            .foregroundColor(selected == nil ? .gray : Color.lightPointColor)
                    }
                    .disabled(selected == nil)
                }
            }
            // 네비게이션 바 배경색 설정
            .toolbarBackground(colorScheme == .dark ? Color(.systemBackground) : Color.creamWhite, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            // 새 카테고리 추가 화면으로 이동
            .navigationDestination(isPresented: $showCategoryComposeView) {
                CategoryComposeView(category: .constant(nil))
                    // 새 카테고리 추가 화면에서 돌아올 때 카테고리 목록을 다시 로드
                    .onDisappear {
                        spendingViewModel.hasLoadedCategory = false
                        spendingViewModel.loadCategory(
                            context: context
                        )
                    }
            }
        }
    }
}

#Preview {
    SelectCategoryView { selected in
        print("선택된 값: \(selected?.name ?? "카테고리 없음")")
    }
    .modelContainer(
        for: [BasicEntry.self, Category.self],
        inMemory: true
    )
    .environmentObject(SpendingViewModel())
}
