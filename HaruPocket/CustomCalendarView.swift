import SwiftData
import SwiftUI

/// `CustomCalendarView`는 지갑 속 하루 앱의 주요 달력 및 홈 화면을 제공하는 뷰입니다.
/// - 달력에서 날짜를 선택하고 해당 날짜의 소비 내역을 확인하거나 생성할 수 있습니다.
/// - 탭 뷰를 통해 카테고리, 리스트, 홈, 사진, 통계 화면 간의 전환을 제공합니다.
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

    /// 달력 그리드 열
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)

    /// 초기화 시 UserDefaults에서 저장된 사용자 이름을 calendarViewModel에 전달합니다.
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
                        CategoryListView(category: .constant(nil))
                            .navigationTitle("리스트")
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
                        .overlay(alignment: .topTrailing) {
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
                                .padding(.trailing, 30)
                                .padding(.bottom, 10)
                            }
                        }
                        .sheet(isPresented: $showYearPicker) {
                            yearPickerSheet
                        }
                        .navigationDestination(isPresented: $showComposeView) {
                            ComposeView(
                                date: calendarViewModel.selectedDate,
                                basics: .constant(nil)
                            )
                            .onDisappear {
                                showComposeView = false
                                spendingViewModel.hasLoadedEntry = false
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
                        PhotoView()
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
                if spendingViewModel.username != username {
                    spendingViewModel.username = username
                }

                Task {
                    await spendingViewModel.insertSampleData(context: context)

                    spendingViewModel.hasLoadedEntry = false
                    spendingViewModel.hasLoadedCategory = false
                    spendingViewModel.loadCategory(context: context)
                    spendingViewModel.loadEntry(context: context)
                }


            }
        }
    }

    /// 홈 탭
    /// - 달력, 요일 헤더, 해당 날짜의 소비 내역 리스트를 포함
    private var homeTabView: some View {
        VStack(spacing: 10) {
            headerView  // 달력 상단 헤더
            Rectangle()
                .fill(.quaternary)
                .frame(width: 400, height: 0.5)

            weekdayHeader  // 요일 헤더

            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(
                    calendarViewModel.daysInMonth(),
                    id: \.timeIntervalSince1970
                ) {
                    dayCell(for: $0)
                }
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

    /// + 버튼
    /// - 홈 탭의 오른쪽 아래 위치한 소비 일기 추가 버튼입니다.
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

    /// 달력 상단 헤더
    /// - 이전, 다음 월 이동 동작을 수행합니다.
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
        .padding()
    }

    /// 달력 요일 헤더
    /// - 달력의 일-토 표시를 합니다.
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

    /// 개별 날짜 셀을 생성합니다
    /// - Parameter date: 셀에 해당하는 날짜
    /// - Returns: 해당 날자의 소비 내역과 함께 셀 뷰를 반환합니다.
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

    /// 연도 선택 시트(View)
    /// - Picker를 통해 연도를 선택하고 해당 연도의 현재 월로 이동합니다.
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
                let selected = calendarViewModel.selectedDate
                let components = Calendar.current.dateComponents([.month, .day], from: selected)

                if let targetDate = Calendar.current.date(from: DateComponents(
                    year: selectedYear,
                    month: components.month,
                    day: components.day
                )) {
                    calendarViewModel.move(to: targetDate)
                    calendarViewModel.selectedDate = targetDate
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
                for: [BasicEntry.self, Category.self],
                inMemory: true
            )
            .environmentObject(SpendingViewModel())
    }
}

/// `CategoryDotView`는 달력 날짜 셀 하단에 소비 카테고리별 색상 점들을 시각적으로 표현하는 뷰입니다.
/// - 하나의 날짜에 여러 소비 항목이 있을 경우 카테고리별로 정리하여 최대 5개의 점만 표시합니다.
/// - 카테고리가 2개 이하인 경우: 단순히 나란히 점을 나열합니다.
/// - 카테고리가 3개 이상인 경우: 좌측으로 살짝 겹쳐지도록 점을 중첩 배치합니다.
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

        let displayEntries = Array(uniqueEntries.prefix(5))

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

/// `DayCellView`는 달력의 개별 날짜 셀을 시각적으로 표현하는 뷰입니다.
/// - 선택된 날짜일 경우 테두리 강조 표시가 적용되며,
/// - 해당 월의 날짜인지에 따라 텍스트 색상을 다르게 적용합니다.
/// - 하단에 `CategoryDotView`를 통해 소비 카테고리 시각화도 포함됩니다.
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

/// `EntryListView`는 선택한 날짜에 해당하는 소비 일기를 카테고리별로 분류하여 표시하는 뷰입니다.
/// - 각 카테고리별로 소비 일기를 그룹화하여 목록으로 나열합니다.
/// - 항목을 클릭하면 상세 화면(`DetailView`)으로 이동할 수 있습니다.
struct EntryListView: View {
    let date: Date
    let entries: [BasicEntry]
    let username: String
    @ObservedObject var spendingViewModel: SpendingViewModel
    @Environment(\.modelContext) private var context

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
                                    let entryID = entry.id

                                    if let index = spendingViewModel.spending
                                        .firstIndex(where: { $0.id == entryID }
                                        )
                                    {
                                        NavigationLink(
                                            destination: DetailView(
                                                basics:
                                                    $spendingViewModel.spending[
                                                        index
                                                    ]
                                            )
                                            .onDisappear {
                                                spendingViewModel.hasLoadedEntry = false
                                                spendingViewModel.loadEntry(
                                                    context: context
                                                )
                                            }
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

/// `SplashView`는 앱 시작 시 잠시 표시되는 스플래시 화면 뷰입니다.
/// - 앱 로고 이미지와 앱 이름 텍스트가 포함되어 있으며, 라이트/다크 모드에 따라 색상이 달라집니다.
struct SplashView: View {
    let colorScheme: ColorScheme
    var body: some View {
        Image("pocket")
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
