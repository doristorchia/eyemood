//
//  CalendarMoods.swift
//  MoodJournal
//
//  Created by João Vitor Dall Agnol Fernandes on 11/05/21.
//
//Sera deletado
import SwiftUI

struct CalendarMoodsView: View {
    @EnvironmentObject var moodModelController: MoodModelController
    @State var show = false
    @State var txt = ""
    @State var docID = ""
    @State var remove = false
   
    @Binding var selectedDate: Date
    
    var body: some View {
       // var dateText: String = selectedDate.dateToString(format: "d MMM y")
        NavigationView {

            ZStack(alignment: .bottomTrailing) {

                VStack(spacing: 0) {
                    
                    List {

                        ForEach(moodModelController.getMoodsByMonth(date: selectedDate), id: \.id) { mood in //review
                            MoodsRowView(mood: mood)
                            
                        }
                        .onDelete { (index) in
                            self.moodModelController.deleteMood(at: index)
                        }
                    }
                }
            }
            .animation(.default)
        }
    }
    
//    class Host : UIHostingController<ContentView>{
//
//        override var preferredStatusBarStyle: UIStatusBarStyle{
//
//            return .lightContent
//        }
//    }

//    struct TabBar_Previews: PreviewProvider {
//        static var previews: some View {
//            CalendarMoodsView()
//        }
//    }
}


