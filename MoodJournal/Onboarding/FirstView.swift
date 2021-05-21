//
//  FirstView.swift
//  MoodJournal
//
//  Created by Rodrigo de Anhaia on 18/05/21.
//

import SwiftUI

struct FirstView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @Binding var showingOnboardingView: Bool
    
    var body: some View {
        VStack {
            Text("Here you will have a overview of how you feel during week and month")
                .bold()
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
            
            Image("moods")
                .resizable()
                .scaledToFit()
                .frame(width:270)
                .clipped()
                .padding(50)
            
            Button (action: {
                withAnimation(.easeOut(duration: 0.3)) {
                    viewRouter.currentPage = .page2
                }
                
            }, label: {
                Text("Understood")
                
            })
            
            .padding()
            .frame(width: 142.0, height: 30.0)
            .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
            .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
            .cornerRadius(/*@START_MENU_TOKEN@*/16.0/*@END_MENU_TOKEN@*/)
        }
    }
}


struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView(showingOnboardingView: Binding.constant(true))
            .environmentObject(ViewRouter())
    }
}
