//
//  DetailView.swift
//  HaruPocket
//
//  Created by 고재현 on 5/14/25.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.modelContext) private var context

    @EnvironmentObject var spendingViewModel: SpendingViewModel

    @State private var showDeleteAlert = false
    @State private var showComposeView = false

    @Binding var basics: BasicEntry

    // 다크모드 대응
    private var pointColor: Color {
        colorScheme == .dark ? .darkPointColor : .lightPointColor
    }

    private var borderColor: Color {
        colorScheme == .dark ? .darkBrown : .brown
    }

    private var backgroundColor: Color {
        colorScheme == .dark ? .darkMainColor : .subColor
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                Group {
                    if let uiImage = basics.image {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 250)
                            .frame(width: 360)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                    }
                    else {
                        Image("pocket")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                .overlay {
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(pointColor, lineWidth: 1)
                }
                .frame(height: 250)
                .frame(width: 360)
                .padding(.top, 20)

                HStack {
                    Text(basics.title)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(pointColor)

                    Spacer()

                    Text(basics.category?.name ?? "카테고리 없음")
                        .font(.title3)
                        .foregroundColor(pointColor)

                    Text(basics.category?.emoji ?? "")
                        .font(.footnote)
                        .padding(7)
                        .background(basics.category?.color ?? .gray)
                        .clipShape(Circle())
                        .frame(maxHeight: 10)
                }
                .padding(.horizontal, 20)

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
                            .foregroundColor(pointColor)
                    }
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(borderColor, lineWidth: 1)
                    )
                    .foregroundColor(pointColor)
                    .padding(.bottom, 20)

                    Text("내용")
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                        .padding(.leading, 10)

                    Text(basics.content ?? "")
                        .frame(maxWidth: .infinity, minHeight: 100, alignment: .topLeading)
                        .padding()
                        .foregroundColor(pointColor)

                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(borderColor, lineWidth: 1)
                        )
                }
                .padding(.horizontal)

                Spacer()
            }
        }
        .scrollIndicators(.hidden)
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
                        .foregroundColor(pointColor)
                }
            }

            ToolbarItem(placement: .principal) {
                Text(formattedDate(from: basics.date))
                    .font(.title2)
                    .foregroundColor(pointColor)
            }

            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    showComposeView = true
                } label: {
                    Image(systemName: "pencil")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(pointColor)
                }

                Button {
                    showDeleteAlert = true
                } label: {
                    Image(systemName: "trash")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                        .foregroundColor(pointColor)
                }
            }
        }
        .alert("정말 삭제하시겠습니까?", isPresented: $showDeleteAlert) {
            Button("네", role: .destructive) {
                // 삭제 처리: 팀원 코드와 연동
                context.delete(basics)
                try? context.save()
                spendingViewModel.loadEntry(context: context)

                dismiss()
            }
            Button("아니오", role: .cancel) { }
        }
        .navigationDestination(isPresented: $showComposeView) {
            ComposeView(date: basics.date, basics: Binding($basics))
        }
    }

    func formattedDate(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateStyle = .long
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
                imageFileName: "SampleImage/gift.jpg",
                userID: "default_user",
                category: Category(
                    name: "테스트",
                    color: .blue,
                    emoji: "💡",
                    userID: "default_user"
                ))
        ))
        .modelContainer(
            for: [BasicEntry.self, Category.self],
            inMemory: true
        )
    }
}


