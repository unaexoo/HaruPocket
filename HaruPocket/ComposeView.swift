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
    @AppStorage("username") private var username: String = "default_user"

    @EnvironmentObject var spendingViewModel: SpendingViewModel

    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    // FIXME: 홈뷰에서 선택한 날짜 넘겨받아야함
    @State private var date = Date.now
    @State private var selectedCategory: Category?
    @State private var presentModal: Bool = false
    @State private var title: String = ""
    @State private var money: String = ""
    @State private var content: String = ""
    @State private var img: String = ""

    @FocusState private var focused: FieldType?

    @Binding var basics: BasicEntry?

    var body: some View {
        ScrollView {
            VStack {
                Button {
                    // TODO: 이미지피커
                    print("이미지 버튼 클릭")
                } label: {
                    if let uiImage = basics?.image {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 250)
                            .frame(width: 360)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                    }
                    else {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .tint(Color.lightPointColor)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.lightPointColor, lineWidth: 1)
                }
                .frame(height: 250)
                .frame(width: 360)
                .padding(.bottom)

                Grid(verticalSpacing: 20) {
                    GridRow {
                        HStack {
                            VStack(spacing: 5) {
                                Text("작성 날짜")
                                    .font(.callout)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 10)

                                Text(date, style: .date)
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

                                let categories = spendingViewModel.categories.filter {
                                    $0.userID == spendingViewModel.username
                                }

                                if categories.count <= 6 {
                                    SelectCategoryByMenu(selectedCategory: $selectedCategory, basics: $basics, categories: categories)
                                } else {
                                    SelectCategoryBySheet(presentModal: $presentModal, selectedCategory: $selectedCategory, basics: $basics)
                                }
                            }
                        }
                    }

                    GridRow {
                        textFieldView(value: $title, focused: $focused, basics: $basics, title: "제목", fieldType: .title)
                    }

                    GridRow {
                        textFieldView(value: $money, focused: $focused, basics: $basics, title: "가격", fieldType: .money)
                    }

                    GridRow {
                        VStack(spacing: 5) {
                            Text("내용")
                                .font(.callout)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 10)

                            HStack {
                                TextEditor(text: $content)
                                    .padding()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
                                    .textInputAutocapitalization(.never)
                                    .autocorrectionDisabled()
                                    .focused($focused, equals: .content)
                                    .submitLabel(.done)
                                    .onSubmit {
                                        focused = nil
                                    }
                                    .onAppear{
                                        content = basics?.content ?? ""
                                    }
                                    .scrollIndicators(.hidden)
                            }
                            .overlay {
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.lightPointColor, lineWidth: 1)
                            }

                        }
                    }
                }

            }
            .padding()
            .onAppear {
                spendingViewModel.username = username
                spendingViewModel.loadCategory(context: context)

                if let basics {
                    self.date = basics.date
                }

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
                    Text(formattedDate(from: basics?.date) ?? "새로운 소비")
                        .font(.title2)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        save()
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
            }
        }
        .scrollIndicators(.hidden)
    }
}

extension ComposeView {
    func save() {
        if let basics {
            basics.title = title
            basics.money = Int(money) ?? 0
            basics.content = content
            basics.date = date
            basics.imageFileName = img
            basics.category = selectedCategory ?? basics.category
        } else {
            let newEntry = BasicEntry(
                title: title,
                content: content,
                date: date,
                money: Int(money) ?? 0,
                imageFileName: img,
                userID: username,
                category: selectedCategory
            )
            context.insert(newEntry)
        }

        do {
            try context.save()
            dismiss()
        } catch {
            print("저장 실패: \(error.localizedDescription)")
        }
    }

    func formattedDate(from date: Date?) -> String? {
        guard let date else { return nil }

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateStyle = .long
        formatter.timeStyle = .none

        return formatter.string(from: date)
    }
}

#Preview("Update") {
    NavigationStack {
        ComposeView(basics: .constant(BasicEntry(
            title: "샘플 이미지 항목 1",
            content: "테스트용 이미지가 포함된 항목입니다. 테스트용 이미지가 포함된 항목입니다. 테스트용 이미지가 포함된 항목입니다.테스트용 이미지가 포함된 항목입니다. 테스트용 이미지가 포함된 항목입니다. 테스트용 이미지가 포함된 항목입니다.테스트용 이미지가 포함된 항목입니다. 테스트용 이미지가 포함된 항목입니다. 테스트용 이미지가 포함된 항목입니다.테스트용 이미지가 포함된 항목입니다. 테스트용 이미지가 포함된 항목입니다. 테스트용 이미지가 포함된 항목입니다.테스트용 이미지가 포함된 항목입니다. 테스트용 이미지가 포함된 항목입니다. 테스트용 이미지가 포함된 항목입니다.테스트용 이미지가 포함된 항목입니다. 테스트용 이미지가 포함된 항목입니다. 테스트용 이미지가 포함된 항목입니다.",
            date: Date(),
            money: 42494,
            imageFileName: "gift.jpg",
            userID: "default_user",
            category: Category(
                name: "테스트",
                color: .blue,
                emoji: "💡",
                userID: "default_user"
            ))))
        .modelContainer(
            for: [BasicEntry.self, Category.self, Statics.self],
            inMemory: true
        )
        .environmentObject(SpendingViewModel())
    }
}

#Preview("Create") {
    NavigationStack {
        ComposeView(basics: .constant(nil))
            .modelContainer(
                for: [BasicEntry.self, Category.self, Statics.self],
                inMemory: true
            )
            .environmentObject(SpendingViewModel())
    }
}

struct textFieldView: View {
    @Binding var value: String
    @FocusState<FieldType?>.Binding var focused: FieldType?
    @Binding var basics: BasicEntry?

    var title: String
    var fieldType: FieldType

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
                    .submitLabel(.next)
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

struct SelectCategoryByMenu: View {
    @Binding var selectedCategory: Category?
    @Binding var basics: BasicEntry?
    let categories: [Category]
    var currentCategory: Category? {
        selectedCategory ?? basics?.category
    }

    var body: some View {
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
                HStack(spacing: 2) {
                    Text(currentCategory?.name ?? "카테고리 선택")
                        .tint(currentCategory == nil ? .secondary : .primary)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    if let category = currentCategory {
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
    }
}

struct SelectCategoryBySheet: View {
    @Binding var presentModal: Bool
    @Binding var selectedCategory: Category?
    @Binding var basics: BasicEntry?

    var currentCategory: Category? {
        selectedCategory ?? basics?.category
    }

    var body: some View {
        Button {
            presentModal = true
        } label: {
            Text(currentCategory?.name ?? "카테고리 선택")
                .tint(currentCategory == nil ? .secondary : .primary)
                .frame(maxWidth: .infinity, alignment: .leading)

            if let category = currentCategory {
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
