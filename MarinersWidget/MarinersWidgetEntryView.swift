import SwiftUI
import WidgetKit

struct MarinersWidgetEntryView: View {
    var entry: MarinersWidgetEntry
    
    var body: some View {
        VStack(spacing: 4) {
            if entry.countdown.isGameDay {
                Text("🎉")
                    .font(.system(size: 30))
                
                Text("Game Day!")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.green)
                    .minimumScaleFactor(0.5)
            } else {
                Text("\(entry.countdown.days)")
                    .font(.system(size: 48, weight: .bold))
                    .foregroundColor(.blue)
                
                Text("days")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text("Mariners")
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)

                Text("Opening Day")
                    .font(.caption2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
