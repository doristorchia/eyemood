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
            
            ZStack(alignment: .bottomTrailing)
            {
                
                VStack(spacing: 0){
                    
                    
                    if moodModelController.moods == []{
                        Spacer()
                        Text("You have not added any moods yet")
                            
                            .fontWeight(.light)
                            .foregroundColor(Color.gray)
                            .multilineTextAlignment(.center)
                           
                        Image("web")
                            .resizable(capInsets: EdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0), resizingMode: .stretch)
                            .aspectRatio(contentMode: .fill)
                            .padding()
                            .opacity(0.8)
                            .blendMode(/*@START_MENU_TOKEN@*/.multiply/*@END_MENU_TOKEN@*/)
                            .contentShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .background(Color.init(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    }
                    
                    List {
                        
                        ForEach(self.moodModelController.getMonths(), id: \.self) { month in
                            Section(header: Text(month)
                                        .font(.title2)
                                        .bold()
                                        .padding(.leading, 20)
                                        .foregroundColor(.black)) {
                                
                                ForEach(self.moodModelController.getDays(monthString: month), id: \.id) { mood in
                                    
                                    MoodsRowView(mood: mood)
                                    
                                }
                                .onDelete { (index) in
                                    
                                    self.moodModelController.deleteMood(at: index)
                                }
                                
                            }
                            
                        }
                        .listRowBackground(Color(#colorLiteral(red: 0.9490196078, green: 0.9490196078, blue: 0.9647058824, alpha: 1)))
                        
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

