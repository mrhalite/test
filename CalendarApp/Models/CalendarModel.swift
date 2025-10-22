import Foundation

/// 달력 데이터 모델
struct CalendarModel {
    let calendar = Calendar.current

    /// 특정 달의 모든 날짜를 가져옵니다
    func getDaysInMonth(for date: Date) -> [Date?] {
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

            if let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) {
                currentDate = nextDate
            } else {
                break
            }
        }

        // 마지막 주를 7일로 맞춤
        while days.count % 7 != 0 {
            days.append(nil)
        }

        return days
    }

    /// 특정 주의 날짜들을 가져옵니다
    func getWeekDays(for date: Date) -> [Date] {
        guard let weekInterval = calendar.dateInterval(of: .weekOfMonth, for: date) else {
            return []
        }

        var days: [Date] = []
        var currentDate = weekInterval.start

        for _ in 0..<7 {
            days.append(currentDate)
            if let nextDate = calendar.date(byAdding: .day, value: 1, to: currentDate) {
                currentDate = nextDate
            }
        }

        return days
    }

    /// 날짜가 오늘인지 확인
    func isToday(_ date: Date) -> Bool {
        calendar.isDateInToday(date)
    }

    /// 두 날짜가 같은 날인지 확인
    func isSameDay(_ date1: Date, _ date2: Date) -> Bool {
        calendar.isDate(date1, inSameDayAs: date2)
    }

    /// 요일 번호 가져오기 (1: 일요일, 7: 토요일)
    func getWeekday(_ date: Date) -> Int {
        calendar.component(.weekday, from: date)
    }
}

/// 날짜 포맷팅 유틸리티
struct DateFormatters {
    static let monthYear: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()

    static let weekday: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()

    static let shortWeekday: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()

    static let day: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter
    }()

    static let month: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월"
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()

    static let fullDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "ko_KR")
        return formatter
    }()
}

/// 달력 이벤트 모델 (확장 가능)
struct CalendarEvent: Identifiable, Codable {
    let id: UUID
    let title: String
    let date: Date
    let color: String

    init(id: UUID = UUID(), title: String, date: Date, color: String = "blue") {
        self.id = id
        self.title = title
        self.date = date
        self.color = color
    }
}
