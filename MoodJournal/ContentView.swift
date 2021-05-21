//
//  ContentView.swift
//  MoodJournal
//
//  Created by João Vitor Dall Agnol Fernandes on 03/05/21.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @AppStorage("MotherView") var showingOnboardingView = true
    @State var isActive: Bool = false
    
    var body: some View {
        VStack {
            if showingOnboardingView {
                if self.isActive  {
                    MotherView(viewRouter: _viewRouter, showingOnboardingView: $showingOnboardingView)
                } else {
                    SplashView(isActive: true, showingOnboardingView: $showingOnboardingView, viewRouter: _viewRouter)
                }
                
            } else {
                
                TabBar()
                    .environmentObject(MoodModelController())
                
                
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                withAnimation {
                    self.isActive = true
                }
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(MoodModelController())
            .environmentObject(ViewRouter())
    }
}
