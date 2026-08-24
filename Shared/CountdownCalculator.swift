import Foundation

/// Result of countdown calculation
struct CountdownResult {
    let days: Int
    let hours: Int
    let minutes: Int
    let seconds: Int
    let isGameDay: Bool
}

/// A named event with a target date
struct CountdownEvent {
    let title: String
    let date: Date
    let dateLabel: String
}

/// Shared countdown calculator
class CountdownCalculator {
    static let shared = CountdownCalculator()

    private init() {}

    private static func makeEvent(title: String, month: Int, day: Int, hour: Int = 9, minute: Int = 0, label: String) -> CountdownEvent {
        var components = DateComponents()
        components.year = 2026
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.timeZone = TimeZone(identifier: "America/Los_Angeles")
        let date = Calendar.current.date(from: components)!
        return CountdownEvent(title: title, date: date, dateLabel: label)
    }

    static let allEvents: [CountdownEvent] = [
        makeEvent(title: "Boy's Trip", month: 10, day: 22, label: "October 22, 2026"),
        makeEvent(title: "Henry's Birthday", month: 11, day: 20, label: "November 20, 2026"),
        makeEvent(title: "November 22nd", month: 11, day: 22, label: "November 22, 2026"),
        makeEvent(title: "Christmas Holiday", month: 12, day: 27, label: "December 27, 2026"),
    ]

    var upcomingEvents: [CountdownEvent] {
        let startOfToday = Calendar.current.startOfDay(for: Date())
        return Self.allEvents.filter { Calendar.current.startOfDay(for: $0.date) >= startOfToday }
    }

    var nextUpcomingEvent: CountdownEvent? {
        upcomingEvents.first
    }

    func getCountdown(to targetDate: Date) -> CountdownResult {
        let now = Date()
        let calendar = Calendar.current

        let startOfToday = calendar.startOfDay(for: now)
        let startOfTargetDay = calendar.startOfDay(for: targetDate)

        if calendar.isDate(startOfToday, inSameDayAs: startOfTargetDay) {
            return CountdownResult(days: 0, hours: 0, minutes: 0, seconds: 0, isGameDay: true)
        }

        if now > targetDate {
            return CountdownResult(days: 0, hours: 0, minutes: 0, seconds: 0, isGameDay: false)
        }

        let components = calendar.dateComponents([.day, .hour, .minute, .second], from: now, to: targetDate)
        return CountdownResult(
            days: components.day ?? 0,
            hours: components.hour ?? 0,
            minutes: components.minute ?? 0,
            seconds: components.second ?? 0,
            isGameDay: false
        )
    }

    func getDaysUntilNextEvent() -> CountdownResult {
        guard let next = nextUpcomingEvent else {
            return CountdownResult(days: 0, hours: 0, minutes: 0, seconds: 0, isGameDay: false)
        }
        let now = Date()
        let calendar = Calendar.current
        let startOfToday = calendar.startOfDay(for: now)
        let startOfEventDay = calendar.startOfDay(for: next.date)

        if calendar.isDate(startOfToday, inSameDayAs: startOfEventDay) {
            return CountdownResult(days: 0, hours: 0, minutes: 0, seconds: 0, isGameDay: true)
        }

        let components = calendar.dateComponents([.day], from: startOfToday, to: startOfEventDay)
        let days = components.day ?? 0
        return CountdownResult(days: max(0, days), hours: 0, minutes: 0, seconds: 0, isGameDay: false)
    }
}
