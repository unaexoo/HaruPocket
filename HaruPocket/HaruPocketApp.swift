//
//  HaruPocketApp.swift
//  HaruPocket
//
//  Created by 장지현 on 5/12/25.
//

import SwiftUI
import SwiftData

@main
struct HaruPocketApp: App {
    @StateObject var spendingViewModel = SpendingViewModel()

    let sharedModelContainer: ModelContainer
    init() {
        let schema = Schema([ BasicEntry.self, Category.self ])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            sharedModelContainer = try ModelContainer(
                for: schema,
                configurations: [config]
            )
        } catch {
            print("모델 컨테이너 생성 실패:", error)

            do {
                sharedModelContainer = try ModelContainer(
                    for: schema,
                    configurations: [
                        ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
                    ]
                )
            } catch {
                fatalError("메모리 컨테이너 생성도 실패: \(error)")
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            CustomCalendarView()
                .environmentObject(spendingViewModel)
                .modelContainer(sharedModelContainer)
        }
    }
}
