//
//  DetailView.swift
//  HaruPocket
//
//  Created by 고재현 on 5/14/25.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var showDeleteAlert = false
    @State private var showComposeView = false

    @Binding var basics: BasicEntry

    var body: some View {
        VStack(spacing: 40) {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.gray.opacity(0.1))
                .frame(maxWidth: .infinity)
                .aspectRatio(1.3, contentMode: .fit)
                .overlay(
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.gray)
                )
                .padding(.horizontal)

            HStack {
                Text(basics.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.lightPointColor)

                Spacer()

                Label {
                    Text(basics.category?.name ?? "카테고리 없음")
                        .font(.title3)
                        .foregroundColor(Color.lightPointColor)
                } icon: {
                    Text(basics.category?.emoji ?? "")
                        .foregroundColor(.gray)
                }

                Circle()
                    .fill(basics.category?.color ?? .gray)
                    .frame(width: 18, height: 18)
            }
            .padding(.horizontal, 40)

            VStack(alignment: .leading, spacing: 8) {
                Text("가격")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                    .padding(.leading, 10)

                HStack {
                    Text("\(basics.money)")
                        .font(.body)
                    Spacer()
                    Text("원")
                        .foregroundColor(Color.lightPointColor)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.brown, lineWidth: 1)
                )
                .foregroundColor(Color.lightPointColor)

                Spacer()

                Text("내용")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                    .padding(.leading, 10)

                Text(basics.content ?? "")
                    .frame(maxWidth: .infinity, minHeight: 100, alignment: .topLeading)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.brown, lineWidth: 1)
                    )
                    .foregroundColor(Color.lightPointColor)
            }
            .padding(.horizontal)

            Spacer()
        }
        //.padding(.top, -30)
        .navigationBarTitleDisplayMode(.inline)
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
                Text(formattedDate(from: basics.date))
                    .font(.title2)
            }

            ToolbarItemGroup(placement: .navigationBarTrailing) {

                Button {
                    showComposeView = true
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
                // 삭제 처리: 이 부분은 팀원 코드와 연동
            }
            Button("아니오", role: .cancel) {
                // alert 자동으로 사라짐
            }
        }
        .navigationDestination(isPresented: $showComposeView) {
            ComposeView(basics: Binding($basics))

        }
    }

    func formattedDate(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateStyle = .long     // "2025년 5월 14일"
        formatter.timeStyle = .none

        return formatter.string(from: date)
    }
}

#Preview {
    NavigationStack {
        DetailView(basics: .constant(
            BasicEntry(
            title: "샘플 이미지 항목 1",
            content: "테스트용 이미지가 포함된 항목입니다.",
            date: Date(),
            money: 42494,
            imageFileName: "gift.jpg",
            userID: "default_user",
            category: Category(
                name: "테스트",
                color: .blue,
                emoji: "💡",
                userID: "default_user"
            ))
        ))
        .modelContainer(
            for: [BasicEntry.self, Category.self, Statics.self],
            inMemory: true
        )
    }
}

