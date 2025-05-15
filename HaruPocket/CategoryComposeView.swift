//
//  CategoryComposeView.swift
//  HaruPocket
//
//  Created by 고재현 on 5/14/25.
//

import SwiftUI
import EmojiPicker

struct CategoryComposeView: View {
    @State private var name: String = ""
    @State private var selectedColor: Color = Color.lightMainColor
    @State private var selectedEmoji: String = "🫥"
    @State private var isColorPickerVisible: Bool = false
    @State private var isEmojiPickerVisible: Bool = false

    @AppStorage("username") private var username: String = "default_user"

    @EnvironmentObject var spendingViewModel: SpendingViewModel

    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme

    @Binding var category: Category?

    // 다크모드에 대응
    private var pointColor: Color {
        colorScheme == .dark ? .darkPointColor : .lightPointColor
    }

    private var textColor: Color {
        colorScheme == .dark ? .creamWhite : .black
    }

    var body: some View {
        VStack(spacing: 30) {
            VStack(alignment: .leading, spacing: 4) {
                Text("제목")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.leading, 10)

                TextField("카테고리 이름", text: $name)
                    .padding(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(pointColor, lineWidth: 1)
                    )
                    .foregroundColor(textColor)
                    .onAppear {
                        name = category?.name ?? ""
                    }
            }

            VStack {
                HStack {
                    Text("색상")
                        .font(.title2)
                        .foregroundColor(textColor)

                    Spacer()

                    ColorPicker("색상", selection: $selectedColor)
                        .labelsHidden()
                        .onTapGesture {
                            withAnimation {
                                isColorPickerVisible.toggle()
                            }
                        }
                }

                if isColorPickerVisible {
                    ColorPicker("", selection: $selectedColor)
                        .labelsHidden()
                        .transition(.opacity.combined(with: .move(edge: .top)))
                }
            }

            HStack {
                Text("이모지")
                    .font(.title2)
                    .foregroundColor(textColor)

                Spacer()

                Text(selectedEmoji)
                    .font(.title2)
                    .onTapGesture {
                        isEmojiPickerVisible.toggle()
                    }
            }

            Spacer()
        }
        .padding(20)
        .onAppear {
            selectedColor = category?.color ?? Color.lightMainColor
            selectedEmoji = category?.emoji ?? "🫥"
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
                        .foregroundColor(pointColor)
                }
            }

            ToolbarItem(placement: .principal) {
                Text(category != nil ? "카테고리 수정" : "카테고리 생성")
                    .font(.title2)
                    .foregroundColor(textColor)
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    save()
                } label: {
                    Text("완료")
                        .font(.title3)
                        .foregroundColor(pointColor)
                }
            }
        }
        .toolbar(.hidden, for: .tabBar)
        .emojiPicker(
            isDisplayed: $isEmojiPickerVisible,
            onEmojiSelected: { emoji in
                selectedEmoji = emoji.value
                isEmojiPickerVisible = false
            }
        )
    }
}

extension CategoryComposeView {
    func save() {
        if let category {
            category.name = name
            category.color = selectedColor
            category.emoji = selectedEmoji
        } else {
            let newCategory = Category(
                name: name,
                color: selectedColor,
                emoji: selectedEmoji,
                userID: username
            )
            context.insert(newCategory)
        }

        do {
            try context.save()
            dismiss()
        } catch {
            print("저장 실패: \(error.localizedDescription)")
        }
    }
}

#Preview {
    NavigationStack {
        CategoryComposeView(category: .constant(nil))
    }
}

#Preview("수정") {
    NavigationStack {
        CategoryComposeView(category: .constant(Category(
            name: "테스트",
            color: .blue,
            emoji: "💡",
            userID: "default_user"
        )))
    }
}
