//
//  MotherView.swift
//  MoodJournal
//
//  Created by Rodrigo de Anhaia on 18/05/21.
//

import SwiftUI

struct MotherView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @Binding var showingOnboardingView: Bool
    
    var body: some View {
        switch viewRouter.currentPage {
        
        case .page1:
            FirstView(viewRouter: _viewRouter, showingOnboardingView: $showingOnboardingView)
            
        case .page2:
            SecondView(viewRouter: _viewRouter, showingOnboardingView: $showingOnboardingView)
                .transition(.scale)
            
        case .pageContent:
            ContentView().environmentObject(MoodModelController())
                .transition(.scale)
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView(showingOnboardingView: Binding.constant(true))
            .environmentObject(ViewRouter())
    }
}
