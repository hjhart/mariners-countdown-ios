import WidgetKit
import SwiftUI

struct MarinersWidget: Widget {
    let kind: String = "MarinersWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: MarinersTimelineProvider()) { entry in
            MarinersWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("Mariners Countdown")
        .description("Days until Mariners Spring Training")
        .supportedFamilies([.systemSmall])
    }
}
