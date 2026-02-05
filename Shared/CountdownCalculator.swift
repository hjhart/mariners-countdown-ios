import Foundation

/// Result of countdown calculation
struct CountdownResult {
    let days: Int
    let hours: Int
    let minutes: Int
    let seconds: Int
    let isGameDay: Bool
}

/// Shared countdown calculator for Mariners Spring Training game
class CountdownCalculator {
    static let shared = CountdownCalculator()
    
    private init() {}
    
    /// Mariners first spring training game: February 20, 2026 at 12:10 PM Pacific Time
    func getGameDate() -> Date {
        var components = DateComponents()
        components.year = 2026
        components.month = 2
        components.day = 20
        components.hour = 12
        components.minute = 10
        components.timeZone = TimeZone(identifier: "America/Los_Angeles")
        
        let calendar = Calendar.current
        return calendar.date(from: components)!
    }
    
    /// Mariners first regular season game: March 26, 2026 at 7:10 PM Pacific Time
    func getOpeningDayDate() -> Date {
        var components = DateComponents()
        components.year = 2026
        components.month = 3
        components.day = 26
        components.hour = 19
        components.minute = 10
        components.timeZone = TimeZone(identifier: "America/Los_Angeles")
        
        let calendar = Calendar.current
        return calendar.date(from: components)!
    }
    
    /// Calculate days, hours, minutes, and seconds until a specific date
    func getCountdown(to targetDate: Date) -> CountdownResult {
        let now = Date()
        let calendar = Calendar.current
        
        // Get start of day for both dates to check if it's game day
        let startOfToday = calendar.startOfDay(for: now)
        let startOfTargetDay = calendar.startOfDay(for: targetDate)
        
        // If it's already game day (calendar day wise)
        if now >= targetDate || calendar.isDate(startOfToday, inSameDayAs: startOfTargetDay) {
            return CountdownResult(days: 0, hours: 0, minutes: 0, seconds: 0, isGameDay: true)
        }
        
        // Calculate days, hours, minutes, seconds between
        let components = calendar.dateComponents([.day, .hour, .minute, .second], from: now, to: targetDate)
        let days = components.day ?? 0
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0
        let seconds = components.second ?? 0
        
        // If game date has passed, show all 0
        if now > targetDate {
            return CountdownResult(days: 0, hours: 0, minutes: 0, seconds: 0, isGameDay: false)
        }
        
        return CountdownResult(days: days, hours: hours, minutes: minutes, seconds: seconds, isGameDay: false)
    }
    
    /// Legacy method for the app's primary countdown
    func getFullCountdown() -> CountdownResult {
        return getCountdown(to: getGameDate())
    }
    
    /// Calculate only days until the game from now (for the widget)
    func getDaysUntilGame() -> CountdownResult {
        let now = Date()
        let gameDate = getGameDate()
        
        let calendar = Calendar.current
        
        // Get start of day for both dates to compare days (not hours)
        let startOfToday = calendar.startOfDay(for: now)
        let startOfGameDay = calendar.startOfDay(for: gameDate)
        
        // Check if it's game day
        if calendar.isDate(startOfToday, inSameDayAs: startOfGameDay) {
            return CountdownResult(days: 0, hours: 0, minutes: 0, seconds: 0, isGameDay: true)
        }
        
        // Calculate days between
        let components = calendar.dateComponents([.day], from: startOfToday, to: startOfGameDay)
        let days = components.day ?? 0
        
        // If game date has passed, show 0 days (but not game day)
        if days < 0 {
            return CountdownResult(days: 0, hours: 0, minutes: 0, seconds: 0, isGameDay: false)
        }
        
        return CountdownResult(days: days, hours: 0, minutes: 0, seconds: 0, isGameDay: false)
    }
}
