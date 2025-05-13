//
//  SelectCategoryView.swift
//  HaruPocket
//
//  Created by 장지현 on 5/13/25.
//

import SwiftUI

struct SelectCategoryView: View {
    let onSelect: (Category?) -> Void

    @Environment(\.dismiss) var dismiss
    @Environment(\.editMode) private var editMode
    @State private var selected: Category? = nil

    let categories = Category.sampleList

    var body: some View {
        NavigationStack {
            VStack {
                List(selection: $selected) {
                    Button {
                        // FIXME: CategoryComposeView Push
                    } label: {
                        Label("새로운 카테고리", systemImage: "plus")
                    }
                    .foregroundStyle(.primary)

                    ForEach(categories) { category in
                        HStack {
                            Text(category.name)
                                .foregroundColor(selected == category ? Color.lightPointColor : .primary)

                            Spacer()

                            if selected == category {
                                Image(systemName: "checkmark")
                                    .foregroundColor(Color.lightPointColor)
                            }
                        }
                        .listRowBackground(Color.white)
                        .tag(category)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
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
        }
        .onAppear {
            editMode?.wrappedValue = .active
        }
    }
}

#Preview {
    SelectCategoryView { selected in
        print("선택된 값: \(selected!.name)")
    }
}
