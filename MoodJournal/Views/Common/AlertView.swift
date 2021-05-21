//
//  AlertView.swift
//  MoodJournal
//
//  Created by Guilherme Henrique on 13/05/21.
//

import SwiftUI

struct AlertView: View {
    @State private var showingAlert = false

    var body: some View {
        Button("Show Alert") {
            showingAlert = true
        }
        .alert(isPresented:$showingAlert) {
            Alert(
                title: Text("Are you feeling okay?"),
                message: Text("You have been feeling sad or angry for at least 10 days in the last month. We recommend professional help."),
                primaryButton: .destructive(Text("I understand.")),
                secondaryButton: .cancel()
            )
        }
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView()
    }
}
