//
//  TabBar.swift
//  MoodJournal
//
//  Created by João Vitor Dall Agnol Fernandes on 04/05/21.
//

import SwiftUI



struct TabBar: View {
    
    enum Tabs {
        case feed
        case newMood
        case overview
    }
    
    let iconNames = ["note.text","plus.circle.fill","chart.bar"]
    @State var activeTab: Tabs = .feed
    @State var selectedTab = 0
    @State var showModalView = false
    

    @State var feedIsSelected = false
    @State var moodIsSelected = false
    @State var calendarIsSelected = false
    @State var data = Date()
    @EnvironmentObject var moodController: MoodModelController
        
    var body: some View {

        VStack {
            
            Group { () -> AnyView in
                tabBarViews()
            }
            
            Spacer()
            
            HStack {
              
                ForEach(0..<3) { num in
                    
                    Button(action: {
                        selectedTab = num
                        switch num {
                        case 0: activeTab = .feed
                        case 1: self.showModalView.toggle()
                        case 2: activeTab = .overview
                        default: break

                        }
                    }, label: {
                        Spacer()
                        if num == 1 {
                            Image(systemName: iconNames[num])
                                .font(.system(size: 36, weight: .bold))
                                .foregroundColor(Color(UIColor(named: "NewMoodButtonColor")!))
                        }
                        else {
                            Image(systemName: iconNames[num])
                                .foregroundColor(selectedTab == num ? Color.init(#colorLiteral(red: 0.2745098039, green: 0.7882352941, blue: 0.4901960784, alpha: 1)) : Color.init(#colorLiteral(red: 0.8196078431, green: 0.8196078431, blue: 0.8196078431, alpha: 1)))
                        }

                        Spacer()
                        
                    })
                    
                }
            }
        }
        .overlay(VStack{Divider().background(Color(#colorLiteral(red: 0.4898338914, green: 0.4869260788, blue: 0.4920717478, alpha: 1))).offset(x: 0, y: 331)})
      //  .background(Color(UIColor(named: "BGGray")!)).ignoresSafeArea()
        .sheet(isPresented: $showModalView, content: { NewMoodView() })
        
    }
    
    func tabBarViews() -> AnyView {
        switch activeTab {

        case .feed: return AnyView ( HomeView() )
            
        case .newMood: return AnyView ( NewMoodView() )
            
        case .overview: return AnyView ( OverviewView(clickedDate: $data)
                                             )
            
        default: return AnyView ( Text("teste") )
            

        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
//        TabBar(moodModelController: MoodModelController())
        TabBar()

    }
}
