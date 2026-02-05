import WidgetKit
import SwiftUI

struct MarinersTimelineProvider: TimelineProvider {
    func placeholder(in context: Context) -> MarinersWidgetEntry {
        MarinersWidgetEntry(date: Date(), countdown: CountdownCalculator.shared.getDaysUntilGame())
    }

    func getSnapshot(in context: Context, completion: @escaping (MarinersWidgetEntry) -> ()) {
        let entry = MarinersWidgetEntry(date: Date(), countdown: CountdownCalculator.shared.getDaysUntilGame())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<MarinersWidgetEntry>) -> ()) {
        var entries: [MarinersWidgetEntry] = []
        
        let currentDate = Date()
        let countdown = CountdownCalculator.shared.getDaysUntilGame()
        
        // Create entry for current time
        let entry = MarinersWidgetEntry(date: currentDate, countdown: countdown)
        entries.append(entry)
        
        // Schedule next update in 1 hour
        let calendar = Calendar.current
        if let nextUpdate = calendar.date(byAdding: .hour, value: 1, to: currentDate) {
            let timeline = Timeline(entries: entries, policy: .after(nextUpdate))
            completion(timeline)
        } else {
            // Fallback: update after 1 hour
            let timeline = Timeline(entries: entries, policy: .after(Date(timeIntervalSinceNow: 3600)))
            completion(timeline)
        }
    }
}

struct MarinersWidgetEntry: TimelineEntry {
    let date: Date
    let countdown: CountdownResult
}
