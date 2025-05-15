import SwiftData
import SwiftUI

struct CustomCalendarView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.colorScheme) private var colorScheme
    @AppStorage("username") private var username: String = "default_user"

    @StateObject private var calendarViewModel: CalendarViewModel
    @EnvironmentObject var spendingViewModel: SpendingViewModel

    @State private var showYearPicker = false
    @State private var selectedYear = Calendar.current.component(
        .year,
        from: Date()
    )

    @Environment(\.dismiss) var dismiss

    @State private var selectedTab = 2
    @State var isLaunching: Bool = true
    @State private var showComposeView = false

    private let columns = Array(repeating: GridItem(.flexible()), count: 7)

    init() {
        let storedUsername =
            UserDefaults.standard.string(forKey: "username") ?? "default_user"
        _calendarViewModel = StateObject(
            wrappedValue: CalendarViewModel(username: storedUsername)
        )
    }

    var body: some View {
        if isLaunching {
            SplashView(colorScheme: colorScheme)
                .ignoresSafeArea()
                .zIndex(1)
                .transition(.opacity)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation(.easeOut(duration: 1)) {
                            isLaunching = false
                        }
                    }
                }
        } else {
            ZStack(alignment: .bottomTrailing) {
                TabView(selection: $selectedTab) {
                    NavigationStack {
                        CategoryView()
                            .navigationTitle("카테고리")
                    }
                    .tabItem {
                        Label("카테고리", systemImage: "tag")
                    }
                    .tag(0)

                    NavigationStack {
                        CategoryView()
                            .navigationTitle("리스트")
                            .toolbar(.hidden, for: .navigationBar)
                    }
                    .tabItem {
                        Label("리스트", systemImage: "list.bullet")
                    }
                    .tag(1)

                    NavigationStack {
                        ZStack(alignment: .bottomTrailing) {
                            homeTabView
                            if showComposeView == false {
                                floatingAddButton
                                    .frame(
                                        maxWidth: .infinity,
                                        alignment: .trailing
                                    )
                                    .padding(.trailing, 20)
                            }
                        }
                        .navigationTitle("지갑 속 하루")
                        .navigationBarTitleDisplayMode(.large)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button {
                                    showYearPicker.toggle()
                                } label: {
                                    HStack {
                                        Text("\(String(selectedYear))년")
                                        Image(systemName: "chevron.down")
                                    }
                                    .font(.headline)
                                    .foregroundStyle(
                                        colorScheme == .dark
                                        ? Color.darkPointColor
                                        : Color.lightPointColor
                                    )
                                    .offset(y: 45)

                                }
                            }
                        }
                        .sheet(isPresented: $showYearPicker) {
                            yearPickerSheet
                        }
                        .navigationDestination(isPresented: $showComposeView) {
                            ComposeView(date: calendarViewModel.selectedDate, basics: .constant(nil))
                                .onDisappear {
                                    showComposeView = false
                                    spendingViewModel.loadEntry(
                                        context: context
                                    )
                                }
                        }
                    }
                    .tabItem {
                        Label("홈", systemImage: "house")
                    }
                    .tag(2)

                    NavigationStack {
                        CategoryView()
                            .navigationTitle("사진")
                    }
                    .tabItem {
                        Label("사진", systemImage: "photo")
                    }
                    .tag(3)

                    NavigationStack {
                        StatisticsView()
                            .navigationTitle("통계")
                    }
                    .tabItem {
                        Label("통계", systemImage: "chart.pie")
                    }
                    .tag(4)
                }
            }
            .tint(
                colorScheme == .dark
                    ? Color.darkMainColor : Color.lightMainColor
            )
            .onAppear {
                spendingViewModel.username = username
                spendingViewModel.loadCategory(context: context)
                spendingViewModel.loadEntry(context: context)
                spendingViewModel.updateStatics(context: context)
                Task {
                    await spendingViewModel.insertSampleData(context: context)
                }
            }
        }
    }

    private var homeTabView: some View {
        VStack(spacing: 10) {
            headerView
            Rectangle()
                .fill(.quaternary)
                .frame(width: 400, height: 0.5)

            weekdayHeader

            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(
                    calendarViewModel.daysInMonth(),
                    id: \.self,
                    content: dayCell
                )
            }

            Rectangle()
                .fill(.quaternary)
                .frame(width: 400, height: 0.5)

            EntryListView(
                date: calendarViewModel.selectedDate,
                entries: spendingViewModel.spending,
                username: spendingViewModel.username,
                spendingViewModel: spendingViewModel
            )

            Spacer()
        }
        .padding(.horizontal, 5)
        .padding()
    }

    private var floatingAddButton: some View {
        ZStack {
            Button {
                showComposeView = true
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
                    .background(Color.lightMainColor)
                    .clipShape(Circle())
                    .shadow(radius: 4)
            }

        }
        .padding(.trailing, 20)
        .padding(.bottom, 20)
    }

    private var headerView: some View {
        HStack {
            Button {
                calendarViewModel.currentMonthOffset -= 1
            } label: {
                Image(systemName: "chevron.left")
            }

            Spacer()

            Text(
                calendarViewModel.monthFormatter(
                    from: calendarViewModel.currentDate
                )
            )
            .font(.headline)
            .foregroundStyle(
                colorScheme == .dark
                    ? Color.darkPointColor : Color.lightPointColor
            )

            Spacer()

            Button {
                calendarViewModel.currentMonthOffset += 1
            } label: {
                Image(systemName: "chevron.right")
            }
        }
        .tint(
            colorScheme == .dark ? Color.darkPointColor : Color.lightPointColor
        )
        .padding(.vertical)
    }

    private var weekdayHeader: some View {
        let weekdays = ["일", "월", "화", "수", "목", "금", "토"]
        return HStack {
            ForEach(weekdays, id: \.self) {
                Text($0)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
            }
        }
    }

    private func dayCell(for date: Date) -> some View {
        let entriesForDay = spendingViewModel.spending.filter {
            Calendar.current.isDate($0.date, inSameDayAs: date)
        }

        return DayCellView(
            date: date,
            entries: entriesForDay,
            isSelected: calendarViewModel.isSameDay(
                date,
                calendarViewModel.selectedDate
            ),
            isCurrentMonth: calendarViewModel.isCurrentMonth(date),
            onSelect: { calendarViewModel.selectedDate = date }
        )
    }

    private var yearPickerSheet: some View {
        VStack {
            Text("연도 선택")
                .font(.headline)

            Picker("연도", selection: $selectedYear) {
                ForEach(2000...2030, id: \.self) { year in
                    Text("\(String(year))년").tag(year)
                }
            }
            .pickerStyle(.wheel)

            Button("확인") {
                let currentMonth = Calendar.current.component(
                    .month,
                    from: calendarViewModel.currentDate
                )
                if let targetDate = Calendar.current.date(
                    from: DateComponents(
                        year: selectedYear,
                        month: currentMonth
                    )
                ) {
                    calendarViewModel.move(to: targetDate)
                }
                showYearPicker = false
            }
            .padding()
        }
        .presentationDetents([.medium])
    }

}

