//
//  CategoryDetailView.swift
//  HaruPocket
//
//  Created by 고재현 on 5/14/25.
//

import SwiftUI

struct CategoryDetailView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var isEditActive = false
    @State private var showDeleteAlert = false

    @Binding var category: Category

    var body: some View {
        VStack(spacing: 30) {
            VStack(alignment: .leading, spacing: 4) {
                Text("제목")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.leading, 10)

                Text(category.name)
                    .padding(10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.brown, lineWidth: 1)
                    )
            }

            VStack {
                HStack {
                    Text("색상")
                        .font(.title2)
                        .foregroundColor(.black)

                    Spacer()

                    Circle()
                        .fill(category.color)
                        .frame(width: 18, height: 18)
                }
                .padding(.horizontal, 10)
            }

            HStack {
                Text("이모지")
                    .font(.title2)
                    .foregroundColor(.black)

                Spacer()

                Text(category.emoji)
                    .font(.title2)
                    .padding(.trailing, 5)
            }
            .padding(.leading, 10)

            Spacer()
        }
        .padding()
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    // 뒤로가기
                } label: {
                    Image(systemName: "chevron.backward")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.lightPointColor)
                }
            }

            ToolbarItem(placement: .principal) {
                Text("상세 화면")
                    .font(.title2)
            }

            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    isEditActive = true
                } label: {
                    Image(systemName: "pencil")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.lightPointColor)
                }

                Button {
                    showDeleteAlert = true
                } label: {
                    Image(systemName: "trash")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.lightPointColor)
                }
            }
        }
        .alert("정말 삭제하시겠습니까?", isPresented: $showDeleteAlert) {
                    Button("네", role: .destructive) {
                        // TODO: 삭제 로직 추가 예정
                    }
                    Button("아니오", role: .cancel) {
                        showDeleteAlert = false
                    }
                }
        .sheet(isPresented: $isEditActive) {
            CategoryComposeView(category: Binding($category))
        }
    }
}

#Preview {
    NavigationStack {
        CategoryDetailView(category: .constant(Category(
            name: "테스트",
            color: .blue,
            emoji: "💡",
            userID: "default_user"
        )))
    }
}
