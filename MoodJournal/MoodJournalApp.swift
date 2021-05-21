//
//  MoodJournalApp.swift
//  MoodJournal
//
//  Created by João Vitor Dall Agnol Fernandes on 03/05/21.
//

import SwiftUI

@main
struct MoodJournalApp: App {
    var mood: MoodModelController = MoodModelController()
    var viewRouter = ViewRouter()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(mood).environmentObject(viewRouter)
            
        }
    }
}
