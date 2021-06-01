//
//  MonthlyGraphRowView.swift
//  MoodJournal
//
//  Created by João Vitor Dall Agnol Fernandes on 17/05/21.
//

import SwiftUI

struct MonthlyRowView: View {
    var report: MonthlyReport
    
    var body: some View {
        HStack {
            BarView(report: report)
            
        }
    }
}

struct BarView: View {
    
    var report: MonthlyReport
    
    var body: some View {
        
        let value = report.amount
        var percentage = 0
        if report.totalAmount != 0 {
            percentage = ( 100 * report.amount ) / report.totalAmount
        }
        
        return HStack {
            Image(report.moodAssetName)
                .resizable()
                .frame(maxWidth: 35, maxHeight: 45)
                .scaledToFit()
            
            //Spacer()
            
            ZStack(alignment: .leading){
                Rectangle()
                    .fill(Color(UIColor(named: "BGDarkGray")!))
                    .frame(width: 250, height: 45)
                    .cornerRadius(7)
                
                switch report.moodAssetName {
                
                case "angry-barGraph":
                    Rectangle()
                        .fill(Color(#colorLiteral(red: 1, green: 0.4818549156, blue: 0.4422271252, alpha: 1)))
                        .frame(width: CGFloat(Double(percentage)*2.5), height: 45)
                        .cornerRadius(7)
                    
                case "happy-barGraph":
                    Rectangle()
                        .fill(Color(#colorLiteral(red: 0.9998592734, green: 0.8132926822, blue: 0.3589561582, alpha: 1)))
                        .frame(width: CGFloat(Double(percentage)*2.5), height: 45)
                        .cornerRadius(7)
                    
                case "calm-barGraph":
                    Rectangle()
                        .fill(Color(#colorLiteral(red: 0.2705882353, green: 0.7882352941, blue: 0.4901960784, alpha: 1)))
                        .frame(width: CGFloat(Double(percentage)*2.5), height: 45)
                        .cornerRadius(7)
                    
                case "sad-barGraph":
                    Rectangle()
                        .fill(Color(#colorLiteral(red: 0.1607843137, green: 0.6352941176, blue: 0.8117647059, alpha: 1)))
                        .frame(width: CGFloat(Double(percentage)*2.5), height: 45)
                        .cornerRadius(7)
                default: Text("Problem loading graphs")
                }
                
            }
            
            Spacer()
            
            Text("\(percentage)%")
        }
    }
}
