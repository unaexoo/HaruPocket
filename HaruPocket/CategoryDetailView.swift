//
//  CategoryDetailView.swift
//  HaruPocket
//
//  Created by 고재현 on 5/14/25.
//

//import SwiftUI
//
//struct CategoryDetailView: View {
//    @State private var category = CategoryModel(
//        title: "음식",
//        color: .pink,
//        emoji: "🍡"
//    )
//
//    @State private var isEditActive = false
//    @State private var showDeleteAlert = false
//
//    var body: some View {
//        VStack(spacing: 30) {
//            VStack(alignment: .leading, spacing: 4) {
//                Text("제목")
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
//                    .padding(.leading, 10)
//
//                Text(category.title)
//                    .padding(10)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 8)
//                            .stroke(Color.brown, lineWidth: 1)
//                    )
//            }
//
//            VStack {
//                HStack {
//                    Text("색상")
//                        .font(.title2)
//                        .foregroundColor(.black)
//
//                    Spacer()
//
//                    Circle()
//                        .fill(category.color)
//                        .frame(width: 18, height: 18)
//                }
//                .padding(.horizontal, 10)
//            }
//
//            HStack {
//                Text("이모지")
//                    .font(.title2)
//                    .foregroundColor(.black)
//
//                Spacer()
//
//                Text(category.emoji)
//                    .font(.title2)
//            }
//            .padding(.horizontal, 10)
//
//            Spacer()
//        }
//        .padding()
//        .padding(.top, -30)
//        .navigationBarBackButtonHidden(true)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarLeading) {
//                Button {
//                    // 뒤로가기
//                } label: {
//                    Image(systemName: "chevron.backward")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 20, height: 20)
//                        .foregroundColor(Color.lightPointColor)
//                }
//            }
//
//            ToolbarItem(placement: .principal) {
//                Text("상세 화면")
//                    .font(.title2)
//            }
//
//            ToolbarItemGroup(placement: .navigationBarTrailing) {
//                Button {
//                    isEditActive = true
//                } label: {
//                    Image(systemName: "pencil")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 20, height: 20)
//                        .foregroundColor(Color.lightPointColor)
//                }
//
//                Button {
//                    showDeleteAlert = true
//                } label: {
//                    Image(systemName: "trash")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 20, height: 20)
//                        .foregroundColor(Color.lightPointColor)
//                }
//            }
//        }
//        .alert("정말 삭제하시겠습니까?", isPresented: $showDeleteAlert) {
//                    Button("네", role: .destructive) {
//                        // TODO: 삭제 로직 추가 예정
//                    }
//                    Button("아니오", role: .cancel) {
//                        showDeleteAlert = false
//                    }
//                }
//        .sheet(isPresented: $isEditActive) {
//            CategoryEditView(
//                category: category,
//                onSave: { updated in
//                    category = updated
//                    isEditActive = false
//                },
//                onCancel: {
//                    isEditActive = false
//                }
//            )
//        }
//    }
//}
//
//#Preview {
//    NavigationStack {
//        CategoryDetailView()
//    }
//}
