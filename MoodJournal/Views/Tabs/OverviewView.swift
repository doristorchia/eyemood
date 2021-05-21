//
//  AccountView.swift
//  MoodJournal
//
//  Created by João Vitor Dall Agnol Fernandes on 04/05/21.
//

import SwiftUI

struct OverviewView: View {
    @State var date = Date()
    @EnvironmentObject var moodModelController: MoodModelController
    @State var selectedDate: Date = Date()
    @State var selectedOption = 0
    
    let prevMonths = Calendar.current.date(byAdding: .month, value: -4, to: Date()) ?? Date()
    
    var body: some View {
        
        VStack {
            
            CalendarView(currentDate: $selectedDate, startDate: prevMonths, monthsToDisplay: 5)
       
            VStack {
                Picker("Monthly or Daily", selection: $selectedOption)  {
                    Text("Mes").tag(0)
                    Text("Dia").tag(1)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.trailing)
                .padding(.leading)
                
            }
            
            if selectedOption == 0 { //se segmented for mes
                VStack(alignment: .leading) {
                    Text("  \(selectedDate.dateToString(format: "MMM y"))  ")
                        .fontWeight(.semibold)
                        .padding(.leading, 13)
                        .padding(.top, 15)
                    
                    Divider()
                    
                    MonthlyGraphView(selectedDate: $selectedDate, month: selectedDate.dateToString(format: "d MMM y"), monthlyReports: moodModelController.getReports(date: selectedDate))
                }
            }
            else {
                VStack(alignment: .leading) {
                    Text("  \(selectedDate.dateToString(format: "d MMM"))  ")
                        .fontWeight(.semibold)
                        .padding(.leading, 13)
                        .padding(.top, 15)
                    
                    Divider()
                    
                    DailyGraphView(selectedDate: $selectedDate, month: selectedDate.dateToString(format: "d MMM y"), monthlyReports: moodModelController.getDailyReports(date: selectedDate))
                    
                }
            }
        }
    }
    
    struct OverviewView_Previews: PreviewProvider {
        static var previews: some View {
            OverviewView().environmentObject(MoodModelController())
        }
    }
}
