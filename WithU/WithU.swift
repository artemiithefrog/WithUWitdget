import WidgetKit
import SwiftUI

struct SimpleEntry: TimelineEntry {
  let date: Date
  let leftCat: String
  let rightCat: String
}

struct SmallWithUWidgetView: View {

  let leftCat: String
  let rightCat: String

  var body: some View {
    VStack {
      HStack {
        Image(leftCat)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 40, height: 40)
        Image("heart")
          .resizable()
          .frame(width: 40, height: 40)
        Image(rightCat)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 40, height: 40)
      }
      Text("Small Widget")
        .bold()
        .font(.system(size: 13))
        .foregroundColor(.red)
    }.padding()
  }
}

struct MediumWithUWidgetView: View {

  let leftCat: String
  let rightCat: String

  var body: some View {
    VStack {
      HStack {
        Image(leftCat)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 50, height: 50)
        Image("heart")
          .resizable()
          .frame(width: 50, height: 50)
        Image(rightCat)
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 50, height: 50)
      }
      Text("Medium Widget")
        .bold()
        .font(.system(size: 13))
        .foregroundColor(.red)
    }
  }
}

struct Provider: TimelineProvider {
  @AppStorage("leftCat", store: UserDefaults(suiteName: "group.artemiithefrog.WithUWitdget"))
  var leftCat: String = String()
  @AppStorage("rightCat", store: UserDefaults(suiteName: "group.artemiithefrog.WithUWitdget"))
  var rightCat: String = String()

  func placeholder(in context: Context) -> SimpleEntry {
    SimpleEntry(date: Date(), leftCat: leftCat, rightCat: rightCat)
  }

  func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
    let entry = SimpleEntry(date: Date(), leftCat: leftCat, rightCat: rightCat)
    completion(entry)
  }

  func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    var entries: [SimpleEntry] = []

    let currentDate = Date()
    for hourOffset in 0 ..< 5 {
        let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
        let entry = SimpleEntry(date: entryDate, leftCat: leftCat, rightCat: rightCat)
        entries.append(entry)
    }

    let timeline = Timeline(entries: entries, policy: .atEnd)
    completion(timeline)
  }
}

struct SmallWidgetEntryView: View {
  var entry: Provider.Entry

  var body: some View {
    SmallWithUWidgetView(leftCat: entry.leftCat, rightCat: entry.rightCat)
      .widgetBackground(Color.black)
  }
}

struct MediumWidgetEntryView: View {
  var entry: Provider.Entry

  var body: some View {
    MediumWithUWidgetView(leftCat: entry.leftCat, rightCat: entry.rightCat)
      .widgetBackground(Color.black)
  }
}

@main
struct MyWidgetBundle: WidgetBundle {

    @WidgetBundleBuilder
    var body: some Widget {
        SmallWidget()
        MediumWidget()
    }
}

struct SmallWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "HelloWorldSmallWidget", provider: Provider()) { entry in
            SmallWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Hello, World (Small)")
        .description("This is a small widget displaying 'Hello, World!'")
        .supportedFamilies([.systemSmall])
    }
}

struct MediumWidget: Widget {
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: "HelloWorldMediumWidget", provider: Provider()) { entry in
            MediumWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Hello, World (Medium)")
        .description("This is a medium widget displaying 'Hello, World!'")
        .supportedFamilies([.systemMedium])
    }
}
//@main
//struct SmallWidget: Widget {
//  var body: some WidgetConfiguration {
//    StaticConfiguration(kind: "HelloWorldSmallWidget", provider: Provider()) { entry in
//      SmallWidgetEntryView(entry: entry)
//    }
//    .configurationDisplayName("Hello, World (Small)")
//    .description("This is a small widget displaying 'Hello, World!'")
//    .supportedFamilies([.systemSmall])
//  }
//}

extension View {
    func widgetBackground(_ backgroundView: some View) -> some View {
        if #available(iOSApplicationExtension 17.0, *) {
            return containerBackground(for: .widget) {
                backgroundView
            }
        } else {
            return background(backgroundView)
        }
    }
}
