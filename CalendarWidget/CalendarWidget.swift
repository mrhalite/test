import WidgetKit
import SwiftUI

struct CalendarEntry: TimelineEntry {
    let date: Date
}

struct CalendarProvider: TimelineProvider {
    func placeholder(in context: Context) -> CalendarEntry {
        CalendarEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (CalendarEntry) -> Void) {
        let entry = CalendarEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<CalendarEntry>) -> Void) {
        let currentDate = Date()
        let entry = CalendarEntry(date: currentDate)

        // 매일 자정에 업데이트
        let tomorrow = Calendar.current.startOfDay(for: Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!)
        let timeline = Timeline(entries: [entry], policy: .after(tomorrow))

        completion(timeline)
    }
}

struct CalendarWidgetEntryView: View {
    var entry: CalendarEntry
    @Environment(\.widgetFamily) var widgetFamily

    var body: some View {
        switch widgetFamily {
        case .systemSmall:
            SmallCalendarWidget(date: entry.date)
        case .systemMedium:
            MediumCalendarWidget(date: entry.date)
        case .systemLarge:
            LargeCalendarWidget(date: entry.date)
        @unknown default:
            SmallCalendarWidget(date: entry.date)
        }
    }
}

// 작은 위젯 - 오늘 날짜 표시
struct SmallCalendarWidget: View {
    let date: Date

    var body: some View {
        VStack(spacing: 8) {
            Text(monthString)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.secondary)

            Text(dayString)
                .font(.system(size: 50, weight: .bold))
                .foregroundColor(.primary)

            Text(weekdayString)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }

    private var monthString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }

    private var dayString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: date)
    }

    private var weekdayString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
}

// 중간 위젯 - 이번 주 표시
struct MediumCalendarWidget: View {
    let date: Date
    private let calendar = Calendar.current

    var body: some View {
        VStack(spacing: 12) {
            HStack {
                Text(monthYearString)
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
            }

            HStack(spacing: 4) {
                ForEach(getWeekDays(), id: \.self) { day in
                    VStack(spacing: 4) {
                        Text(weekdayString(for: day))
                            .font(.caption2)
                            .foregroundColor(.secondary)

                        Text("\(calendar.component(.day, from: day))")
                            .font(.system(size: 14))
                            .fontWeight(calendar.isDateInToday(day) ? .bold : .regular)
                            .foregroundColor(calendar.isDateInToday(day) ? .white : .primary)
                            .frame(width: 30, height: 30)
                            .background(
                                Circle()
                                    .fill(calendar.isDateInToday(day) ? Color.blue : Color.clear)
                            )
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }

    private var monthYearString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }

    private func getWeekDays() -> [Date] {
        guard let weekInterval = calendar.dateInterval(of: .weekOfMonth, for: date) else {
            return []
        }

        var days: [Date] = []
        var currentDate = weekInterval.start

        for _ in 0..<7 {
            days.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
        }

        return days
    }

    private func weekdayString(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }
}

// 큰 위젯 - 한 달 전체 표시
struct LargeCalendarWidget: View {
    let date: Date
    private let calendar = Calendar.current
    private let daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"]

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text(monthYearString)
                    .font(.headline)
                    .fontWeight(.bold)
                Spacer()
            }

            HStack(spacing: 0) {
                ForEach(daysOfWeek, id: \.self) { day in
                    Text(day)
                        .font(.caption2)
                        .fontWeight(.semibold)
                        .foregroundColor(day == "일" ? .red : day == "토" ? .blue : .secondary)
                        .frame(maxWidth: .infinity)
                }
            }

            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 2), count: 7), spacing: 4) {
                ForEach(getDaysInMonth(), id: \.self) { date in
                    if let date = date {
                        Text("\(calendar.component(.day, from: date))")
                            .font(.caption)
                            .fontWeight(calendar.isDateInToday(date) ? .bold : .regular)
                            .foregroundColor(calendar.isDateInToday(date) ? .white : textColor(for: date))
                            .frame(width: 24, height: 24)
                            .background(
                                Circle()
                                    .fill(calendar.isDateInToday(date) ? Color.blue : Color.clear)
                            )
                    } else {
                        Color.clear
                            .frame(width: 24, height: 24)
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }

    private var monthYearString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter.string(from: date)
    }

    private func getDaysInMonth() -> [Date?] {
        guard let monthInterval = calendar.dateInterval(of: .month, for: date),
              let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start) else {
            return []
        }

        var days: [Date?] = []
        let monthStart = monthInterval.start
        let monthEnd = monthInterval.end

        var currentDate = monthFirstWeek.start

        while currentDate < monthEnd {
            if currentDate >= monthStart {
                days.append(currentDate)
            } else {
                days.append(nil)
            }

            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate) ?? currentDate
        }

        while days.count % 7 != 0 {
            days.append(nil)
        }

        return days
    }

    private func textColor(for date: Date) -> Color {
        let weekday = calendar.component(.weekday, from: date)
        if weekday == 1 { // 일요일
            return .red
        } else if weekday == 7 { // 토요일
            return .blue
        }
        return .primary
    }
}

@main
struct CalendarWidget: Widget {
    let kind: String = "CalendarWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: CalendarProvider()) { entry in
            CalendarWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("달력 위젯")
        .description("바탕 화면에 달력을 표시합니다.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

struct CalendarWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CalendarWidgetEntryView(entry: CalendarEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemSmall))

            CalendarWidgetEntryView(entry: CalendarEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemMedium))

            CalendarWidgetEntryView(entry: CalendarEntry(date: Date()))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
