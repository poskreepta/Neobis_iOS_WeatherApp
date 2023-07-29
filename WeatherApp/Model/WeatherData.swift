//
//  WeatherData.swift
//  WeatherApp
//
//  Created by poskreepta on 23.06.23.
//

import Foundation

struct WeatherData: Codable {
    let name: String?
    let coord: Coord
    let main: Main
    let wind: Wind
    let visibility: Int?
    let weather: [Weather]
    let sys: Sys
}

struct Main: Codable {
    let temp: Double?
    let pressure, humidity: Int?
}

struct Wind: Codable {
    let speed: Double?
}

struct Coord: Codable {
    let lon, lat: Double
}

struct Weather: Codable { 
    let id: Int
}

struct Sys: Codable {
    let country: String?
}

extension WeatherData {
    
    var cityName: String {
        if let cityName = name {
            return cityName
        } else {
            return "N/A"
        }
    }
    
    var tempratureString: String {
        if let temp = main.temp {
            return String(format: "%.1f", temp)
        } else {
            return "N/A"
        }
    }
    
    var humidityString: String {
        if let humidity = main.humidity {
            return "\(String(humidity)) %"
        } else {
            return "N/A"
        }
    }
    
    var windStatusString: String {
        if let wind = wind.speed {
            return "\(String(wind)) mph"
        } else {
            return "N/A"
        }
    }
    
    var visibilityString: String {
        if let visibility = visibility {
            return "\(String(visibility / 1609)) miles"
        } else {
            return "N/A"
        }
    }
    
    var airPressureString: String {
        if let air = main.pressure {
            return "\(String(air)) mb"
        } else {
            return "N/A"
        }
    }
    
    var countryString: String {
        if let country = sys.country {
            return "\(String(country))"
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
            return getConditionName(condition: weather[0].id)
        }
}
