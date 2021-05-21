import SwiftUI

struct DayCellView: View {
    @ObservedObject var day: Day
    @Binding var selectedDate: Date
    @ObservedObject var colors: Colors = Colors()
    
    var body: some View {
        VStack {
            
            if self.day.disabled == true {
                Text(day.dayName).frame(width: 32, height: 32).foregroundColor(Color.gray).clipped()
            } else {
                Text(day.dayName).frame(width: 32, height: 32).clipped()
            }
        }
        .background( self.day.disabled == false && isSameDate(date1: day.dayDate, date2: selectedDate) ?  colors.selectedBackgroundColor :  colors.backgroundColor ).clipShape(Rectangle()).cornerRadius(10)
        .foregroundColor( self.day.disabled == false &&  isSameDate(date1: day.dayDate, date2: selectedDate) ? colors.selectedColor :  colors.textColor )
    }
    
    func isSameDate(date1: Date, date2: Date) -> Bool {
        let difDate1 = Calendar.current.dateComponents([.day, .month], from: date1)
        let difDate2 = Calendar.current.dateComponents([.day, .month], from: date2)
        return difDate1 == difDate2
    }
}
