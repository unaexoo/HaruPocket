import SwiftUI
import SwiftData

/// `CategoryListComposeView`는 사용자가 생성한 카테고리들을 리스트 형태로 보여주고, 편집 및 삭제 기능을 제공하는 뷰입니다.
/// - 삭제 모드로 전환되면 항목 옆에 체크박스가 표시되며, 선택된 항목들을 삭제할 수 있습니다.
/// - 삭제 버튼을 누르면 해당 카테고리를 categories 배열에서 제거하고, 선택도 초기화됩니다.
/// - 일반 모드에서는 카테고리를 선택 시 상세 뷰(CategoryView)로 이동합니다.
struct CategoryListComposeView: View {
    @Environment(\.dismiss) var dismiss
    
    @Environment(\.modelContext) private var context
    @Environment(\.colorScheme) private var colorScheme
    @AppStorage("username") private var username: String = "default_user"
    @EnvironmentObject var spendingViewModel: SpendingViewModel
    // 체크된 카테고리의 ID들을 저장하는 Set (삭제 등의 작업에 사용)
    @State private var selectedCategoryIDs: Set<UUID> = []
    
    // 편집 모드 여부를 제어하는 상태 변수
    @State private var isDeleting = false
    @State private var showDeleteConfirmation = false
    @State private var showSelectAlert = false
    
    @State private var showCateogryComposeView = false
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
                    if isDeleting {
                        // 삭제 모드일 때: 체크박스만 보이기 (애니메이션 적용)
                        HStack(spacing: 12) {
                            Image(systemName: selectedCategoryIDs.contains(category.id) ? "checkmark.circle.fill" : "circle")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(Color.lightPointColor)
                            
                            Text(category.name)
                                .foregroundStyle(.primary)
                                .padding(.horizontal,5)
                            
                        }
                        .padding(.vertical, 6)
                        // 리스트 항목 전체를 터치 영역으로 설정
                        .contentShape(Rectangle())
                        
                        // 항목을 탭했을 때 체크 상태를 토글
                        .onTapGesture {
                            if selectedCategoryIDs.contains(category.id) {
                                // 이미 선택된 경우 → 선택 해제
                                selectedCategoryIDs.remove(category.id)
                            } else {
                                // 선택되지 않은 경우 → 선택 추가
                                selectedCategoryIDs.insert(category.id)
                            }
                        }
                        
                    } else {
                        // 삭제 모드가 아닐 때: NavigationLink로 상세 뷰로 이동
                        NavigationLink(destination: CategoryView()) {
                            HStack(spacing: 12) {
                                Text(category.name)
                                    .foregroundStyle(.primary)
                            }
                            .padding(.vertical, 6)
                        }
                    }
                }
            }
        }
        .padding(.vertical)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    if isDeleting {
                        isDeleting = false
                        selectedCategoryIDs.removeAll()
                    } else {
                        dismiss()
                    }
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
                if isDeleting {
                    Button {
                        if !selectedCategoryIDs.isEmpty {
                            showDeleteConfirmation = true
                        } else {
                            showSelectAlert = true
                        }
                    } label: {
                        Image(systemName: "trash.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                            .foregroundColor(Color.lightPointColor)
                    }
                    .alert("선택한 카테고리를 삭제할까요?", isPresented: $showDeleteConfirmation) {
                        Button("삭제", role: .destructive) {
                            for id in selectedCategoryIDs {
                                
                                if let index = categories.firstIndex(where: { $0.id == id }) {
                                    
                                    categories.remove(at: index)
                                }
                            }
                            selectedCategoryIDs.removeAll()
                            isDeleting = false
                        }
                        Button("취소", role: .cancel) {
                            showDeleteConfirmation = false
                        }
                    }
                    .alert("카테고리를 선택해주세요", isPresented: $showSelectAlert) {
                        Button("확인", role: .cancel) { showSelectAlert = false }
                    }
                } else {
                    Button {
                        isDeleting = true
                    } label: {
                        Text("편집")
                            .font(.body)
                            .foregroundColor(Color.lightPointColor)
                    }
                }
            }
        }
        .listStyle(.plain)
        
        .onAppear {
            // 뷰모델의 사용자명 설정 및 카테고리 로딩
            spendingViewModel.username = username
            spendingViewModel.loadCategory(context: context)
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
            .environmentObject(SpendingViewModel())
            .modelContainer(
                for: [BasicEntry.self, Category.self, Statics.self],
                inMemory: true
            )
    }
}
