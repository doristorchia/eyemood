//
//  AccountView.swift
//  MoodJournal
//
//  Created by João Vitor Dall Agnol Fernandes on 04/05/21.
//

import SwiftUI

struct OverviewView: View {
    @State var monthToShow = Date()
    @EnvironmentObject var moodModelController: MoodModelController
    @State var selectedDate: Date = Date()
    @State var selectedOption = 0
    
    @Binding var clickedDate: Date //this one is being used
    
    let screenSize: CGSize = UIScreen.main.bounds.size //objeto c height e width da tela
    //let prevMonths = Calendar.current.date(byAdding: .month, value: -4, to: Date()) ?? Date()
    
    var body: some View {
        VStack{
            let chevronRight = Image(systemName: "chevron.right").foregroundColor(Color.init(#colorLiteral(red: 0.3607843137, green: 0.8274509804, blue: 0.5490196078, alpha: 1)))
            let chevronLeft = Image(systemName: "chevron.left").foregroundColor(Color.init(#colorLiteral(red: 0.3607843137, green: 0.8274509804, blue: 0.5490196078, alpha: 1)))
            
            let monthString = monthToShow.dateToString(format: "MMM")
            VStack{
                HStack{
                    chevronLeft.onTapGesture {
                        monthToShow = monthToShow.monthBefore
                        clickedDate = clickedDate.monthBefore
                    }
                    
                    Text(monthString)
                    
                    chevronRight.onTapGesture {
                        let monthAfter2Show = monthToShow.monthAfter.dateToString(format: "MMM y")
                        let monthAfter2day = Date().monthAfter.dateToString(format: "MMM y")
                        if ( monthAfter2Show != monthAfter2day ) { //
                            monthToShow = monthToShow.monthAfter
                            clickedDate = clickedDate.monthAfter
                        }
                        
                        
                        
                        
                    }
                }
                
                VStack(alignment: .leading){
                    
                    WeekView()
                    
                    TabView {
                        
                        Calendar2(interval: DateInterval(start: monthToShow, end: monthToShow), clickedDate: $clickedDate) { dateCalendar in
                            if ( dateCalendar.dayIsFuture() ) {
                                Text(dateCalendar.day)
                                    .padding(8)
                                    .background(Color(UIColor(named: "BGDisabledColor")!))
                                    .foregroundColor(Color(UIColor(named: "FGDisabledColor")!))
                            } else {
                                Text(dateCalendar.day)
                                    .padding(8)
                            }
                        }
                    }
                    .onAppear(perform: {
                        UIScrollView.appearance().bounces = false
                    })
                    .tabViewStyle(PageTabViewStyle())
                    .gesture(
                        DragGesture()
                            .onEnded( {value in
                                if value.startLocation.x > value.location.x + 34 {
                                    print("swipe to next month")
                                    let monthAfter2Show = monthToShow.monthAfter.dateToString(format: "MMM y")
                                    let monthAfter2day = Date().monthAfter.dateToString(format: "MMM y")
                                    
                                    if ( monthAfter2Show != monthAfter2day ) { //
                                        monthToShow = monthToShow.monthAfter
                                        clickedDate = clickedDate.monthAfter
                                    }
                                    
                                } else if value.startLocation.x < value.location.x - 34  {
                                    print("swipe to prev month")
                                    monthToShow = monthToShow.monthBefore
                                    clickedDate = clickedDate.monthBefore
                                }
                            })
                    )
                }
                .animation(.linear(duration: 0.1))
                
                VStack {
                    
                    Spacer()
                    
                    VStack {
                        Picker("Monthly or Daily", selection: $selectedOption)  {
                            Text("Month").tag(0)                        .animation(.easeIn)
                            
                            Text("Day").tag(1)                        .animation(.easeIn)
                            
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.trailing)
                        .padding(.leading)
                        .padding(.top)
                        
                    }
                    
                    Spacer()
                    
                    if selectedOption == 0 { //month
                        VStack {
                            Text("  \(clickedDate.dateToString(format: "MMM y"))  ")
                                .fontWeight(.semibold)
                                .padding(.leading, 13)
                                .padding(.top, 15)
                            
                            Divider()
                            Spacer()
                            
                            MonthlyGraphView(selectedDate: $clickedDate, month: clickedDate.dateToString(format: "d MMM y"), monthlyReports: moodModelController.getReports(date: clickedDate))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            // .animation(.easeIn)
                            
                        }
                    }
                    else { //day
                        VStack{
                            Text("  \(clickedDate.dateToString(format: "d MMM"))  ")
                                .fontWeight(.semibold)
                                .padding(.leading, 13)
                                .padding(.top, 15)
                            
                            Divider()
                            Spacer()
                            
                            DailyGraphView(selectedDate: $clickedDate, month: clickedDate.dateToString(format: "d MMM y"), monthlyReports: moodModelController.getDailyReports(date: clickedDate))
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            
                            // .animation(.easeIn)
                        }//.position(x: screenSize.width/2)
                    }
                    
                }
                //.animation(.none)
            }
        }
    }
}
//    struct OverviewView_Previews: PreviewProvider {
//        static var previews: some View {
//            OverviewView().environmentObject(MoodModelController())
//        }
//    }

