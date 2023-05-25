//
//  NextWeekData.swift
//  WeatherApp
//
//  Created by poskreepta on 24.05.23.
//

import Foundation

struct NextWeekWeatherData: Codable {
    let list: [List]
}

struct List: Codable {
    let main: MainClass
    let weather: [WeatherWeek]
}

struct MainClass: Codable {
    let temp: Double
}

struct WeatherWeek: Codable {
    let id: Int
}


