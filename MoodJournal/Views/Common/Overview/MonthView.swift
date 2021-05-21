import SwiftUI
import UIKit

struct MonthView: View {
    @Binding var selectedDate: Date
    @Binding var selectedMonth: Int
    var month: Month
    
    var body: some View {
        VStack {
            let chevronRight = Image(systemName: "chevron.right")
            let chevronLeft = Image(systemName: "chevron.left")
            
            HStack{
                Button(action: {
                    if selectedMonth >= 0 {
                        selectedMonth -= 1
                    }
                }, label: {
                    Text("\(chevronLeft)").foregroundColor(Color.init(#colorLiteral(red: 0.3607843137, green: 0.8274509804, blue: 0.5490196078, alpha: 1)))
                })
                
                Text("\(month.monthNameYear)")
                Button(action: {
                    if selectedMonth < 3 {
                        selectedMonth += 1
                    }
                }, label: {
                    Text("\(chevronRight)").foregroundColor(Color.init(#colorLiteral(red: 0.3607843137, green: 0.8274509804, blue: 0.5490196078, alpha: 1)))
                })
            }
            
            Divider()
            WeekView()
            GridStack(rows: month.monthRows, columns: month.monthDays.count) { row, col in
                
                if self.month.monthDays[col+1]?.count ?? 0 <= row {
                    EmptyView()
                    
                } else if self.month.monthDays[col+1]![row].dayDate == Date(timeIntervalSince1970: 0) {
                    Text("").frame(width: 32, height: 32)
                    
                } else {
                    DayCellView( day: self.month.monthDays[col+1]![row], selectedDate: $selectedDate )
                        .onTapGesture {
                            self.selectedDate = self.month.monthDays[col+1]![row].dayDate
                        }
                }
            }
        }
        .padding(.bottom, 20)
    }
}
