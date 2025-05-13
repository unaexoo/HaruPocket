//
//  MainTabView.swift
//  HaruPocekt_test1
//
//  Created by 윤혜주 on 5/13/25.
//

import SwiftUI
import SwiftData

struct MainTabView: View {
    @ObservedObject var viewModel: SpendingViewModel
    @Environment(\.modelContext) private var context
    @AppStorage("userID") private var userID: String = "default_user"

    var body: some View {
        TabView {
            CustomCalendarView(viewModel: viewModel)
                .tabItem { Label("달력", systemImage: "calendar") }
        }
        .onAppear {
            viewModel.username = userID
            viewModel.loadCategory(context: context)
            viewModel.loadEntry(context: context)
            viewModel.updateStatics(context: context)
            Task {
                await viewModel.insertSampleData(context: context)
            }

        }
    }
}