#Preview {
    NavigationStack {
        CustomCalendarView()
            .modelContainer(
                for: [BasicEntry.self, Category.self, Statics.self],
                inMemory: true
            )
            .environmentObject(SpendingViewModel())
    }
}

struct CategoryDotView: View {
    let entries: [BasicEntry]

    var body: some View {
        let groupedByCategory = Dictionary(
            grouping: entries,
            by: { $0.category?.id ?? UUID() }
        )

        let uniqueEntries = groupedByCategory.values
            .compactMap { $0.first }
            .sorted {
                let nameA = $0.category?.name ?? ""
                let nameB = $1.category?.name ?? ""
                return nameA < nameB
            }

        let displayEntries = Array(uniqueEntries.prefix(10))

        HStack(spacing: 2) {
            if displayEntries.isEmpty {
                Color.clear.frame(width: 0, height: 10)

            } else if displayEntries.count < 3 {
                ForEach(displayEntries, id: \.id) { entry in
                    Circle()
                        .fill(entry.category?.color ?? Color.gray.opacity(0.3))
                        .frame(width: 5, height: 5)
                }

            } else {
                HStack(spacing: 0) {
                    ForEach(
                        Array(displayEntries.enumerated()),
                        id: \.element.id
                    ) { index, entry in
                        Circle()
                            .fill(
                                entry.category?.color ?? Color.gray.opacity(0.3)
                            )
                            .frame(width: 5, height: 5)
                            .offset(x: CGFloat(index) * -1)
                    }
                }
            }
        }
        .frame(height: 10)
    }
}

