import SwiftUI

struct ContentView: View {
    @State private var countdowns: [EventCountdown] = []

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                if countdowns.isEmpty {
                    Text("No upcoming events")
                        .font(.title2)
                        .foregroundColor(.secondary)
                        .padding(.vertical, 60)
                } else {
                    ForEach(countdowns) { item in
                        CountdownView(countdown: item.result, title: item.title, date: item.dateLabel)
                        if item.id != countdowns.last?.id {
                            Divider()
                        }
                    }
                }
            }
            .padding(.vertical, 40)
        }
        .onAppear { refreshCountdowns() }
        .onReceive(timer) { _ in refreshCountdowns() }
    }

    private func refreshCountdowns() {
        countdowns = CountdownCalculator.shared.upcomingEvents.map { event in
            EventCountdown(
                title: event.title,
                dateLabel: event.dateLabel,
                result: CountdownCalculator.shared.getCountdown(to: event.date)
            )
        }
    }
}

struct EventCountdown: Identifiable {
    let id = UUID()
    let title: String
    let dateLabel: String
    let result: CountdownResult
}

struct CountdownView: View {
    let countdown: CountdownResult
    let title: String
    let date: String

    var body: some View {
        VStack(spacing: 20) {
            if countdown.isGameDay {
                Text("Today!")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundColor(.green)
            } else {
                HStack(alignment: .bottom, spacing: 15) {
                    TimeUnitView(value: countdown.days, unit: "days")
                    TimeUnitView(value: countdown.hours, unit: "hours")
                    TimeUnitView(value: countdown.minutes, unit: "mins")
                    TimeUnitView(value: countdown.seconds, unit: "secs")
                }
                .foregroundColor(.blue)

                Text(title)
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }

            Text(date)
                .font(.headline)
                .foregroundColor(.secondary)
        }
    }
}

struct TimeUnitView: View {
    let value: Int
    let unit: String

    var body: some View {
        VStack {
            Text("\(value)")
                .font(.system(size: 36, weight: .bold))
                .monospacedDigit()
            Text(unit)
                .font(.caption)
        }
    }
}

#Preview {
    ContentView()
}
