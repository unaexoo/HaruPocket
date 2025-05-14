import SwiftData
import SwiftUI

struct CustomCalendarView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.colorScheme) private var colorScheme
    @AppStorage("username") private var username: String = "default_user"

    @StateObject private var calendarViewModel: CalendarViewModel
    @StateObject private var spendingViewModel = SpendingViewModel()

    @Environment(\.dismiss) var dismiss

    @State private var selectedTab = 2
    @State private var prevTab = 2

    enum ModalTab: Int, Identifiable {
        case category = 0
        case list = 1
        case photo = 3
        case stats = 4
        var id: Int { rawValue }

        var title: String {
            switch self {
            case .category: return "카테고리"
            case .list: return "리스트"
            case .photo: return "사진"
            case .stats: return "통계"
            }
        }
    }
    @State private var activeModal: ModalTab? = nil

    @State var isLaunching: Bool = true

    private let columns = Array(repeating: GridItem(.flexible()), count: 7)

    init() {
        let storedUsername =
            UserDefaults.standard.string(forKey: "username") ?? "default_user"
        _calendarViewModel = StateObject(
            wrappedValue: CalendarViewModel(username: storedUsername)
        )
        _spendingViewModel = StateObject(wrappedValue: SpendingViewModel())
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
            NavigationStack {
                ZStack {
                    TabView(selection: $selectedTab) {
                        Color.clear
                            .tabItem { Label("카테고리", systemImage: "tag") }
                            .tag(0)

                        Color.clear
                            .tabItem {
                                Label("리스트", systemImage: "list.bullet")
                            }
                            .tag(1)

                        homeTabView
                            .toolbar(.hidden, for: .navigationBar)
                            .tabItem { Label("홈", systemImage: "house") }
                            .tag(2)

                        Color.clear
                            .tabItem { Label("사진", systemImage: "photo") }
                            .tag(3)

                        Color.clear
                            .tabItem { Label("통계", systemImage: "chart.pie") }
                            .tag(4)
                    }
                    if selectedTab == 2 {
                        floatingAddButton
                    }
                }
                .toolbar(.hidden, for: .navigationBar)
                .onChange(of: selectedTab) { _, new in
                    if let modal = ModalTab(rawValue: new) {
                        activeModal = modal
                        selectedTab = prevTab
                    } else {
                        prevTab = new
                    }
                }
                .fullScreenCover(item: $activeModal) { modal in
                    NavigationStack {
                        Group {
                            switch modal {
                            case .category:
                                CategoryView()
                            case .list:
                                CategoryView()
                            case .photo:
                                CategoryView()
                            case .stats:
                                StatisticsView()
                            }
                        }
                    }
                    .navigationTitle(modal.title)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                activeModal = nil
                            } label: {
                                Image(systemName: "xmark")
                                    .font(.body.weight(.bold))
                            }
                        }
                    }
                }
            }
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
        VStack {
            Text("지갑 속 하루")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)

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
                username: spendingViewModel.username
            )

            Spacer()
        }
        .padding(.horizontal, 5)
        .padding()
    }

    private var floatingAddButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                NavigationLink(destination: ComposeView()) {
                    Image(systemName: "plus")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 56, height: 56)
                        .background(Color.lightMainColor)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
                .padding(.trailing, 20)
                .padding(.bottom, 70)
            }
        }
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
}

#Preview {
    NavigationStack {
        CustomCalendarView()
            .modelContainer(
                for: [BasicEntry.self, Category.self, Statics.self],
                inMemory: true
            )
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

        VStack(spacing: 4) {
            Text("\(day)")
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(
                    isCurrentMonth ? .primary : .quaternary
                )
                .frame(width: 30, height: 30)

            CategoryDotView(entries: entries)
        }
        .frame(width: 40, height: 40)
        .background(
            Circle()
                .fill(isSelected ? Color.lightMainColor.opacity(0.2) : .clear)
        )
        .onTapGesture {
            onSelect()
        }
    }
}

struct EntryListView: View {
    let date: Date
    let entries: [BasicEntry]
    let username: String

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
                                    NavigationLink(
                                        destination: CategoryView() /*DetailView(entry: entry)*/
                                    ) {
                                        HStack {
                                            Circle()
                                                .fill(
                                                    entry.category?.color
                                                        ?? .gray
                                                )
                                                .frame(width: 10, height: 10)

                                            Text(entry.title)
                                                .foregroundStyle(.primary)
                                                .lineLimit(1)

                                            Spacer()

                                            Text("\(entry.money.formatted())원")
                                                .foregroundStyle(.secondary)

                                            Image(systemName: "chevron.right")
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.vertical, 8)
                                    }
                                    .buttonStyle(.plain)
                                    .navigationBarBackButtonHidden(true)
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
