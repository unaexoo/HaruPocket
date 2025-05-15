import SwiftUI
import SwiftData

/// `CategoryListComposeView`는 사용자가 생성한 카테고리들을 리스트 형태로 보여주고, 편집 및 삭제 기능을 제공하는 뷰입니다.
/// - 삭제 모드로 전환되면 항목 옆에 체크박스가 표시되며, 선택된 항목들을 삭제할 수 있습니다.
/// - 삭제 버튼을 누르면 해당 카테고리를 categories 배열에서 제거하고, 선택도 초기화됩니다.
/// - 일반 모드에서는 카테고리를 선택 시 상세 뷰(CategoryView)로 이동합니다.
struct CategoryListComposeView: View {
    @AppStorage("username") private var username: String = "default_user"

    @EnvironmentObject var spendingViewModel: SpendingViewModel

    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme
    @Environment(\.editMode) private var editMode

    // 체크된 카테고리의 ID들을 저장하는 Set (삭제 등의 작업에 사용)
    @State private var selectedCategoryIDs: Set<UUID> = []

    // 편집 모드 여부를 제어하는 상태 변수
    @State private var showDeleteConfirmation = false
    @State private var showSelectAlert = false

    @State private var showCateogryComposeView = false

    var body: some View {
        let allCategories = spendingViewModel.categories
        let categories = allCategories
            .filter {
                $0.userID == spendingViewModel.username &&
                $0.name != "카테고리 없음"
            }
            .sorted { $0.name < $1.name }

        List(categories, id: \.id, selection: $selectedCategoryIDs) { category in
            let categoryID = category.id

            if let index = allCategories.firstIndex(where: { $0.id == categoryID }) {
                let binding = Binding<Category?>(
                    get: { allCategories[index] },
                    set: { newValue in
                        if let newValue {
                            spendingViewModel.categories[index] = newValue
                        }
                    })

                NavigationLink(destination: CategoryComposeView(category: binding)) {
                    HStack(spacing: 12) {
                        Text(category.name)
                    }
                    .padding(.vertical, 6)
                }
                .tag(category.id)
                .listRowBackground(Color.clear)
            }
        }
        .padding(.vertical)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    if editMode?.wrappedValue.isEditing == true {
                        editMode?.wrappedValue = .inactive
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
                if editMode?.wrappedValue.isEditing == true {
                    Button {
                        showDeleteConfirmation = true
                    } label: {
                        Image(systemName: "trash")
                    }
                } else {
                    Button {
                        withAnimation {
                            editMode?.wrappedValue = .active
                        }
                    } label: {
                        Text("편집")
                            .font(.title3)
                            .foregroundColor(Color.lightPointColor)
                    }
                }
            }
        }
        .listStyle(.plain)
        .onAppear {
            // 뷰모델의 사용자명 설정 및 카테고리 로딩
            spendingViewModel.loadCategory(context: context)
        }
        .alert(
            Text("카테고리를 삭제하시겠습니까?"),
            isPresented: $showDeleteConfirmation,
            actions: {
                Button("삭제", role: .destructive) {
                    let idsToDelete = selectedCategoryIDs

                    for id in idsToDelete {
                        if let index = spendingViewModel.categories.firstIndex(where: { $0.id == id }) {
                            let category = spendingViewModel.categories[index]
                            spendingViewModel.deleteCategory(context: context, category: category)
                        }
                    }

                    selectedCategoryIDs.removeAll()
                    editMode?.wrappedValue = .inactive
                }
                Button("취소", role: .cancel) { }
            },
            message: {
                Text("카테고리를 삭제하면, 기존에 있던 일기는 '카테고리 없음'으로 이동됩니다.")
            }
        )
    }
}




#Preview {
    NavigationStack {
        CategoryListComposeView()
            .environmentObject(SpendingViewModel())
            .modelContainer(
                for: [BasicEntry.self, Category.self],
                inMemory: true
            )
    }
}
