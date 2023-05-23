//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by poskreepta on 23.05.23.
//

import Foundation

//struct WeatherModel: Codable {
//    let current: CurrentWeather
//}

struct WeatherData: Codable {
    let name: String
    let coord: Coord
    let country: String
    let state: String
    let main: Main
    let wind: Wind
    let weather: [Weather]
}

struct Main: Codable {
    let temp: Double
    let pressure, humidity: Int
}

struct Wind: Codable {
    let speed: Double
}

struct Coord: Codable {
    let lon, lat: Double
}

struct Weather: Codable { //decodable for our JSON Decoder
    let id: Int
}
