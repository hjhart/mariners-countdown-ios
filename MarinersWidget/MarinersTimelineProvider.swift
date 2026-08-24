import WidgetKit
import SwiftUI

struct MarinersTimelineProvider: TimelineProvider {
    func placeholder(in context: Context) -> MarinersWidgetEntry {
        MarinersWidgetEntry(
            date: Date(),
            countdown: CountdownCalculator.shared.getDaysUntilNextEvent(),
            eventTitle: CountdownCalculator.shared.nextUpcomingEvent?.title ?? "Upcoming Event"
        )
    }

    func getSnapshot(in context: Context, completion: @escaping (MarinersWidgetEntry) -> ()) {
        completion(MarinersWidgetEntry(
            date: Date(),
            countdown: CountdownCalculator.shared.getDaysUntilNextEvent(),
            eventTitle: CountdownCalculator.shared.nextUpcomingEvent?.title ?? "Upcoming Event"
        ))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<MarinersWidgetEntry>) -> ()) {
        let entry = MarinersWidgetEntry(
            date: Date(),
            countdown: CountdownCalculator.shared.getDaysUntilNextEvent(),
            eventTitle: CountdownCalculator.shared.nextUpcomingEvent?.title ?? "Upcoming Event"
        )

        let nextUpdate = Calendar.current.date(byAdding: .hour, value: 1, to: Date())
            ?? Date(timeIntervalSinceNow: 3600)
        let timeline = Timeline(entries: [entry], policy: .after(nextUpdate))
        completion(timeline)
    }
}

struct MarinersWidgetEntry: TimelineEntry {
    let date: Date
    let countdown: CountdownResult
    let eventTitle: String
}
