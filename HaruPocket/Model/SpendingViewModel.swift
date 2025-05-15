//
//  SpendingViewModel.swift
//  HaruPocket
//
//  Created by 윤혜주 on 5/13/25.
//

import Foundation
import SwiftData
import SwiftUI

/// `SpendingViewModel`은 소비 일기(`BasicEntry`)와 카테고리(`Category`)에 대한 CRUD 및 데이터 로딩을 담당하는 ViewModel입니다.
/// - 사용자별 데이터를 분리하여 관리하며, 샘플 데이터 삽입 기능도 포함되어 있습니다.
class SpendingViewModel: ObservableObject {

    /// 현재 사용자에 해당하는 소비 일기 배열입니다.
    @Published var spending: [BasicEntry] = []

    /// 현재 사용자에 해당하는 카테고리 배열입니다.
    @Published var categories: [Category] = []

    /// 현재 사용자 ID입니다. 기본값은 "default_user"
    @Published var username: String = "default_user"

    /// 소비 일기가 이미 로드되었는지를 나타냅니다.
    @Published var hasLoadedEntry = false

    /// 카테고리가 이미 로드되었는지를 나타냅니다.
    @Published var hasLoadedCategory = false

    /// 소비 일기 데이터를 로드합니다. (1회만 로드)
    /// - Parameter context: SwiftData의 ModelContext
    @MainActor
    func loadEntry(context: ModelContext) {
        guard !hasLoadedEntry else { return }
        hasLoadedEntry = true

        let userID = self.username
        let descriptor = FetchDescriptor<BasicEntry>(
            predicate: #Predicate { $0.userID == userID }
        )
        do {
            spending = try context.fetch(descriptor)
        } catch {
            print("소비 일기 로딩 실패: \(error)")
        }
    }

    /// 카테고리 데이터를 로드합니다. (1회만 로드)
    /// - Parameter context: SwiftData의 ModelContext
    @MainActor
    func loadCategory(context: ModelContext) {
        guard !hasLoadedCategory else { return }
        hasLoadedCategory = true

        let userID = self.username
        let descriptor = FetchDescriptor<Category>(
            predicate: #Predicate { $0.userID == userID }
        )
        do {
            categories = try context.fetch(descriptor)
        } catch {
            print("카테고리 로딩 실패: \(error)")
        }
    }

    /// 기존 소비 일기 항목을 수정합니다.
    func updateEntry(
        context: ModelContext,
        entry: BasicEntry,
        title: String,
        content: String?,
        money: Int,
        category: Category?
    ) {
        entry.title = title
        entry.content = content
        entry.money = money
        entry.category = category
        saveContext(context)
    }

    /// 새로운 카테고리를 추가합니다.
    func addCategory(
        context: ModelContext,
        name: String,
        color: Color,
        emoji: String
    ) {
        let newCategory = Category(
            name: name,
            color: color,
            emoji: emoji,
            userID: self.username
        )
        context.insert(newCategory)
        saveContext(context)
        categories.append(newCategory)
    }

    /// 선택된 카테고리를 삭제하고, 연결된 소비 일기는 "기타" 또는 "카테고리 없음"으로 대체합니다.
    func deleteCategory(context: ModelContext, category: Category) {
        let userID = self.username

        var fallbackCategory: Category
        if let existing = categories.first(where: {
            $0.name == "카테고리 없음" && $0.userID == userID
        }) {
            fallbackCategory = existing
        } else {
            fallbackCategory = Category(
                name: "기타",
                color: .gray,
                emoji: "📂",
                userID: userID
            )
            context.insert(fallbackCategory)
            categories.append(fallbackCategory)
        }

        for entry in spending where entry.category?.id == category.id {
            entry.category = fallbackCategory
        }

        context.delete(category)
        saveContext(context)
        categories.removeAll { $0.id == category.id }
    }

    /// 카테고리 정보를 수정합니다.
    func updateCategory(
        context: ModelContext,
        category: Category,
        name: String,
        color: Color
    ) {
        category.name = name
        category.color = color
        saveContext(context)
    }

    /// 샘플 데이터를 데이터베이스에 삽입합니다.
    /// - categories와 spending이 비어 있는 경우에만 동작합니다.
    func insertSampleData(context: ModelContext) async {
        guard categories.isEmpty && spending.isEmpty else { return }

        let sampleCategories = Category.sampleList
        for category in sampleCategories {
            context.insert(category)
        }

        do {
            let userID = self.username
            let descriptor = FetchDescriptor<Category>(
                predicate: #Predicate { $0.userID == userID }
            )
            _ = try context.fetch(descriptor)

            let sampleEntries = try await BasicEntry.sampleList(
                for: username,
                in: context
            )

            for entry in sampleEntries {
                context.insert(entry)
            }

            saveContext(context)
            await loadCategory(context: context)
            await loadEntry(context: context)

            print("동기 샘플 데이터 삽입 완료")
        } catch {
            print("샘플 데이터 삽입 실패: \(error)")
        }
    }

    /// SwiftData의 컨텍스트를 저장합니다.
    func saveContext(_ context: ModelContext) {
        do {
            try context.save()
            print("context 저장 성공")
        } catch {
            print("context 저장 실패:", error.localizedDescription)
        }
    }
}
