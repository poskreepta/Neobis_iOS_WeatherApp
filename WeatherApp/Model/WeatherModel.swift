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
    var windStatus: Int?
    var humidity: Int?
    var visibility: Int?
    var airPressure: Int?
    var lat: Double?
    var long: Double?
    
    var tempratureString: String? {
        return String(format: "%.1f", temprature!)
    }
    
//    var conditionName: String? {
//        switch conditionId {
//                case 200...232:
//                    return "cloud.bolt"
//                case 300...321:
//                    return "cloud.drizzle"
//                case 500...531:
//                    return "cloud.rain"
//                case 600...622:
//                    return "cloud.snow"
//                case 701...781:
//                    return "cloud.fog"
//                case 800:
//                    return "sun.max"
//                case 801...804:
//                    return "cloud.bolt"
//                default:
//                    return "cloud"
//                }
//    }
}
