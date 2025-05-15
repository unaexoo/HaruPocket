//
//  PhotoView.swift
//  HaruPocket
//
//  Created by 장지현 on 5/16/25.
//

import SwiftUI

/// 저장된 이미지가 있는 소비 항목을 그리드로 보여주는 뷰입니다.
/// 이미지를 탭하면 해당 항목의 상세 페이지로 이동합니다.
struct PhotoView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @EnvironmentObject var spendingViewModel: SpendingViewModel

    /// 그리드 아이템 간의 간격
    private let spacing: CGFloat = 5
    /// 3열 그리드 레이아웃 구성
    private let columns = Array(repeating: GridItem(spacing: 5), count: 3)

    var body: some View {
        ScrollView {
            // 모든 소비 항목 중 현재 사용자와 이미지가 있는 항목만 필터링 후 날짜 내림차순 정렬
            let allSpending = spendingViewModel.spending
            let filtereditems = allSpending
                .filter {
                    $0.userID == spendingViewModel.username &&
                    $0.imageFileName?.isEmpty == false
                }
                .sorted { $0.date > $1.date }

            // 필터링된 항목들을 3열 그리드 형태로 표시
            LazyVGrid(columns: columns, spacing: spacing) {
                ForEach(filtereditems) { entry in
                    let entryID = entry.id
                    if let index = allSpending.firstIndex(where: { $0.id == entryID }) {
                        NavigationLink {
                            DetailView(basics: $spendingViewModel.spending[index])
                        } label: {
                            if let uiImage = entry.image {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: gridItemSize, height: gridItemSize)
                                    .clipped()
                            } else {
                                Color.gray
                                    .frame(width: gridItemSize, height: gridItemSize)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, spacing)
        }
        .scrollIndicators(.hidden)
        .padding(.top)
        .onAppear {
            spendingViewModel.loadEntry(context: context)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("사진")
                    .font(.title2)
            }
        }
    }

    /// 그리드 항목 하나의 너비를 계산합니다.
    private var gridItemSize: CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        let totalSpacing = spacing * 4
        return (screenWidth - totalSpacing) / 3
    }
}

#Preview {
    NavigationStack {
        PhotoView()
            .modelContainer(
                for: [BasicEntry.self, Category.self],
                inMemory: true
            )
            .environmentObject(SpendingViewModel())
    }
}
