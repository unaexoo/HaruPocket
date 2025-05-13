import SwiftUI
import SwiftData

struct CustomCalendarView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.colorScheme) private var colorScheme
    @AppStorage("username") private var username: String = "default_user"

    @StateObject private var calendarViewModel: CalendarViewModel
    @StateObject private var spendingViewModel = SpendingViewModel()

    init() {
        let storedUsername = UserDefaults.standard.string(forKey: "username") ?? "default_user"
        _calendarViewModel = StateObject(wrappedValue: CalendarViewModel(username: storedUsername))
        _spendingViewModel = StateObject(wrappedValue: SpendingViewModel())
    }

    private let columns = Array(repeating: GridItem(.flexible()), count: 7)

    var body: some View {
        VStack {
            Text("지갑 속 하루")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)

            headerView
            weekdayHeader

            Rectangle()
                .fill(.quaternary)
                .frame(width: 400, height: 0.5)

            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(calendarViewModel.daysInMonth(), id: \.self, content: dayCell)
            }

            Rectangle()
                .fill(.quaternary)
                .frame(width: 400, height: 0.5)

            entriesList(for: calendarViewModel.selectedDate)
            Spacer()

        }
        .padding()
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

    private var headerView: some View {
        HStack {
            Button(action: { calendarViewModel.currentMonthOffset -= 1 }) {
                Image(systemName: "chevron.left")
            }

            Spacer()

            Text(calendarViewModel.monthFormatter(from: calendarViewModel.currentDate))
                .font(.headline)
                .foregroundStyle(colorScheme == .dark ? Color.darkPointColor : Color.lightPointColor)

            Spacer()

            Button(action: { calendarViewModel.currentMonthOffset += 1 }) {
                Image(systemName: "chevron.right")
            }
        }
        .tint(colorScheme == .dark ? Color.darkPointColor : Color.lightPointColor)
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
        let day = Calendar.current.component(.day, from: date)
        let entriesForDay = spendingViewModel.spending.filter {
            Calendar.current.isDate($0.date, inSameDayAs: date)
        }
        let isSelected = calendarViewModel.isSameDay(date, calendarViewModel.selectedDate)

        return VStack(spacing: 4) {
            Text("\(day)")
                .font(.system(size: 14, weight: .medium))
                .foregroundStyle(calendarViewModel.isCurrentMonth(date) ? .primary : .quaternary)
                .frame(width: 30, height: 30)

            HStack(spacing: 2) {
                ForEach(entriesForDay.prefix(3), id: \.id) { entry in
                    Circle()
                        .fill(entry.category?.color ?? .gray.opacity(0.3))
                        .frame(width: 6, height: 6)
                }
            }
        }
        .frame(width: 40, height: 50)
        .background(
            Circle()
                .fill(isSelected ? Color.lightMainColor.opacity(0.2) : .clear)
        )
        .onTapGesture {
            calendarViewModel.selectedDate = date
        }
    }

    private func entriesList(for date: Date) -> some View {
        let filteredEntries = spendingViewModel.spending.filter {
            $0.userID == spendingViewModel.username && Calendar.current.isDate($0.date, inSameDayAs: date)
        }

        return VStack(alignment: .leading, spacing: 8) {
            if filteredEntries.isEmpty {
                Text("기록된 소비가 없어요.")
                    .foregroundStyle(.secondary)
                    .font(.callout)
            } else {
                ForEach(filteredEntries, id: \.id) { entry in
                    HStack {
                        Text(entry.title)
                        Spacer()
                        Text("\(entry.money)원")
                            .bold()
                    }
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.gray.opacity(0.1))
                    )
                }
            }
        }
        .padding(.top)
    }
}


#Preview {
    CustomCalendarView()
        .modelContainer(for: [BasicEntry.self, Category.self, Statics.self], inMemory: true)
}
