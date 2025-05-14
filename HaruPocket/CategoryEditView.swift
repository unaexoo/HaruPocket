//
//  CategoryEditView.swift
//  HaruPocket
//
//  Created by 고재현 on 5/14/25.
//

//import SwiftUI
//import EmojiPicker
//
//struct CategoryEditView: View {
//    @State private var title: String
//    @State private var selectedColor: Color
//    @State private var selectedEmoji: String
//    @State private var isColorPickerVisible: Bool = false
//    @State private var isEmojiPickerVisible: Bool = false
//
//    var onSave: (CategoryModel) -> Void
//    var onCancel: () -> Void
//
//    let isEditing = true
//
//    init(category: CategoryModel, onSave: @escaping (CategoryModel) -> Void, onCancel: @escaping () -> Void) {
//        _title = State(initialValue: category.title)
//        _selectedColor = State(initialValue: category.color)
//        _selectedEmoji = State(initialValue: category.emoji)
//        self.onSave = onSave
//        self.onCancel = onCancel
//    }
//
//    var body: some View {
//        NavigationStack {
//            VStack(spacing: 30) {
//                VStack(alignment: .leading, spacing: 4) {
//                    Text("제목")
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//                        .padding(.leading, 10)
//
//                    TextField("카테고리 이름", text: $title)
//                        .padding(10)
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 8)
//                                .stroke(Color.lightPointColor, lineWidth: 1)
//                        )
//                }
//
//                VStack {
//                    HStack {
//                        Text("색상")
//                            .font(.title2)
//                            .foregroundColor(.black)
//
//                        Spacer()
//
//                        ColorPicker("색상", selection: $selectedColor)
//                            .labelsHidden()
//                            .onTapGesture {
//                                withAnimation {
//                                    isColorPickerVisible.toggle()
//                                }
//                            }
//                        // '>' 버튼 삭제됨
//                    }
//                    .padding(.horizontal, 10)
//
//                    if isColorPickerVisible {
//                        ColorPicker("", selection: $selectedColor)
//                            .labelsHidden()
//                            .padding(.horizontal, 10)
//                            .transition(.opacity.combined(with: .move(edge: .top)))
//                    }
//                }
//
//                HStack {
//                    Text("이모지")
//                        .font(.title2)
//                        .foregroundColor(.black)
//
//                    Spacer()
//
//                    Text(selectedEmoji)
//                        .font(.title2)
//                        .onTapGesture {
//                            isEmojiPickerVisible.toggle()
//                        }
//                }
//                .padding(.horizontal, 10)
//
//                Spacer()
//            }
//            .padding()
//            .padding(.top, -30)
//            .navigationBarBackButtonHidden(true)
//            .toolbar {
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button {
//                        onCancel()
//                    } label: {
//                        Image(systemName: "chevron.backward")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 20, height: 20)
//                            .foregroundColor(Color.lightPointColor)
//                    }
//                }
//
//                ToolbarItem(placement: .principal) {
//                    Text("카테고리 수정")
//                        .font(.title2)
//                }
//
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button("완료") {
//                        let updated = CategoryModel(
//                            title: title,
//                            color: selectedColor,
//                            emoji: selectedEmoji
//                        )
//                        onSave(updated)
//                    }
//                    .foregroundColor(Color.lightPointColor)
//                }
//            }
//        }
//        .emojiPicker(
//            isDisplayed: $isEmojiPickerVisible,
//            onEmojiSelected: { emoji in
//                selectedEmoji = emoji.value
//                isEmojiPickerVisible = false
//            }
//        )
//    }
//}
//
//#Preview {
//    CategoryEditView(
//        category: CategoryModel(
//            title: "음식",
//            color: .pink,
//            emoji: "🍡"
//        ),
//        onSave: { _ in },
//        onCancel: { }
//    )
//}
