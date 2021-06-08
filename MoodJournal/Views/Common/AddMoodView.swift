//
//  AddMoodView.swift
//  MoodJournal
//
//  Created by Rodrigo de Anhaia on 18/05/21.
//  Edited by Rodrigo de Anhaia on 08/06/21.
//

import SwiftUI
import Combine

struct AddMoodView: View {
    
    @EnvironmentObject var moodModelController: MoodModelController
    @Environment(\.presentationMode) var presentationMode
    
    @State var text: String? = nil
    @State private var emotionState: EmotionState = .happy
    @State private var counterLabel = "101/101"
    @State private var selection = 0
    @State private var keyboardHeight: CGFloat = 0
    
    @State private var hidden: Bool = true
    @State private var hiddenLess: Bool = true
    @State private var hiddenGreater: Bool = false
    
    private var keyboardHeightPublisher: AnyPublisher<CGFloat, Never> {
        Publishers.Merge(
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillShowNotification)
                .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect }
                .map { $0.height },
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in CGFloat(0) }
        ).eraseToAnyPublisher()
    }
    
    var body: some View {
        VStack {
            Text("How are you felling today?")
                .foregroundColor(Color.black)
                .bold()
                .font(.title2)
                .font(.system(size: 20))
                .multilineTextAlignment(.center)
                .padding(.top, 60)
                .padding(.horizontal,30)
       
            TabView(selection: $selection) {
                ForEach(EmotionState.allCases, id: \.self) { emotion in
                    HStack {
                        Button(action: {
                            if self.selection > 0 {
                                self.selection -= 1
                            }
                            
                        }) {
                            Image("lessthan")
                                .resizable()
                                .frame(width: 50, height: 100)
                                .foregroundColor(.black)
                                .animation(.easeIn)
                                .isHidden(hiddenLess)
                                
                        }
                        
                        Spacer()
                        VStack {
                            Image("\(emotion)")
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(10)
                                .aspectRatio(1, contentMode: .fit)
                             
                            Text("\(emotion.getMoodName())")
                                .foregroundColor(.black)
                                .font(.title)
                        }
                        Spacer()
                        
                        Button(action: {
                            if selection < 3 {
                                self.selection += 1
                                self.hiddenGreater = false
                            }
                        }) {
                            Image("greaterthan")
                                .resizable()
                                .frame(width: 50, height: 100)
                                .foregroundColor(.black)
                                .animation(.easeInOut)
                                .isHidden(hiddenGreater)
                            
                        }
                    }
                    .animation(.easeInOut)
                    .tag(emotion.rawValue)
                }
            }
            .onChange(of: selection, perform: { value in
                withAnimation {
                    self.emotionState = EmotionState(rawValue: value)!
                    
                    if selection == 0 {
                        hiddenLess = true
                        hiddenGreater = false
                        
                    } else if selection == 1 || selection == 2 {
                        hiddenLess = false
                        hiddenGreater = false
                        
                    } else {
                        hiddenLess = false
                        hiddenGreater = true
                    }
                }
            })
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            ZStack(alignment: .bottomTrailing) {
                MultiLineTextField(txt: $text, counterLabel: $counterLabel)
                    .frame(width: 300, height: 100)
                    .cornerRadius(20)
                    
                Text("Remaining: \(counterLabel)")
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding([.leading, .bottom, .trailing], 8)
                
            }
            .padding(.bottom)
            .animation(.easeInOut(duration: 1.0))
            
            Button(action: {
                self.moodModelController.createMood(emotion: Emotion(state: emotionState), comment: self.text, date: Date())
                
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
            .padding(.bottom)
            .animation(.easeInOut)
            
            // MARK: - This text element is for keyboard function, not for compressing the entire screen
            Text("")
                .frame(height: keyboardHeight)
            
        }
        .onReceive(keyboardHeightPublisher) { self.keyboardHeight = $0 }
        .background(emotionState.getColorLiteral())
        .edgesIgnoringSafeArea(.all)
        .ignoresSafeArea(.keyboard)
        
    }
}

struct AddMoodView_Previews: PreviewProvider {
    static var previews: some View {
        AddMoodView()
    }
}

extension View {
    
    /// Hide or show the view based on a boolean value.
    ///
    /// Example for visibility:
    ///
    ///     Text("Label")
    ///         .isHidden(true)
    ///
    /// Example for complete removal:
    ///
    ///     Text("Label")
    ///         .isHidden(true, remove: true)
    ///
    /// - Parameters:
    ///   - hidden: Set to `false` to show the view. Set to `true` to hide the view.
    ///   - remove: Boolean value indicating whether or not to remove the view.
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}
