//
//  HomeView.swift
//  MoodJournal
//
//  Created by João Vitor Dall Agnol Fernandes on 04/05/21.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        FeedView()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(MoodModelController())
    }
}
