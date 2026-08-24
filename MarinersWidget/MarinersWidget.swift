import WidgetKit
import SwiftUI

struct MarinersWidget: Widget {
    let kind: String = "MarinersWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: MarinersTimelineProvider()) { entry in
            MarinersWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Countdown")
        .description("Days until your next upcoming event")
        .supportedFamilies([.systemSmall])
    }
}
