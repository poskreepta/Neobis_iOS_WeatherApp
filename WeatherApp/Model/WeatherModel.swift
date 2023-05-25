//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by poskreepta on 23.05.23.
//

import Foundation

struct WeatherModel {
    var conditionId: Int?
    var cityName: String?
    var date: String?
    var country: String?
    var temprature: Double?
    var windStatus: Double?
    var humidity: Int?
    var visibility: Int?
    var airPressure: Int?
    var temp1: Double?
    var temp2: Double?
    var temp3: Double?
    var temp4: Double?
    var temp5: Double?
    var conditionId1: Int?
    var conditionId2: Int?
    var conditionId3: Int?
    var conditionId4: Int?
    var conditionId5: Int?
    
    var tempratureString: String? {
        if let temperature = temprature {
            return String(format: "%.1f", temperature)
        } else {
            return "N/A"
        }
    }
    
    var humidityString: String? {
        if let humidity = humidity {
            return "\(String(humidity)) %"
        } else {
            return "N/A"
        }
    }
    
    var windStatusString: String? {
        if let wind = windStatus {
            return "\(String(wind)) mph"
        } else {
            return "N/A"
        }
    }
    
    var visibilityString: String? {
        if let visibility = visibility {
            return "\(String(visibility / 1609)) miles"
        } else {
            return "N/A"
        }
    }
    
    var airPressureString: String? {
        if let air = airPressure {
            return "\(String(air)) mb"
        } else {
            return "N/A"
        }
    }
    
    var countryString: String? {
        if let country = country {
            return "\(String(country))"
        } else {
            return "N/A"
        }
    }
    
    var temp1String: String {
        if let temp = temp1 {
            return "\(String(format: "%.0f", temp - 273.15))°C"
        } else {
            return "N/A"
        }
    }
    var temp2String: String {
        if let temp = temp2 {
            return "\(String(format: "%.0f", temp - 273.15))°C"
        } else {
            return "N/A"
        }
    }
    
    var temp3String: String {
        if let temp = temp3 {
            return "\(String(format: "%.0f", temp - 273.15))°C"
        } else {
            return "N/A"
        }
    }
    
    var temp4String: String {
        if let temp = temp4 {
            return "\(String(format: "%.0f", temp - 273.15))°C"
        } else {
            return "N/A"
        }
    }
    
    var temp5String: String {
        if let temp = temp5 {
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
    
    var conditionName: String {
        return getConditionName(condition: conditionId)
    }
    
    var conditionName1: String {
        return getConditionName(condition: conditionId1)
    }

    var conditionName2: String {
        return getConditionName(condition: conditionId2)
    }

    var conditionName3: String {
        return getConditionName(condition: conditionId3)
    }
    
    var conditionName4: String {
        return getConditionName(condition: conditionId4)
    }
    
    var conditionName5: String {
        return getConditionName(condition: conditionId5)
    }
   
    
}
