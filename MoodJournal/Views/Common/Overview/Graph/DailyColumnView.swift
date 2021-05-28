//
//  DailyGraphView.swift
//  MoodJournal
//
//  Created by João Vitor Dall Agnol Fernandes on 18/05/21.
//

import SwiftUI

struct DailyColumnView: View {
   
    var report: MonthlyReport
    
    var body: some View {
        VStack {
            ColumnView(report: report)
        }
    }
}

struct ColumnView: View {
    
    var report: MonthlyReport
    
    var body: some View {
        
        var value = report.amount
        var percentage = 0
        if report.totalAmount != 0 {
            percentage = ( 100 * report.amount ) / report.totalAmount
        }
        
        return VStack {
            
            Text("\(percentage)%")
            
            ZStack(alignment: .bottom){
                Rectangle()
                    .fill(Color(#colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1)))
                    .frame(width: 35, height: 150)
                    .cornerRadius(7)
                
                switch report.moodAssetName {
                
                case "angry-barGraph":
                    Rectangle()
                        .fill(Color(#colorLiteral(red: 1, green: 0.4818549156, blue: 0.4422271252, alpha: 1)))
                        .frame(width: 35, height: CGFloat(Double(percentage)*1.5))
                        .cornerRadius(7)
                    
                case "happy-barGraph":
                    Rectangle()
                        .fill(Color(#colorLiteral(red: 0.9998592734, green: 0.8132926822, blue: 0.3589561582, alpha: 1)))
                        .frame(width: 35, height: CGFloat(Double(percentage)*1.5))
                        .cornerRadius(7)
                    
                case "calm-barGraph":
                    Rectangle()
                        .fill(Color(#colorLiteral(red: 0.2705882353, green: 0.7882352941, blue: 0.4901960784, alpha: 1)))
                        .frame(width: 35, height: CGFloat(Double(percentage)*1.5))
                        .cornerRadius(7)
                    
                case "sad-barGraph":
                    Rectangle()
                        .fill(Color(#colorLiteral(red: 0.1607843137, green: 0.6352941176, blue: 0.8117647059, alpha: 1)))
                        .frame(width: 35, height: CGFloat(Double(percentage)*1.5))
                        .cornerRadius(7)
                default: Text("Problem loading graphs")
                }
                
            }
            
            Image(report.moodAssetName)
                .resizable()
                .frame(maxWidth: 35, maxHeight: 45)
                .scaledToFit()
            
        }
    }
}





//
//
//struct DailyGraphView_Previews: PreviewProvider {
//    static var previews: some View {
//        DailyColumnView()
//    }
//}
