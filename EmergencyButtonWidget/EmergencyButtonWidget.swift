//
//  EmergencyButtonWidget.swift
//  EmergencyButtonWidget
//
//  Created by Zidan Ramadhan on 18/06/22.
//

import WidgetKit
import SwiftUI

let alertURL = URL(string: "emergencyButtonWidget://alert")

struct Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), url: alertURL)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), url: alertURL)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, url: alertURL)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    
    //--
    let url: URL?
}

struct EmergencyButtonWidgetEntryView : View {
    var entry: Provider.Entry
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        ZStack {
            Color("White")
            Image("EmergencyButtonforWidget")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.all)
            
        }
        .widgetURL(entry.url)
    }
}

@main
struct EmergencyButtonWidget: Widget {
    let kind: String = "EmergencyButtonWidget"

    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            EmergencyButtonWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Emergency Button Widget")
        .description("This is emergency button widget for faster access")
        .supportedFamilies([.systemSmall, .systemLarge])
    }
}

struct EmergencyButtonWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EmergencyButtonWidgetEntryView(entry: SimpleEntry(date: Date(), url: alertURL))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
    
            
            EmergencyButtonWidgetEntryView(entry: SimpleEntry(date: Date(), url: alertURL))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
        
    }
}
