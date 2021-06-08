//
//  MoodModel.swift
//  testMood
//
//  Created by Rodrigo de Anhaia on 04/05/21.
//

import Foundation
import SwiftUI

enum EmotionState: Int, CaseIterable, Codable {
    case happy
    case calm
    case sad
    case angry
    
    func getStringColor() -> String {

        switch self {
        case .happy:
            return "happyColor"
        case .calm:
            return "calmColor"
        case .sad:
            return "sadColor"
        case .angry:
            return "angryColor"
        }
    }
    
    func getColorLiteral() -> Color {
        switch self {
        case .happy:
            return Color(#colorLiteral(red: 1, green: 0.7770196199, blue: 0, alpha: 1))
        case .calm:
            return Color(#colorLiteral(red: 0.2741676867, green: 0.786375463, blue: 0.4911866784, alpha: 1))
        case .sad:
            return Color(#colorLiteral(red: 0.1708220243, green: 0.640881896, blue: 0.8213298321, alpha: 1))
        case .angry:
            return Color(#colorLiteral(red: 0.9687100053, green: 0.448386848, blue: 0.4913209677, alpha: 1))
        }
    }
    func getMoodName() -> String {
        switch self {
        case .happy:
            return "Happy"
        case .calm:
            return "Calm"
        case .sad:
            return "Sad"
        case .angry:
            return "Angry"
        }
    }
    
    func getMoodImage() -> Image {
        var imageName = "none"
        
        switch self {
        case .happy:
             imageName = "happy"
        case .calm:
             imageName = "calm"
        case .sad:
             imageName = "sad"
        case .angry:
             imageName = "angry"
     
        }
        return Image(imageName)
    }
}

struct Emotion: Codable {
    var state: EmotionState

}

struct Mood: Codable, Equatable, Identifiable {
    var id = UUID()
    let emotion: Emotion
    var comment: String?
    let date: Date
    
    init(emotion: Emotion, comment: String?, date: Date) {
        self.emotion = emotion
        self.comment = comment
        self.date = date
    }
    
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM y"
        return formatter.string(from: date)
    }
    
    var monthString: String {

    let dateFormatter1 = DateFormatter()
    dateFormatter1.dateFormat = "LLL"
    
    let month = dateFormatter1.string(from: date)
    
    return month
    
    }
    
    var dayAsInt: Int {
        let day = Calendar.current.component(.day, from: date)
        return day
    }
    
    var year: String {
        return Calendar.current.component(.year, from: date).description
    }
    
    
    static func == (lhs: Mood, rhs: Mood) -> Bool {
        if lhs.date == rhs.date {
            return true
        } else {
            return false
        }
    }
}

let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    return formatter
}()