struct DayCellView: View {
    let date: Date
    let entries: [BasicEntry]
    let isSelected: Bool
    let isCurrentMonth: Bool
    let onSelect: () -> Void

    var body: some View {
        let day = Calendar.current.component(.day, from: date)

        VStack(spacing: 0) {
            ZStack {
                if isSelected {
                    Circle()
                        .fill(Color.lightMainColor.opacity(0.2))
                        .frame(width: 20, height: 20)
                }

                Text("\(day)")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(
                        isCurrentMonth ? .primary : .quaternary
                    )
            }
            .frame(height: 20)

            CategoryDotView(entries: entries)
        }
        .frame(width: 40, height: 40)
        .onTapGesture {
            onSelect()
        }
    }

}

struct EntryListView: View {
    let date: Date
    let entries: [BasicEntry]
    let username: String
    @ObservedObject var spendingViewModel: SpendingViewModel

    var body: some View {
        let filtered = entries.filter {
            $0.userID == username
                && Calendar.current.isDate($0.date, inSameDayAs: date)
        }

        let grouped = Dictionary(grouping: filtered) {
            $0.category?.name ?? "기타"
        }
        let sortedKeys = grouped.keys.sorted()

        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .leading) {
                if filtered.isEmpty {
                    Text("기록된 소비가 없어요.")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(sortedKeys, id: \.self) { key in
                        if let group = grouped[key] {
                            VStack(alignment: .leading, spacing: 0) {
                                Text(key)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .padding(.vertical, 4)

                                ForEach(group, id: \.id) { entry in
                                    if let index = spendingViewModel.spending
                                        .firstIndex(where: { $0.id == entry.id }
                                        )
                                    {
                                        NavigationLink(
                                            destination: DetailView(
                                                basics:
                                                    $spendingViewModel.spending[
                                                        index
                                                    ]
                                            )
                                        ) {
                                            HStack {
                                                Circle()
                                                    .fill(
                                                        entry.category?.color
                                                            ?? .gray
                                                    )
                                                    .frame(
                                                        width: 10,
                                                        height: 10
                                                    )

                                                Text(entry.title)
                                                    .foregroundStyle(.primary)
                                                    .lineLimit(1)

                                                Spacer()

                                                Text(
                                                    "\(entry.money.formatted())원"
                                                )
                                                .foregroundStyle(.secondary)
                                                Image(
                                                    systemName: "chevron.right"
                                                )
                                                .foregroundColor(.gray)
                                            }
                                            .padding(.vertical, 8)
                                        }
                                        .buttonStyle(.plain)
                                        .navigationBarBackButtonHidden(true)
                                    }
                                }
                            }
                            .padding(.bottom, 8)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct SplashView: View {
    let colorScheme: ColorScheme
    var body: some View {
        Image("pocekt")
            .resizable()
            .scaledToFit()
            .overlay(
                Text("지갑 속 하루")
                    .font(.custom("Jua-Regular", size: 20))
                    .bold()
                    .foregroundStyle(
                        colorScheme == .dark
                            ? Color.darkPointColor
                            : Color.lightPointColor
                    )
                    .padding(.bottom),
                alignment: .bottom
            )
            .ignoresSafeArea()
    }
}
