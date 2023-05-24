//
//  DateFormat.swift
//  Neobis_iOS_WeatherApp
//
//  Created by Тагай Абдылдаев on 2/5/23.
//

import Foundation

class DateToStringFormat {
    
    static let shared = DateToStringFormat()
    
    func currentDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter.string(from: date)
    }
    
    func getNextDates(day: Int) -> String {
        let calendar = Calendar.current
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        guard let nextDate = calendar.date(byAdding: .day, value: day, to: currentDate) else {
            return ""
        }
        let weekDay = calendar.component(.weekday, from: nextDate)
        dateFormatter.locale = Locale(identifier: "en_US")
        let day = dateFormatter.weekdaySymbols[weekDay - 1]
        return day
        
 }
    
//    func nextDate(day: Int) -> String {
//        let calendar = Calendar.current
//        let today = Date()
//        guard let nextDate = calendar.date(byAdding: .day, value: day, to: today) else {return ""}
//        let weekDay = calendar.component(.weekday, from: nextDate)
//        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "en_US")
//        let weekDayName = dateFormatter.weekdaySymbols[weekDay - 1]
//        return weekDayName
//    }
}
