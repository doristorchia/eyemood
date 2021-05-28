//
//  SwiftUIView.swift
//  MoodJournal
//
//  Created by João Vitor Dall Agnol Fernandes on 18/05/21.
//

import SwiftUI

struct DailyGraphView: View {
    
    @EnvironmentObject var moodModelController: MoodModelController
    @Binding var selectedDate: Date

    var month: String //nome do mes ou dia
    var monthlyReports: [MonthlyReport] //0=happy 1=angry 2=calm 3=sad
    
    var body: some View {
        HStack {
            
            ForEach(monthlyReports, id: \.id) { report in
                //HStack {
                    Spacer()
                    VStack {
                        DailyColumnView(report: report)
                    }
                    
                    Spacer()
                //}
                    
            }
        }
        //.animation(.easeIn)
        .padding()
    }
}
