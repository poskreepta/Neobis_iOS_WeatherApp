//
//  NextWeekModel.swift
//  Neobis_iOS_WeatherApp
//
//  Created by Тагай Абдылдаев on 25/4/23.
//

import Foundation

struct NextWeekWeatherData: Codable {
    let list: [List]
}

struct List: Codable {
    let main: MainClass
    let weather: [Weather]
}

struct MainClass: Codable {
    let temp: Double
}

//struct NextWeather: Codable {
//    let icon: String
//}


