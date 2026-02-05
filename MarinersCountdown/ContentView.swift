import SwiftUI

struct ContentView: View {
    @State private var springTrainingCountdown = CountdownCalculator.shared.getCountdown(to: CountdownCalculator.shared.getGameDate())
    @State private var openingDayCountdown = CountdownCalculator.shared.getCountdown(to: CountdownCalculator.shared.getOpeningDayDate())
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                VStack(spacing: 15) {
                    Text("Spring Training Start")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                    
                    CountdownView(countdown: springTrainingCountdown, title: "Mariners Spring Training", date: "February 20, 2026")
                }
                
                Divider()
                
                VStack(spacing: 15) {
                    Text("Regular Season Opener")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
                    
                    CountdownView(countdown: openingDayCountdown, title: "Mariners vs Guardians", date: "March 26, 2026")
                }
            }
            .padding(.vertical, 40)
        }
        .onReceive(timer) { _ in
            refreshCountdowns()
        }
    }
    
    private func refreshCountdowns() {
        springTrainingCountdown = CountdownCalculator.shared.getCountdown(to: CountdownCalculator.shared.getGameDate())
        openingDayCountdown = CountdownCalculator.shared.getCountdown(to: CountdownCalculator.shared.getOpeningDayDate())
    }
}

struct CountdownView: View {
    let countdown: CountdownResult
    let title: String
    let date: String
    
    var body: some View {
        VStack(spacing: 20) {
            if countdown.isGameDay {
                Text("Game Day!")
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
