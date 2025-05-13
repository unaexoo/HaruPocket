//
//  ComposeView.swift
//  HaruPocket
//
//  Created by 장지현 on 5/12/25.
//

import SwiftUI
import SwiftData

enum FieldType: Int, Hashable {
    case title
    case money
    case content
}

struct ComposeView: View {
    //    @AppStorage("userID") var userID: String = ""

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    @State private var date = Date.now // FIXME: 홈뷰에서 선택한 날짜 넘겨받아야함
    @State private var selectedCategory: Category?
    //    @State private var categories: [Category] = []
    @State private var presentModal: Bool = false
    @State private var title: String = ""
    @State private var money: String = ""
    @State private var content: String = ""
    @State private var img: String = ""

    @FocusState private var focused: FieldType?

    //    @Query var categories: [Category]
    let categories = Category.sampleList
    var basics: BasicEntry? = nil

    var body: some View {
        VStack {
            Button {
                print("이미지 버튼 클릭")
            } label: {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .tint(Color.lightPointColor)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

            }
            .overlay {
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.lightPointColor, lineWidth: 1)
            }
            .padding(.vertical)

            Grid(verticalSpacing: 20) {
                GridRow {
                    HStack {
                        VStack(spacing: 5) {
                            Text("작성 날짜")
                                .font(.callout)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 10)

                            Text(basics?.date ?? date, style: .date)
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.lightPointColor, lineWidth: 1)
                                }
                                .overlay {
                                    // TODO: 더 좋은 방법이 있을까?
                                    DatePicker("작성 날짜", selection: $date, displayedComponents: .date)
                                        .frame(maxWidth: .infinity)
                                        .labelsHidden()
                                        .colorMultiply(.clear)
                                }
                        }

                        VStack(spacing: 5) {
                            Text("카테고리")
                                .font(.callout)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 10)

                            if categories.count <= 6 {
                                Menu {
                                    Button {
                                        // FIXME: CategoryComposeView Push
                                    } label: {
                                        Label("새로운 카테고리", systemImage: "plus")
                                    }
                                    
                                    ForEach(categories) { category in
                                        Button {
                                            selectedCategory = category
                                        } label: {
                                            Text(category.name)

                                            if category == selectedCategory {
                                                Spacer()
                                                Image(systemName: "checkmark")
                                            }
                                        }
                                    }
                                } label: {
                                    HStack(spacing: 2) {
                                        let category = selectedCategory ?? basics?.category

                                        HStack(spacing: 2) {
                                            Text(category?.name ?? "카테고리 선택")
                                                .tint(category == nil ? .secondary : .primary)
                                                .frame(maxWidth: .infinity, alignment: .leading)

                                            if let category {
                                                Text(category.emoji)
                                                    .font(.footnote)
                                                    .padding(7)
                                                    .background(category.color)
                                                    .clipShape(Circle())
                                                    .frame(maxHeight: 10)
                                            }

                                            Image(systemName: "chevron.right")
                                                .foregroundStyle(Color.lightPointColor)
                                        }
                                    }
                                    .padding()
                                }
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.lightPointColor, lineWidth: 1)
                                }
                            } else {
                                Button {
                                    presentModal = true
                                } label: {
                                    let category = selectedCategory ?? basics?.category

                                    Text(category?.name ?? "카테고리 선택")
                                        .tint(category == nil ? .secondary : .primary)
                                        .frame(maxWidth: .infinity, alignment: .leading)

                                    if let category {
                                        Text(category.emoji)
                                            .font(.footnote)
                                            .padding(7)
                                            .background(category.color)
                                            .clipShape(Circle())
                                            .frame(maxHeight: 10)
                                    }

                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(Color.lightPointColor)
                                }
                                .padding()
                                .overlay {
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.lightPointColor, lineWidth: 1)
                                }
                            }
                        }
                    }
                }

                GridRow {
                    textFieldView(value: $title, focused: $focused, title: "제목", fieldType: .title, basics: basics)
                }

                GridRow {
                    textFieldView(value: $money, focused: $focused, title: "가격", fieldType: .money, basics: basics)
                }

                GridRow {
                    textFieldView(value: $content, focused: $focused, title: "내용", fieldType: .content, basics: basics)
                }
            }

        }
        .padding()
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
                Text("제목입력")
                    .font(.title2)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // TODO: SwiftData 저장 로직 구현
                } label: {
                    Text("완료")
                        .font(.title3)
                        .foregroundColor(Color.lightPointColor)
                }
            }
        }
        .environment(\.locale, Locale(identifier: "ko_kr"))
        .sheet(isPresented: $presentModal) {
                SelectCategoryView { item in
                    selectedCategory = item
                    presentModal = false
                }
//                    .presentationDetents([.medium, .large]) // half sheet
        }
        //        .onAppear {
        //            fetchCategories()
        //        }
    }

    //    private func fetchCategories() {
    //        let descriptor = FetchDescriptor<Category>(
    //            predicate: #Predicate { $0.userID == userID }
    //        )
    //        do {
    //            categories = try context.fetch(descriptor)
    //        } catch {
    //            print("Fetch error: \(error)")
    //        }
    //    }
}

#Preview("Create") {
    NavigationStack {
        ComposeView(basics: BasicEntry(
            title: "샘플 소비",
            content: "테스트",
            date: Date(),
            money: 10000,
            userID: "default_user",
            category: Category(
                name: "테스트",
                color: .blue,
                emoji: "💡",
                userID: "default_user"
            )
        ))
    }
}

#Preview("Update") {
    NavigationStack {
        ComposeView()
    }
}

struct textFieldView: View {
    @Binding var value: String
    @FocusState<FieldType?>.Binding var focused: FieldType?
    var title: String
    var fieldType: FieldType
    var basics: BasicEntry?

    var body: some View {
        VStack(spacing: 5) {
            Text(title)
                .font(.callout)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 10)

            HStack {
                TextField(title, text: $value)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)

                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .focused($focused, equals: fieldType)
                    .submitLabel(title != "내용" ? .next : .done)
                    .onSubmit {
                        switch fieldType {
                        case .title:
                            focused = .money
                        case .money:
                            focused = .content
                        case .content:
                            focused = nil
                        }
                    }
                    .onAppear{
                        if let basics {
                            switch fieldType {
                            case .title:
                                value = basics.title
                            case .money:
                                value = String(basics.money)
                            case .content:
                                value = basics.content ?? ""
                            }
                        }
                    }

                Text(title == "가격" ? "원" : "")
                    .padding(.horizontal)
            }
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.lightPointColor, lineWidth: 1)
            }

        }
    }
}
