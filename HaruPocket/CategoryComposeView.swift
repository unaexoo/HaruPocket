//
//  CategoryComposeView.swift
//  HaruPocket
//
//  Created by 고재현 on 5/14/25.
//

import SwiftUI
import EmojiPicker

/// 사용자가 카테고리를 새로 생성하거나 기존 카테고리를 수정할 수 있는 뷰입니다.
struct CategoryComposeView: View {

    // MARK: - 사용자 입력 상태

    /// 카테고리 이름
    @State private var name: String = ""

    /// 선택된 색상 (기본값은 lightMainColor)
    @State private var selectedColor: Color = .lightMainColor

    /// 선택된 이모지 (기본값은 🫥)
    @State private var selectedEmoji: String = "🫥"

    /// 이름 미입력 시 경고용 Alert 표시 여부
    @State private var showAlert = false

    /// 이모지 선택기 표시 여부
    @State private var isEmojiPickerVisible: Bool = false

    /// 사용자 고유 ID (UserDefaults 기반 저장)
    @AppStorage("username") private var username: String = "default_user"

    /// SwiftData 모델 컨텍스트 (삽입 및 저장 기능 사용)
    @Environment(\.modelContext) private var context

    /// 현재 뷰 닫기용 dismiss 함수
    @Environment(\.dismiss) private var dismiss

    /// 시스템 색상 모드 (라이트/다크)
    @Environment(\.colorScheme) private var colorScheme

    /// 카테고리 관련 전역 ViewModel
    @EnvironmentObject var spendingViewModel: SpendingViewModel

    /// 바인딩으로 주입되는 수정 대상 카테고리 (nil이면 생성 모드)
    @Binding var category: Category?

    /// 현재 색상 모드에 맞는 포인트 컬러 반환
    private var pointColor: Color {
        colorScheme == .dark ? .darkPointColor : .lightPointColor
    }

    /// 현재 색상 모드에 맞는 일반 텍스트 색상 반환
    private var textColor: Color {
        colorScheme == .dark ? .creamWhite : .black
    }

    var body: some View {
        VStack(spacing: 30) {
            // MARK: 제목 입력 영역
            VStack(alignment: .leading, spacing: 6) {
                Text("제목")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.leading, 5)

                TextField("카테고리 이름", text: $name)
                    .padding(10)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(pointColor, lineWidth: 1)
                    )
                    .foregroundColor(textColor)
            }

            // MARK: 색상 선택 영역
            HStack {
                Text("색상")
                    .font(.title2)
                    .foregroundColor(textColor)

                Spacer()

                ColorPicker("색상 선택", selection: $selectedColor)
                    .labelsHidden()
            }

            // MARK: 이모지 선택 영역
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
            // 초기 데이터 세팅 (수정 모드일 경우 기존 값 반영)
            name = category?.name ?? ""
            selectedColor = category?.color ?? .lightMainColor
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
        .alert("경고", isPresented: $showAlert) {
            Button("확인") { }
        } message: {
            Text("카테고리 이름을 입력해주세요")
        }
    }

    // MARK: - 저장 함수

    /// 입력값을 기반으로 카테고리를 생성하거나 수정하고, 모델 컨텍스트에 저장합니다.
    private func save() {
        guard !name.isEmpty else {
            showAlert = true
            return
        }

        if let category {
            // 수정 모드: 기존 카테고리 업데이트
            category.name = name
            category.color = selectedColor
            category.emoji = selectedEmoji
        } else {
            // 생성 모드: 새 카테고리 인스턴스 생성 및 삽입
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
