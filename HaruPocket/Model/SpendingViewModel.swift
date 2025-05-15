//
//  SpendingViewModel.swift
//  HaruPocket
//
//  Created by 윤혜주 on 5/13/25.
//

import Foundation
import SwiftData
import SwiftUI

/// CRUD
class SpendingViewModel: ObservableObject {
    @Published var spending: [BasicEntry] = []
    @Published var categories: [Category] = []
    @Published var username: String = "default_user"

    func loadEntry(context: ModelContext) {
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

    func loadCategory(context: ModelContext) {
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

//    func addEntry(
//        context: ModelContext,
//        title: String,
//        content: String? = nil,
//        date: Date,
//        money: Int,
//        imageFileName: String? = nil,
//        category: Category?,
//        imageData: Data? = nil
//    ) {
//        let userID = self.username
//        let entry = BasicEntry(
//            title: title,
//            content: content,
//            date: date,
//            money: money,
//            imageFileName: imageFileName,
//            userID: userID,
//            category: category
//        )
//        context.insert(entry)
//
//        let stat = Statics.fetchOrCreate(
//            context: context,
//            userID: userID,
//            categoryName: category?.name ?? "기타",
//            categoryColor: category?.color ?? .gray
//        )
//        stat.updateWith(entry: entry)
//
//        saveContext(context)
//        spending.append(entry)
//
//        if !staticsList.contains(where: { $0.id == stat.id }) {
//            staticsList.append(stat)
//        }
//    }

//    func deleteEntry(context: ModelContext, entry: BasicEntry) {
//        if let stat = staticsList.first(where: {
//            $0.categoryName == entry.category?.name
//        }) {
//            stat.removeEntry(entry)
//        }
//
//        context.delete(entry)
//        saveContext(context)
//        spending.removeAll { $0.id == entry.id }
//    }

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

    func deleteCategory(context: ModelContext, category: Category) {
        let userID = self.username

        var fallbackCategory: Category
        if let existing = categories.first(where: { $0.name == "카테고리 없음" && $0.userID == userID }) {
            fallbackCategory = existing
        } else {
            fallbackCategory = Category(name: "기타", color: .gray, emoji: "📂", userID: userID)
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

            let sampleEntries = try await BasicEntry.sampleList(for: username, in: context)

            for entry in sampleEntries {
                context.insert(entry)
            }

            saveContext(context)
            loadCategory(context: context)
            loadEntry(context: context)

            print("동기 샘플 데이터 삽입 완료")
        } catch {
            print("샘플 데이터 삽입 실패: \(error)")
        }
    }


    func saveContext(_ context: ModelContext) {
        do {
            try context.save()
            print("context 저장 성공")
        } catch {
            print("context 저장 실패:", error.localizedDescription)
        }
    }
}
