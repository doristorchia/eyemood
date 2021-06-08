import Foundation

extension Date {

    func dateToString(format: String) -> String {
        let dateFormat = DateFormatter.init()
        dateFormat.dateFormat = format
        let dateString = dateFormat.string(from: self)
        return dateString
    }
}

extension String {

    func stringToDate(format: String) -> Date {
        let dateFormat = DateFormatter.init()
        dateFormat.dateFormat = format
        let date = dateFormat.date(from: self)!
        return date
    }

}

extension Calendar {
    func generateDates(
        inside interval: DateInterval,
        matching components: DateComponents
    ) -> [Date] {
        var dates: [Date] = []
        dates.append(interval.start)
        
        enumerateDates(
            startingAfter: interval.start,
            matching: components,
            matchingPolicy: .nextTime
        ) { date, _, stop in
            if let date = date {
                if date < interval.end {
                    dates.append(date)
                } else {
                    stop = true
                }
            }
        }
        
        return dates
    }
    
    func intervalOfWeek(for date: Date) -> DateInterval? {
        dateInterval(of: .weekOfYear, for: date)
    }
}

extension Date {
    
    func fullDistance(from date: Date, resultIn component: Calendar.Component, calendar: Calendar = .current) -> Int? {
        calendar.dateComponents([component], from: self, to: date).value(for: component)
    }

    func distance(from date: Date, only component: Calendar.Component, calendar: Calendar = .current) -> Int {
        let days1 = calendar.component(component, from: self)
        let days2 = calendar.component(component, from: date)
        return days1 - days2
    }

    func hasSame(_ component: Calendar.Component, as date: Date) -> Bool {
        distance(from: date, only: component) == 0
    }
    
    func dayIsFuture() -> Bool { // testa se self.date é maior do que Date()
        if ( self > Date() ) {
            return true
        }
        return false
    }
    
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
    
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    
    var monthBefore: Date {
        return Calendar.current.date(byAdding: .month, value: -1, to: self)!
    }
    
    var monthAfter: Date {
        return Calendar.current.date(byAdding: .month, value: 1, to: self)!
    }
    
    var yearBefore: Date {
        return Calendar.current.date(byAdding: .year, value: -1, to: self)!
    }
    
    var day: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: self)
    }
    
    var intDay: Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        return Int(dateFormatter.string(from: self))
    }
    
    var year: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "Y"
        return dateFormatter.string(from: self)
    }
    
    var month: String {
        let dateFormetter = DateFormatter()
        dateFormatter.dateFormat = "m"
        return dateFormatter.string(from: self)
    }
}

enum Page {
    
    case page1
    
    case page2
    
    case pageContent
}
