//
//  DetailView.swift
//  HaruPocket
//
//  Created by 고재현 on 5/14/25.
//

import SwiftUI

/// 소비 기록의 상세 내용을 보여주는 화면입니다.
/// 선택한 소비 항목(`BasicEntry`)의 이미지, 카테고리, 금액, 메모 등을 출력합니다.
/// 사용자는 이 화면에서 항목을 수정하거나 삭제할 수 있습니다.
struct DetailView: View {
    /// 현재 화면을 종료하기 위한 환경 변수입니다.
    @Environment(\.dismiss) private var dismiss

    /// 다크모드 여부를 확인하는 환경 변수입니다.
    @Environment(\.colorScheme) private var colorScheme

    /// SwiftData의 모델 컨텍스트입니다. 항목 삭제 후 저장할 때 사용됩니다.
    @Environment(\.modelContext) private var context

    /// 소비 항목 목록을 관리하는 ViewModel입니다.
    @EnvironmentObject var spendingViewModel: SpendingViewModel

    /// 삭제 확인 알림창 표시 여부를 나타냅니다.
    @State private var showDeleteAlert = false

    /// 수정 화면(`ComposeView`) 전환 여부를 나타냅니다.
    @State private var showComposeView = false

    /// 현재 표시 중인 소비 항목입니다.
    @Binding var basics: BasicEntry

    /// 다크모드에 따라 포인트 색상을 반환합니다.
    private var pointColor: Color {
        colorScheme == .dark ? .darkPointColor : .lightPointColor
    }

    /// 테두리 색상을 반환합니다.
    private var borderColor: Color {
        colorScheme == .dark ? .darkBrown : .brown
    }

    /// 배경 색상을 반환합니다.
    private var backgroundColor: Color {
        colorScheme == .dark ? .darkMainColor : .subColor
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                // 이미지 표시 영역
                Group {
                    if let uiImage = basics.image {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 250)
                            .frame(width: 360)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                    } else {
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

                // 타이틀 및 카테고리 표시 영역
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

                // 가격 및 내용 표시 영역
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
            // 뒤로 가기 버튼
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

            // 날짜 표시
            ToolbarItem(placement: .principal) {
                Text(formattedDate(from: basics.date))
                    .font(.title2)
                    .foregroundColor(pointColor)
            }

            // 수정 및 삭제 버튼
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
                context.delete(basics)
                try? context.save()
                spendingViewModel.loadEntry(context: context)
                dismiss()
            }
            Button("아니오", role: .cancel) { }
        }
        .navigationDestination(isPresented: $showComposeView) {
            ComposeView(date: basics.date, basics: Binding($basics))
                .onDisappear {
                    spendingViewModel.hasLoadedCategory = false
                    spendingViewModel.loadCategory(
                        context: context
                    )
                }
        }
    }

    /// 날짜를 'YYYY년 M월 D일' 형식의 문자열로 변환합니다.
    /// - Parameter date: 변환할 `Date` 객체입니다.
    /// - Returns: 한국어 형식의 날짜 문자열
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



