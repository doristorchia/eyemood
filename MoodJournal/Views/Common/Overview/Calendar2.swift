import SwiftUI

fileprivate extension DateFormatter {
    static var month: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        return formatter
    }

    static var monthAndYear: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
}

struct Calendar2<DateView>: View where DateView: View {
    @Environment(\.calendar) var calendar
    
    @Binding var clickedDate: Date
    
    let interval: DateInterval //!!!!!
    let showHeaders: Bool
    let content: (Date) -> DateView

    init(
        interval: DateInterval,
        clickedDate: Binding<Date>,
        showHeaders: Bool = true,
        @ViewBuilder content: @escaping (Date) -> DateView
    ) {
        self.interval = interval
        self._clickedDate = clickedDate
        self.showHeaders = showHeaders
        self.content = content
    }

    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(), count: 7)) {
            ForEach(months, id: \.self) { month in
               // Section(header: header(for: month)) {
                    ForEach(days(for: month), id: \.self) { date in
                        if calendar.isDate(date, equalTo: month, toGranularity: .month) {
                            content(date).id(date).onTapGesture {
                                if ( !date.dayIsFuture() ) {
                                    self.clickedDate = date
                                }
                            }
                            .background(clickedDate == date ? Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)) : Color.init(#colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)) )
                            .foregroundColor(clickedDate == date ? Color.init(#colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)) : Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)) )
                            .cornerRadius(7.0)
                        } else {
                            content(date).hidden()
                        }
                    }
               // }
            }
        }
    }

    private var months: [Date] {
        calendar.generateDates(
            inside: interval,
            matching: DateComponents(day: 1, hour: 0, minute: 0, second: 0)
        )
    }

//    private func header(for month: Date) -> some View {
//        let component = calendar.component(.month, from: month)
//        let formatter = component == 1 ? DateFormatter.monthAndYear : .month
//
//        return Group {
//            if showHeaders {
////                Text(formatter.string(from: month))
////                    .font(.title)
////                    .padding()
//            }
//        }
//    }

    private func days(for month: Date) -> [Date] {
        guard
            let monthInterval = calendar.dateInterval(of: .month, for: month),
            let monthFirstWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.start),
            let monthLastWeek = calendar.dateInterval(of: .weekOfMonth, for: monthInterval.end)
        else { return [] }
        return calendar.generateDates(
            inside: DateInterval(start: monthFirstWeek.start, end: monthLastWeek.end),
            matching: DateComponents(hour: 0, minute: 0, second: 0)
        )
    }
}

//struct CalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        Calendar2(interval: .init()) { _ in
//            Text("30")
//                .padding(8)
//                //.background(Color.blue)
//                .cornerRadius(8)
//        }
//    }
//}
