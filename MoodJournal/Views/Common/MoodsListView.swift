//
//  MoodsListView.swift
//  MoodJournal
//
//  Created by João Vitor Dall Agnol Fernandes on 07/05/21.
//

import SwiftUI

struct MoodsListView: View {
    
    let day: Date
    
    var body: some View {
        
        
        
        Text("Select a day to see your moods!")
    }
}

struct MoodsListView_Previews: PreviewProvider {
    static var previews: some View {
        MoodsListView(day: Date())
    }
}
