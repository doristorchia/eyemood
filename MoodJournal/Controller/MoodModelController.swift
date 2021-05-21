//
//  MoodModelController.swift
//  testMood
//
//  Created by Rodrigo de Anhaia on 05/05/21.
//


import Foundation
import Combine
import UIKit

class MoodModelController: ObservableObject {
    
    //MARK: - Properties
    @Published var moods: [Mood] = []
    
    
    init() {
        loadFromPersistentStore()
    }
    
    func getMonths() -> [String] {
        var months: [String] = []
        
        let formatter : DateFormatter = {
            let df = DateFormatter()
            df.locale = Locale(identifier: "en_US_POSIX")
            df.dateFormat = "MMMM"
            return df
        }()

       
        
        for mood in moods {
            if !months.contains(mood.monthString) {
                months.append(mood.monthString)
            }
        }
        
        let sortedArrayOfMonths = months.sorted( by: { formatter.date(from: $0)! < formatter.date(from: $1)! })
        
        return sortedArrayOfMonths
        
    }
    
    func sortDays() -> [Mood] {
        let sorted = moods.sorted(by: { $0.date.compare($1.date) == .orderedAscending })
        
        return sorted
    }
    
    func getDays(monthString: String) -> [Mood]{
        var dict: [Int : [Mood]] = [:]
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM"
        
        let monthDate = formatter.date(from: monthString)
        let monthInt = Calendar.current.component(.month, from: monthDate ?? Date())
        
        let monthsByInt = getMonthsByInt()
        
        for month in monthsByInt {
            dict[month] = []
        }
        
        for mood in moods{
            dict[Calendar.current.component(.month, from: mood.date)]?.append(mood)
            
        }

        for month in monthsByInt {
            let sorted = dict[month]?.sorted(by: {$0.date.compare($1.date) == .orderedDescending })
            dict[month] = sorted
        }
        
     
        return dict[monthInt] ?? []
    }
    
    func getMonthsByInt() -> [Int] {
        var months: [Int] = []
        for mood in moods {
            if !months.contains(Calendar.current.component(.month, from: mood.date)) {
                months.append(Calendar.current.component(.month, from: mood.date))
            }
        }
        
        return months
    }
    
    //MARK: - CRUD Functions
    func createMood(emotion: Emotion, comment: String?, date: Date) {

        let newMood = Mood(emotion: emotion, comment: comment, date: date)
        
        moods.append(newMood)
        saveToPersistentStore()
    
    }
    
    func deleteMood(at offset: IndexSet) {
        
        guard let index = Array(offset).first else { return }
     print("INDEX: \(index)")
        moods.remove(at: index)
        
        saveToPersistentStore()
    }
    
    
    func updateMoodComment(mood: Mood, comment: String) {
        if let index = moods.firstIndex(of: mood) {
            var mood = moods[index]
            mood.comment = comment
            
            moods[index] = mood
            saveToPersistentStore()
        }
    }
    
    // MARK: Save, Load from Persistent
    private var persistentFileURL: URL? {
      let fileManager = FileManager.default
      guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        else { return nil }
       
      return documents.appendingPathComponent("mood.plist")
    }
    
    func saveToPersistentStore() {
        
        // Stars -> Data -> Plist
        guard let url = persistentFileURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(moods)
            try data.write(to: url)
        } catch {
            print("Error saving stars data: \(error)")
        }
    }
    
    func loadFromPersistentStore() {
        
        // Plist -> Data -> Stars
        let fileManager = FileManager.default
        guard let url = persistentFileURL, fileManager.fileExists(atPath: url.path) else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            moods = try decoder.decode([Mood].self, from: data)
        } catch {
            print("error loading stars data: \(error)")
        }
    }
    
    func getMoodsByDay(date: Date) -> [Mood] {
        
        var moodsByDay: [Mood] = []
        
        //let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "d MMM y"
        let paramString = date.dateToString(format: "d MMM y") //data passada no metodo em string
        
        
        for mood in self.moods {
            let selectedDateString = mood.date.dateToString(format: "d MMM y")
            if selectedDateString == paramString {
                moodsByDay.append(mood)
            }
        }
        return moodsByDay
    }
    
    func getMoodsByMonth(date: Date) -> [Mood] {
        var moodsByMonth: [Mood] = []
        
        let paramString = date.dateToString(format: "MMM y") //data passada no metodo em string

        for mood in self.moods {
            let selectedDateString = mood.date.dateToString(format: "MMM y")
            if selectedDateString == paramString {
                moodsByMonth.append(mood)
            }
        }
        return moodsByMonth
    }
    
    func getReports(date: Date) -> [MonthlyReport] {
        let moodsOfMonth = self.getMoodsByMonth(date: date)
        var angry: Int = 0
        var happy: Int = 0
        var calm: Int = 0
        var sad: Int = 0
        
        for mood in moodsOfMonth {
            switch mood.emotion.state {
            case .happy:
                happy += 1
            case .angry:
                angry += 1
            case .calm:
                calm += 1
            case .sad:
                sad += 1
            }
        }
        let total = angry + happy + calm + sad
        let angryReport = MonthlyReport(moodAssetName: "angry-barGraph", amount: angry, totalAmount: total)
        let happyReport = MonthlyReport(moodAssetName: "happy-barGraph", amount: happy, totalAmount: total)
        let calmReport = MonthlyReport(moodAssetName: "calm-barGraph", amount: calm, totalAmount: total)
        let sadReport = MonthlyReport(moodAssetName: "sad-barGraph", amount: sad, totalAmount: total)
        
        let reports: [MonthlyReport] = [happyReport, angryReport, calmReport, sadReport]
        
        return reports
    }
    
    func getDailyReports(date: Date) -> [MonthlyReport] {
        let moodsOfMonth = self.getMoodsByDay(date: date)
        var angry: Int = 0
        var happy: Int = 0
        var calm: Int = 0
        var sad: Int = 0
        
        for mood in moodsOfMonth {
            switch mood.emotion.state {
            case .happy:
                happy += 1
            case .angry:
                angry += 1
            case .calm:
                calm += 1
            case .sad:
                sad += 1
            }
        }
        let total = angry + happy + calm + sad
        let angryReport = MonthlyReport(moodAssetName: "angry-barGraph", amount: angry, totalAmount: total)
        let happyReport = MonthlyReport(moodAssetName: "happy-barGraph", amount: happy, totalAmount: total)
        let calmReport = MonthlyReport(moodAssetName: "calm-barGraph", amount: calm, totalAmount: total)
        let sadReport = MonthlyReport(moodAssetName: "sad-barGraph", amount: sad, totalAmount: total)
        
        let reports: [MonthlyReport] = [happyReport, angryReport, calmReport, sadReport]
        
        return reports
    }
}
