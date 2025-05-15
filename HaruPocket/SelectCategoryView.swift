//
//  SelectCategoryView.swift
//  HaruPocket
//
//  Created by 장지현 on 5/13/25.
//

import SwiftUI

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
                let categories = spendingViewModel.categories.filter {
                    $0.userID == spendingViewModel.username
                }

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
            .onAppear {
                spendingViewModel.username = username
                spendingViewModel.loadCategory(context: context)

                Task {
                    await spendingViewModel.insertSampleData(context: context)
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .listStyle(.plain)
            .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Text("취소")
                                .font(.title3)
                                .foregroundColor(Color.lightPointColor)
                        }
                    }

                    ToolbarItem(placement: .principal) {
                        Text("카테고리 선택")
                            .font(.title2)
                    }

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
            .toolbarBackground(colorScheme == .dark ? Color(.systemBackground) : Color.creamWhite, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationDestination(isPresented: $showCategoryComposeView) {
                CategoryComposeView(category: .constant(nil))
            }
        }
    }
}

#Preview {
    SelectCategoryView { selected in
        print("선택된 값: \(selected!.name)")
    }
}
