//
//  CategoryView.swift
//  HaruPocket
//
//  Created by YC on 5/12/25.
//

import SwiftUI
import UIKit

/// `CategoryView`는 사용자에게 등록된 모든 카테고리를 그리드 형태로 보여주는 메인 카테고리 화면입니다.
/// - 각 카테고리는 이모지와 색상을 포함한 카드로 표현되며, 선택 시 해당 카테고리의 소비 내역 화면으로 이동합니다.
/// - 오른쪽 상단 버튼을 통해 카테고리 편집 화면으로 이동할 수 있으며,
/// - 오른쪽 하단 플로팅 버튼을 통해 새 카테고리를 추가할 수 있습니다.
struct CategoryView: View {
    @AppStorage("username") private var username: String = "default_user"

    @EnvironmentObject var spendingViewModel: SpendingViewModel
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss

    @State private var showCategoryListComposeView = false
    @State private var showCategoryComposeView = false
    @State private var screenWidth: CGFloat = UIScreen.main.bounds.width

    /// 화면 크기에 따라 적절한 열(column) 수를 반환합니다.
    /// - iPad: 화면 너비를 기준으로 동적으로 열 수 계산
    /// - iPhone: 항상 2열 구성
    var columns: [GridItem] {
        let isPad = UIDevice.current.userInterfaceIdiom == .pad
        let columnCount = isPad ? max(2, Int(screenWidth / 200)) : 2
        return Array(repeating: GridItem(.flexible()), count: columnCount)
    }

    /// 날짜를 'yyyy.MM.dd' 형식의 문자열로 변환합니다.
    /// - Parameter date: 변환할 `Date` 객체
    /// - Returns: 지정된 포맷의 문자열
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
    }

    /// 카테고리 카드 그리드 화면을 구성합니다.
    /// - 사용자의 카테고리를 불러와 이모지 및 색상 카드로 표시합니다.
    /// - 플로팅 버튼으로 새 카테고리를 생성할 수 있으며,
    ///   툴바에서 편집 버튼을 눌러 편집 화면으로 이동할 수 있습니다.
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                GeometryReader { geometry in
                    Color.clear
                        .onAppear {
                            screenWidth = geometry.size.width
                        }
                        .onChange(of: geometry.size.width) { _, newWidth in
                            screenWidth = newWidth
                        }
                }
                .frame(height: 0)

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        let allCategories = spendingViewModel.categories
                        let categories = allCategories
                            .filter { $0.userID == spendingViewModel.username }
                            .sorted {
                                if $0.name == "카테고리 없음" { return false }
                                if $1.name == "카테고리 없음" { return true }
                                return $0.name < $1.name
                            }

                        ForEach(categories, id: \.id) { category in
                            let categoryID = category.id
                            if let index = allCategories.firstIndex(where: { $0.id == categoryID }) {
                                let binding = Binding<Category?>(
                                    get: { allCategories[index] },
                                    set: { newValue in
                                        if let newValue {
                                            spendingViewModel.categories[index] = newValue
                                        }
                                    })

                                NavigationLink(destination: CategoryListView(category: binding)) {
                                    VStack(spacing: 8) {
                                        Text(category.emoji)
                                            .font(.system(size: 60))
                                        Text(category.name)
                                            .font(.title3)
                                            .foregroundColor(category.color.isDarkColor() ? .white : .black)
                                    }
                                    .frame(width: 160, height: 160)
                                    .background(category.color)
                                    .cornerRadius(25)
                                    .shadow(radius: 3)
                                }
                            }
                        }
                    }
                    .padding()
                }
                .scrollIndicators(.hidden)

                // 플로팅 버튼
                Button {
                    showCategoryComposeView = true
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 50, height: 50)
                        .background(Color.lightMainColor)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
                .padding(.trailing, 20)
                .padding(.bottom, 20)
            }
        }
        .onAppear {
            spendingViewModel.loadCategory(context: context)
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("카테고리")
                    .font(.title2)
            }

            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showCategoryListComposeView = true
                } label: {
                    Image(systemName: "checklist")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color.lightPointColor)
                }
            }
        }
        .navigationDestination(isPresented: $showCategoryListComposeView) {
            CategoryListComposeView()
        }
        .navigationDestination(isPresented: $showCategoryComposeView) {
            CategoryComposeView(category: .constant(nil))
                .onDisappear {
                    showCategoryComposeView = false
                    spendingViewModel.hasLoadedCategory = false
                    spendingViewModel.loadCategory(context: context)
                }
        }
    }
}

/// 색상의 밝기를 계산하여 텍스트 색상 대비 여부를 판단합니다.
/// - Returns: 색상이 어두운 경우 `true`, 밝은 경우 `false`
extension Color {
    func isDarkColor() -> Bool {
        let uiColor = UIColor(self)
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        uiColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let brightness = (red * 299 + green * 587 + blue * 114) / 1000
        return brightness < 0.6
    }
}

/// CategoryView에 대한 미리보기 구성입니다.
/// - 인메모리 컨테이너와 ViewModel을 포함해 개발 중 UI 확인 가능
#Preview {
    NavigationStack {
        CategoryView()
    }
    .modelContainer(for: [BasicEntry.self, Category.self], inMemory: true)
    .environmentObject(SpendingViewModel())
}
