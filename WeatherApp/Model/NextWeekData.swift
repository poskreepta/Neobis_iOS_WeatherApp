//
//  NextWeekData.swift
//  WeatherApp
//
//  Created by poskreepta on 24.06.23.
//

import Foundation

struct NextWeekData: Codable {
    let list: [List]
}

struct List: Codable {
    let main: MainClass
    let weather: [WeatherWeek]
}

struct MainClass: Codable {
    let temp: Double?
}

struct WeatherWeek: Codable {
    let id: Int
}


extension NextWeekData {
    var temp1String: String {
        if let temp = list[0].main.temp  {
            return "\(String(format: "%.0f", temp - 273.15))°C"
        } else {
            return "N/A"
        }
    }
    var temp2String: String {
        if let temp = list[7].main.temp  {
            return "\(String(format: "%.0f", temp - 273.15))°C"
        } else {
            return "N/A"
        }
    }
    
    var temp3String: String {
        if let temp = list[14].main.temp {
            return "\(String(format: "%.0f", temp - 273.15))°C"
        } else {
            return "N/A"
        }
    }
    
    var temp4String: String {
        if let temp = list[21].main.temp {
            return "\(String(format: "%.0f", temp - 273.15))°C"
        } else {
            return "N/A"
        }
    }
    
    var temp5String: String {
        if let temp = list[28].main.temp {
            return "\(String(format: "%.0f", temp - 273.15))°C"
        } else {
            return "N/A"
        }
    }
    
    func getConditionName(condition: Int?) -> String {
        if let condition = condition {
            switch condition {
            case 200...232:
                return "thunderImage"
            case 300...321:
                return "rainSunImage"
            case 500...531:
                return "rainSunImage"
            case 600...622:
                return "snowImage"
            case 701...781:
                return "cloudyImage"
            case 800:
                return "sunLittle"
            case 801...804:
                return "thunderImage"
            default:
                return "cloudyImage"
            }
        }
        return "cloudyImage"
    }
    
    var conditionName1: String {
        return getConditionName(condition: list[0].weather[0].id)
    }
    
    var conditionName2: String {
        return getConditionName(condition: list[7].weather[0].id)
    }
    
    var conditionName3: String {
        return getConditionName(condition: list[14].weather[0].id)
    }
    
    var conditionName4: String {
        return getConditionName(condition: list[21].weather[0].id)
    }
    
    var conditionName5: String {
        return getConditionName(condition: list[28].weather[0].id)
    }
    
    var nextWeekArray: [WeatherWeekModel] {
        return [WeatherWeekModel(day: DateToStringFormat.shared.getNextDates(day: 1), temp: temp1String, image: conditionName1),
                WeatherWeekModel(day: DateToStringFormat.shared.getNextDates(day: 2), temp: temp2String, image: conditionName2),
                WeatherWeekModel(day: DateToStringFormat.shared.getNextDates(day: 3), temp: temp3String, image: conditionName3),
                WeatherWeekModel(day: DateToStringFormat.shared.getNextDates(day: 4), temp: temp4String, image: conditionName4),
                WeatherWeekModel(day: DateToStringFormat.shared.getNextDates(day: 5), temp: temp5String, image: conditionName5)]
    }
}


