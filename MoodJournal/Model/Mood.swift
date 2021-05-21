//
//  MoodModel.swift
//  testMood
//
//  Created by Rodrigo de Anhaia on 04/05/21.
//

import Foundation
import SwiftUI

enum EmotionState: String, Codable {
    case happy
    case calm
    case sad
    case angry
}

enum MoodColor: String, Codable {
    case calmColor = "mehColor"
    case sadColor = "sadColor"
    case happyColor = "happyColor"
    case angryColor = "angryColor"
}

struct Emotion: Codable {
    var state: EmotionState
    var color: MoodColor

    var moodColor: Color {
        switch color {
        case .calmColor:
            return Color(#colorLiteral(red: 0.2705882353, green: 0.7882352941, blue: 0.4901960784, alpha: 1))
        case .angryColor:
            return Color(#colorLiteral(red: 0.9778849483, green: 0.180129528, blue: 0.2798365951, alpha: 1))
        case .happyColor:
            return Color(#colorLiteral(red: 1, green: 0.7770196199, blue: 0, alpha: 1))
        case .sadColor:
            return Color(#colorLiteral(red: 0.005369239487, green: 0.5060937405, blue: 0.6911765933, alpha: 1))
        }
    }
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
