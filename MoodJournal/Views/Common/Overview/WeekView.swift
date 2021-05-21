import SwiftUI

struct WeekView: View {
    let weekdays = ["Sun", "Mon", "Tue", "Wen", "Thu", "Fri", "Sat"]
    let colors = Colors()

    var body: some View {
        HStack {
   
            GridStack(rows: 1, columns: 7) { row, col in
                Text(self.weekdays[col])
            }
        }.padding(.bottom, 5).background(colors.weekdayBackgroundColor).foregroundColor(Color(#colorLiteral(red: 0.6615652442, green: 0.6646293402, blue: 0.6721103191, alpha: 1)))
    }
}

struct WeekView_Previews: PreviewProvider {
    static var previews: some View {
        WeekView()
    }
}
