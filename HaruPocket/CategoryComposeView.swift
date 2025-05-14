//
//  CategoryComposeView.swift
//  HaruPocket
//
//  Created by 고재현 on 5/14/25.
//

import SwiftUI
import EmojiPicker

struct CategoryComposeView: View {
    @State private var title: String = ""
    @State private var selectedColor: Color? = nil
    @State private var selectedEmoji: String = ""
    @State private var isColorPickerVisible: Bool = false
    @State private var isEmojiPickerVisible: Bool = false

    //var onSave: (CategoryModel) -> Void
    var onCancel: () -> Void

    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                // 제목 입력
                VStack(alignment: .leading, spacing: 4) {
                    Text("제목")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.leading, 10)

                    TextField("카테고리 이름", text: $title)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.lightPointColor, lineWidth: 1)
                        )
                }

                // 색상 선택
                VStack {
                    HStack {
                        Text("색상")
                            .font(.title2)
                            .foregroundColor(.black)

                        Spacer()

                        ColorPicker("색상", selection: Binding(
                            get: { selectedColor ?? .gray },
                            set: { selectedColor = $0 }
                        ))
                        .labelsHidden()
                        .onTapGesture {
                            withAnimation {
                                isColorPickerVisible.toggle()
                            }
                        }
                        // '>' 버튼 없음
                    }
                    .padding(.horizontal, 10)

                    if isColorPickerVisible {
                        ColorPicker("", selection: Binding(
                            get: { selectedColor ?? .gray },
                            set: { selectedColor = $0 }
                        ))
                        .labelsHidden()
                        .padding(.horizontal, 10)
                        .transition(.opacity.combined(with: .move(edge: .top)))
                    }
                }

                // 이모지 선택
                HStack {
                    Text("이모지")
                        .font(.title2)
                        .foregroundColor(.black)

                    Spacer()

                    Group {
                        if selectedEmoji.isEmpty {
                            Image(systemName: "smiley")
                                .foregroundColor(.gray)
                                .font(.title2)
                        } else {
                            Text(selectedEmoji)
                                .font(.title2)
                        }
                    }
                    .onTapGesture {
                        withAnimation {
                            isEmojiPickerVisible.toggle()
                        }
                    }
                }
                .padding(.horizontal, 10)

                Spacer()
            }
            .padding()
            .padding(.top, -30)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        onCancel()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color.lightPointColor)
                    }
                }

                ToolbarItem(placement: .principal) {
                    Text("카테고리 생성")
                        .font(.title2)
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("완료") {
                        guard let color = selectedColor, !title.isEmpty, !selectedEmoji.isEmpty else { return }

                        //let newCategory = CategoryModel(
//                            title: title,
//                            color: color,
//                            emoji: selectedEmoji
//                        )
                        //onSave(newCategory)
                    }
                    .foregroundColor(Color.lightPointColor)
                }
            }
        }
        .emojiPicker(
            isDisplayed: $isEmojiPickerVisible,
            onEmojiSelected: { emoji in
                selectedEmoji = emoji.value
                isEmojiPickerVisible = false
            }
        )
    }
}

#Preview {
    CategoryComposeView(
        //onSave: { _ in },
        onCancel: { }
    )
}
