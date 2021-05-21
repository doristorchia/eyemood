//
//  AddMoodView.swift
//  MoodJournal
//
//  Created by Rodrigo de Anhaia on 18/05/21.
//

import SwiftUI

struct AddMoodView: View {
    
    @EnvironmentObject var moodModelController: MoodModelController
    @Environment(\.presentationMode) var presentationMode
    
    @State var text: String? = nil
    @State private var emotionState: EmotionState = .happy
    @State private var moodColor: MoodColor = .happyColor
    @State private var happyIsSelected = false
    @State private var sadIsSelected = false
    @State private var angryIsSelected = false
    @State private var calmIsSelected = false
    @State private var mehIsSelected = false
    
    @State private var counterLabel = "101/101"
    
    @State private var offSet: CGFloat = .zero
    
    var body: some View {
        ZStack {
            if offSet > 520 {
                Color(#colorLiteral(red: 1, green: 0.7770196199, blue: 0, alpha: 1))
                    .ignoresSafeArea()
            } else if offSet > 260 {
                Color(#colorLiteral(red: 0.2741676867, green: 0.786375463, blue: 0.4911866784, alpha: 1))
                    .ignoresSafeArea()
            } else if offSet > -179.9 {
                Color(#colorLiteral(red: 0.1725490196, green: 0.640881896, blue: 0.8213298321, alpha: 1))
                    .ignoresSafeArea()
            } else if offSet < -180 {
                Color(#colorLiteral(red: 0.9687100053, green: 0.448386848, blue: 0.4913209677, alpha: 1))
                    .ignoresSafeArea()
            }
            
            VStack{
                Text(" How are you felling today? ")
                    .foregroundColor(Color.black)
                    .bold()
                    .font(.title2)
                    .font(.system(size: 20))
                    .multilineTextAlignment(.center)
                    .padding(.top, 60)
                    .padding(.horizontal,30)
                
                ScrollView(.horizontal) {
                    LazyHStack {
                        Button(action: {
                            self.emotionState = .happy
                            self.moodColor = .happyColor
                            self.happyIsSelected = true
                            self.calmIsSelected = false
                            self.sadIsSelected = false
                            self.angryIsSelected = false
                            
                        }) {
                            VStack{
                                Image("happy")
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(Rectangle())
                                    .cornerRadius(10)
                                    
                                Text("Happy")
                                    .foregroundColor(.black)
                                    .font(.title)
                            }
                        }
                        .padding(.horizontal, 40)
                        
                        Button(action: {
                            self.emotionState = .calm
                            self.moodColor = .calmColor
                            self.calmIsSelected = true
                            self.happyIsSelected = false
                            self.sadIsSelected = false
                            self.angryIsSelected = false
                            
                        }) {
                            VStack{
                                Image("calm")
                                    .resizable()
                                    .scaledToFit()
                                    .clipShape(Rectangle())
                                    .cornerRadius(10)
                                
                                Text("Calm")
                                    .foregroundColor(.black)
                                    .font(.title)
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        Button(action: {
                            self.emotionState = .sad
                            self.moodColor = .sadColor
                            self.sadIsSelected = true
                            self.happyIsSelected = false
                            self.calmIsSelected = false
                            self.angryIsSelected = false
                            
                        }) {
                            VStack{
                                Image("sad")
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(10)
                                
                                Text("Sad")
                                    .foregroundColor(.black)
                                    .font(.title)
                                
                            }
                        }
                        .padding(.horizontal, 20)
                        
                        Button(action: {
                            self.emotionState = .angry
                            self.moodColor = .angryColor
                            self.angryIsSelected = true
                            self.sadIsSelected = false
                            self.happyIsSelected = false
                            self.calmIsSelected = false
                            
                        }) {
                            VStack {
                                Image("angry")
                                    .resizable()
                                    .scaledToFit()
                                    .cornerRadius(10)
                                
                                
                                Text("Angry")
                                    .foregroundColor(.black)
                                    .font(.title)
                            }
                        }
                        .padding(.horizontal, 40)
                        
                    }
                    
                    GeometryReader { geometry in
                        let offSet = geometry.frame(in: .named("scroll")).minX
                        Color.clear.preference(key: ScrollOffSet.self, value: offSet)
                    }
                    .frame(width: 100, height: 50)
                }
                .coordinateSpace(name: "scroll")
                .onPreferenceChange(ScrollOffSet.self, perform: { value in
                    self.offSet = value
                })
                
                ZStack(alignment: .bottomTrailing) {
                    MultiLineTextField(txt: $text, counterLabel: $counterLabel)
                        .frame(width: 300, height: 150)
                        .cornerRadius(20)
                    
                    Text("Remaining: \(counterLabel)")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding([.leading, .bottom, .trailing], 8)
                }
                
                Button(action: {
                    self.moodModelController.createMood(emotion: Emotion(state: setCorrectMood(), color: self.moodColor), comment: self.text, date: Date())
                    
                    self.presentationMode.wrappedValue.dismiss()
                    
                }) {
                    Text("Save")
                        .bold()
                        .frame(width: 300, height: 50)
                        .background(Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)))
                        .foregroundColor(.white)
                        .cornerRadius(30)
                        .padding(.top, 30)
                }
                Spacer()
            }
        }
    }
    
    func setCorrectMood() -> EmotionState {
            var emotion: EmotionState = .happy
            if self.offSet > 520 {
                emotion = .happy
            } else if offSet > 260 {
                emotion = .calm
            } else if offSet > -179.9 {
                emotion = .sad
            } else if offSet < -180 {
                emotion = .angry
            }
            return emotion
        }
    
}

struct ScrollOffSet: PreferenceKey {
    typealias Value = CGFloat
    
    static var defaultValue: CGFloat = .zero
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
    
}

struct AddMoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddMoodView()
    }
}
