//
//  PhotoView.swift
//  HaruPocket
//
//  Created by 장지현 on 5/16/25.
//

import SwiftUI

struct PhotoView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @EnvironmentObject var spendingViewModel: SpendingViewModel

    private let spacing: CGFloat = 5
    private let columns = Array(repeating: GridItem(.flexible(), spacing: 5), count: 3)

    var body: some View {
        ScrollView {
            let allSpending = spendingViewModel.spending
            let filtereditems = allSpending
                .filter {
                    $0.userID == spendingViewModel.username &&
                    $0.imageFileName?.isEmpty == false
                }
                .sorted { $0.date > $1.date }

            LazyVGrid(columns: columns, spacing: spacing) {
                ForEach(filtereditems, id: \.id) { entry in
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
