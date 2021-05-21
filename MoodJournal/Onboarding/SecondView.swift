//
//  SecondView.swift
//  MoodJournal
//
//  Created by Rodrigo de Anhaia on 18/05/21.
//

import SwiftUI

struct SecondView: View {
    @EnvironmentObject var viewRouter: ViewRouter
    @Binding var showingOnboardingView: Bool
    
    var body: some View {
        VStack {
            Text("Here you will have a overview of how you feel during week and month")
                .font(.title3)
                .bold()
                .multilineTextAlignment(.center)
                .padding(20)
            
            Image("stats")
                .resizable()
                .scaledToFit()
                .frame(width:270.0)
                .clipped()
                .padding( .bottom, 50.0)
                .padding( .top, 20.0)
            
            Button (action: {
                withAnimation {
                    viewRouter.currentPage = .pageContent
                    showingOnboardingView.toggle()
                }
                
            }, label: {
                Text("Understood")
                
            })
            
            .padding()
            .frame(width: 142.0, height: 30.0)
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.black/*@END_MENU_TOKEN@*/)
            .foregroundColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
            .cornerRadius(/*@START_MENU_TOKEN@*/16.0/*@END_MENU_TOKEN@*/)
        }
        .padding(.top, 5.0)
    }
}
struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView(showingOnboardingView: Binding.constant(true))
            .environmentObject(ViewRouter())
    }
}
