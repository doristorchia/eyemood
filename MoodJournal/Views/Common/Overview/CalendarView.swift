import SwiftUI

struct CalendarView: View {
    //@ObservedObject var moodModelController: MoodModelController
    @Binding var currentDate: Date
    @State var selectedMonth: Int = 3
    let startDate: Date
    let monthsToDisplay: Int
    var selectableDays = true
    
    var body: some View {
        
        VStack {
                        
            TabView(selection: $selectedMonth) {
                
                MonthView( selectedDate: $currentDate, month: Month(startDate: startDate, selectableDays: selectableDays))
                
                if monthsToDisplay > 1 {
                    
                    ForEach(1..<self.monthsToDisplay) {
                        
                        MonthView( selectedDate: $currentDate, month: Month(startDate: self.nextMonth(currentMonth: self.startDate, add: $0), selectableDays: self.selectableDays))
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

//struct CalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        CalendarView(start: Date(), monthsToShow: 2, daysSelectable: true)
//    }
//}
