//
//  CategoryView.swift
//  HaruPocket
//
//  Created by YC on 5/12/25.
//

import SwiftUI


// --------------------------------------- 여기부터 나중에 바꿔야 할 거 같음
//struct CategorySample: Identifiable {
//    private(set) var id: UUID
//    private(set) var category: String
//    private(set) var color: Color
//    private(set) var emoji: String
//    private(set) var title: String
//    private(set) var money: Int
//    private(set) var date: Date
//
//    init(category: String, color: Color, emoji: String, title: String = "", money: Int = 0, date: Date = Date()) {
//        if category.isEmpty {
//            self.category = "카테고리 없음"
//            self.color = Color.gray
//            self.emoji = ""
//        } else {
//            self.category = category
//            self.color = color
//            self.emoji = emoji
//        }
//        self.title = title
//        self.money = money
//        self.id = UUID()
//        self.date = date
//    }
//}
// ------------------------------------- 삭제해도 될듯?
struct CategoryView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var showCategoryListComposeView = false
    @State private var showCategoryComposeView = false

    let categories = Category.sampleList
    
    
    
    
    
    
    
    
    // 2열 세로 그리드를 위한 열(column) 구성 설정
    // .flexible()을 사용해 화면 너비에 맞게 유연하게 칼럼 너비가 조정됨

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(categories) { category in
                            NavigationLink(destination: CategoryListView(category: category)) {
                                
                                VStack(spacing: 8) {
                                    Text(category.emoji)
                                        .font(.system(size: 60))
                                    Text(category.name)
                                        .font(.title3)
                                        .foregroundColor(.black)
                                }
                                .frame(width: 160, height: 160)
                                .background(category.color)
                                .cornerRadius(25)
                                .shadow(radius: 0.3)
                                
                            }
                        }
                    }
                    .padding()
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
                                .foregroundColor(Color.lightPointColor)
                        }
                    }
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
                
                // 플로팅 버튼
                Button {
                    showCategoryComposeView = true
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.lightMainColor)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
                .padding()
            }
            
        }
        .navigationDestination(isPresented: $showCategoryListComposeView) {
            CategoryListComposeView(categories: categories)
        }
        .navigationDestination(isPresented: $showCategoryComposeView) {
            CategoryComposeView(category: .constant(nil))
        }
    }
}


#Preview {
    NavigationStack {
        CategoryView()
    }
}
