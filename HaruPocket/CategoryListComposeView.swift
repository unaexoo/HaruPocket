import SwiftUI
import SwiftData

struct CategoryListComposeView: View {
    @Environment(\.dismiss) var dismiss
    
    @Environment(\.modelContext) private var context
    @Environment(\.colorScheme) private var colorScheme
    @AppStorage("username") private var username: String = "default_user"
    @StateObject private var viewModel = SpendingViewModel()
    // 체크된 카테고리의 ID들을 저장하는 Set (삭제 등의 작업에 사용)
    @State private var selectedCategoryIDs: Set<UUID> = []

    
    
    
    @State var categories: [Category]

    var body: some View {
        List {
            // 카테고리가 없을 경우 안내 메시지 표시
            if categories.isEmpty {
                Text("등록된 카테고리가 없습니다.")
                    .foregroundStyle(.secondary)
                    .padding(.vertical, 8)
            } else {
                // 카테고리 목록을 반복하여 표시 (체크박스 형태)
                ForEach(categories, id: \.id) { category in
                    HStack(spacing: 12) {
                        Image(systemName: selectedCategoryIDs.contains(category.id) ? "checkmark.circle.fill" : "circle")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(Color.lightPointColor)

                        Text(category.name)
                            .foregroundStyle(.primary)
                    }
                    .padding(.vertical, 6)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        // 체크 상태 토글: 선택되어 있으면 제거, 아니면 추가
                        if selectedCategoryIDs.contains(category.id) {
                            selectedCategoryIDs.remove(category.id)
                        } else {
                            selectedCategoryIDs.insert(category.id)
                        }
                    }
                }
               
            }
        }
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
                Text("카테고리 편집")
                    .font(.title2)
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // 선택된 카테고리들의 name을 기준으로 "카테고리 없음"으로 변경하고 리스트에서 제거
                    let targetNames: Set<String> = Set(viewModel.categories.filter { selectedCategoryIDs.contains($0.id) }.map { $0.name })
                    
                    // 동일한 name을 가진 모든 카테고리 name 변경
                    for i in viewModel.categories.indices {
                        if targetNames.contains(viewModel.categories[i].name) {
                            viewModel.categories[i].name = "카테고리 없음"
                        }
                    }
                    
                    // 삭제된 name과 일치하는 카테고리 항목은 리스트에서 제거
                    categories.removeAll { targetNames.contains($0.name) }
                    
                    selectedCategoryIDs.removeAll()
                } label: {
                    Image(systemName: "trash.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color.lightPointColor)
                }
            }
        }
        .listStyle(.plain)
  
        .navigationDestination(for: Category.self) { category in
            //CategoryListView(categories: category)
        }
        .onAppear {
            // 뷰모델의 사용자명 설정 및 카테고리 로딩
            viewModel.username = username
            viewModel.loadCategory(context: context)
        }
    }
}

#Preview {
    NavigationStack {
        let sampleCategories = [
            Category(name: "음식", color: .blue, emoji: "🍔", userID: "default_user"),
            Category(name: "교통", color: .green, emoji: "🚇", userID: "default_user"),
            Category(name: "쇼핑", color: .purple, emoji: "🛍️", userID: "default_user")
        ]
        CategoryListComposeView(categories: sampleCategories)
            .modelContainer(
                for: [BasicEntry.self, Category.self, Statics.self],
                inMemory: true
            )
    }
}

  
