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

    let dateString = "2025.05.12"
    let image = Image("sampleImage")
    let categoryName = "음식"
    let categoryIcon = "🍚"
    let categoryColor = Color.pink
    let title = "돈가스"
    let price = "48,000"
    let memo = "맛있는 돈가스~"

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
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.lightPointColor)

                Spacer()

                Label {
                    Text(categoryName)
                        .font(.title3)
                        .foregroundColor(Color.lightPointColor)
                } icon: {
                    Text(categoryIcon)
                        .foregroundColor(.gray)
                }

                Circle()
                    .fill(categoryColor)
                    .frame(width: 18, height: 18)
            }
            .padding(.horizontal, 40)

            VStack(alignment: .leading, spacing: 8) {
                Text("가격")
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                    .padding(.leading, 10)

                HStack {
                    Text(price)
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

                Text(memo)
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
                Text(dateString)
                    .font(.title2)
            }

            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    // 수정 화면 이동 처리
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
    }
}

#Preview {
    NavigationStack {
        DetailView()
    }
}

