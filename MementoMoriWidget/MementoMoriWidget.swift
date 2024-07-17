//
//  MementoMoriWidget.swift
//  MementoMoriWidget
//
//  Created by Javier Fransiscus on 17/07/24.
//

import WidgetKit
import SwiftUI

struct MementoMoriWidget: Widget {
    let kind: String = "MementoMoriWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            MementoMoriWidgetEntryView(entry: entry).containerBackground(.background, for: .widget)
        }
        .configurationDisplayName("Memento Mori Widget")
        .description("Track the passage of time with Memento Mori.")
        .supportedFamilies([.systemMedium]) // Adjust based on your design
    }
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        var entries: [SimpleEntry] = []
        
        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate)
            entries.append(entry)
        }
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct MementoMoriWidgetEntryView: View {
    var entry: Provider.Entry

    // Assuming birthDate is fetched from user defaults or another data source
    let birthDate = DateComponents(calendar: Calendar.current, year: 2002, month: 4, day: 9).date!
    let lifeExpectancy: Double = 80 // Assume life expectancy is 80 years
    
    var body: some View {
        VStack {
            Text("Memento Mori")
                .font(.headline)
                .padding()
            
            ProgressView(value: progress, total: 1.0)
                .progressViewStyle(LinearProgressViewStyle())
                .tint(.red)
                .padding()
            
            Text(timeRemainingText)
                .font(.caption)
                .padding()
        }
        .widgetURL(URL(string: "widget://memento-mori")) // Set widget URL for deep linking
    }
    
    var progress: Double {
        let totalWeeks = lifeExpectancy * 52
        let weeksPassed = Calendar.current.dateComponents([.weekOfYear], from: birthDate, to: entry.date).weekOfYear ?? 0
        return Double(weeksPassed) / totalWeeks
    }
    
    var timeRemainingText: String {
        let currentDate = entry.date
        let calendar = Calendar.current
        let endDate = calendar.date(byAdding: .year, value: Int(lifeExpectancy), to: birthDate)!
        
        let components = calendar.dateComponents([.year, .month, .day], from: currentDate, to: endDate)
        let yearsRemaining = components.year ?? 0
        let monthsRemaining = components.month ?? 0
        let daysRemaining = components.day ?? 0
        
        return "You have \(yearsRemaining) years \(monthsRemaining) months \(daysRemaining) days left"
    }
}

struct MementoMoriWidgetEntryView_Previews: PreviewProvider {
    static var previews: some View {
        MementoMoriWidgetEntryView(entry: SimpleEntry(date: Date()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
