import SwiftUI

struct CalendarView: View {
    @Binding var currentDate: Date
    @State var selectedMonth: Int = 3
    let startDate: Date
    let monthsToDisplay: Int
    var selectableDays = true
    
    var body: some View {
        VStack {
            TabView(selection: $selectedMonth) {
                
                MonthView( selectedDate: $currentDate, selectedMonth: $selectedMonth, month: Month(startDate: startDate, selectableDays: selectableDays))
                
                if monthsToDisplay > 1 {
                    
                    ForEach(1..<self.monthsToDisplay) {
                        
                        MonthView( selectedDate: $currentDate, selectedMonth: $selectedMonth, month: Month(startDate: self.nextMonth(currentMonth: self.startDate, add: $0), selectableDays: self.selectableDays))
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
        }
        .padding(.horizontal)
    }
    
    func nextMonth(currentMonth: Date, add: Int) -> Date {
        var components = DateComponents()
        components.month = add
        let next = Calendar.current.date(byAdding: components, to: currentMonth)!
        return next
    }
    
    
}
