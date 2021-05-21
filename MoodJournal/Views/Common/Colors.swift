import Foundation
import SwiftUI

class Colors: ObservableObject {

    //Foreground
    @Published var textColor: Color = Color.primary
    @Published var todayColor: Color = Color.blue
    @Published var disabledColor: Color = Color.gray
    @Published var selectedColor: Color = Color.white

    //Background
    @Published var backgroundColor: Color = Color.init(#colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1))
    @Published var weekdayBackgroundColor: Color = Color.clear
    @Published var selectedBackgroundColor: Color = Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))

}
