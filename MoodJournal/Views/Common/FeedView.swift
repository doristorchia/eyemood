//
//  FeedView.swift
//  MoodJournal
//
//  Created by Rodrigo de Anhaia on 18/05/21.
//

import SwiftUI

struct FeedView: View {
    
    @EnvironmentObject var moodModelController: MoodModelController
    @State var show = false
    @State var txt = ""
    @State var docID = ""
    @State var remove = false
    
    var body: some View {
        
        NavigationView {
            
            ZStack(alignment: .bottomTrailing) {
                
                VStack(spacing: 0){
                    
                    
                    if moodModelController.moods == []{
                        ZStack {
                            
                            VStack {
                                //Spacer()
                                Text("Add new moods to see your feed!")
                                    .fontWeight(.light)
                                    .foregroundColor(Color.init(#colorLiteral(red: 0.1607664227, green: 0.1607957482, blue: 0.1607601345, alpha: 1)))
                                    .multilineTextAlignment(.center)
                                
                                Image("web")
                                    .resizable(capInsets: EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0), resizingMode: .stretch)
                                    .foregroundColor(Color(UIColor(named: "BGDarkGray")!))
                                    .aspectRatio(contentMode: .fill)
                                    .padding()
                                    .opacity(0.8)
                                    .blendMode(/*@START_MENU_TOKEN@*/.multiply/*@END_MENU_TOKEN@*/)
                                    .contentShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            }
                            
                        }
                        .background(Color(UIColor(named: "NewMoodButtonColor")!).ignoresSafeArea())
                    }
                    else {
                        
                        List {
                            
                            ForEach(self.moodModelController.getMonths(), id: \.self) { month in
                                Section(header: Text(month)
                                            .font(.title2)
                                            .bold()
                                            .padding(.leading, 20)
                                            .foregroundColor(Color(UIColor(named: "NewMoodButtonColor")!))) {
                                    
                                    ForEach(self.moodModelController.getDays(monthString: month), id: \.id) { mood in
                                        
                                        MoodsRowView(mood: mood)
                                        
                                    }
                                    .onDelete { (index) in
                                        
                                        self.moodModelController.deleteMood(at: index)
                                    }
                                    
                                }
                                
                            }
                           .listRowBackground(Color(UIColor(named: "BGDarkGray")!))
                            
                        }
                        .listStyle(InsetGroupedListStyle())
                        
                        .onAppear {
                            //Removes extra cells that are not being used.
                            UITableView.appearance().tableFooterView = UIView()
                            //MARK: Disable selection.
                            
                            UITableView.appearance().allowsSelection = true
                            UITableViewCell.appearance().selectionStyle = .none
                            UITableView.appearance().showsVerticalScrollIndicator = false
                        }
                    }
                }
            }
            .animation(.default)
        }
        
    }
}

class Host : UIHostingController<ContentView>{
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        
        return .lightContent
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView().environmentObject(MoodModelController())
    }
}

