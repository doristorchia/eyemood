//
//  MoodsRowView.swift
//  testMood
//
//  Created by Rodrigo de Anhaia on 05/05/21.
//

import SwiftUI

struct MoodsRowView: View {
    var mood: Mood
    
    var body: some View {
        VStack (alignment: .leading){
            HStack(alignment: .top){
                Text("\(mood.dayAsInt)")
                    .font(.title3)
                    .padding(.leading, -16)
               
                ZStack {
                    Rectangle()
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color(#colorLiteral(red: 0.8156862745, green: 0.8156862745, blue: 0.831372549, alpha: 1)), radius: 10, x: 1, y: 6)
                    
                    HStack(alignment: .top) {
                        VStack {
                            
                            moodImage()
                                .padding(.vertical, 10)
                                
                        }
                        
                        VStack(alignment: .trailing) {
                            Text(mood.comment ?? "No comment made.")
                                .font(.subheadline)
                                .padding(.top, 10)
                                .padding(.bottom, 20)
                        }
                        
                        Spacer()
                    }
                    .foregroundColor(.black)
                    .padding(.leading, 10)
                }
                .padding(.leading, 20)
            }
            .padding()
        }
    }
    
    func moodImage() -> some View {
        var imageName = "none"
        
        switch mood.emotion.state {
        case .happy:
            imageName = "happy"
        case .sad:
            imageName = "sad"
        case .angry:
            imageName = "angry"
        case .calm:
            imageName = "calm"
        }
        return Image(imageName)
            .resizable()
            .frame(width: 60, height: 75, alignment: .top)
            .cornerRadius(10)
    }
}

struct MoodsRowView_Previews: PreviewProvider {
    static var previews: some View {
        MoodsRowView(mood: Mood(emotion: Emotion(state: .happy, color: .happyColor), comment: "Test", date: Date()))
    }
}
