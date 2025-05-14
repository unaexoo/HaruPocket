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
    let sharedModelContainer: ModelContainer
    init() {
        let schema = Schema([ BasicEntry.self, Category.self, Statics.self ])
        let config = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            sharedModelContainer = try ModelContainer(
                for: schema,
                configurations: [config]
            )
        } catch {
            print("모델 컨테이너 생성 실패:", error)

            sharedModelContainer = try! ModelContainer(
                for: schema,
                configurations: [
                    ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
                ]
            )
        }
    }

    var body: some Scene {
        WindowGroup {
            CustomCalendarView()
                .modelContainer(sharedModelContainer)
        }
    }
}
