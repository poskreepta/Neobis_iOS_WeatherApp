//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by poskreepta on 23.05.23.
//

import Foundation
import CoreLocation

protocol WeatherViewModelType {
    var model: WeatherModel { get }
    var modelDidChange: (() -> Void)? { get set }
    func fetchWeatherData(city: String)
    func fetchWeatherWeekData(city: String)
}

class WeatherViewModel: WeatherViewModelType {
    
    var modelDidChange: (() -> Void)?
    
    private(set) var model: WeatherModel = WeatherModel()
    
    func fetchWeatherData(city: String) {
        WeatherService.shared.fetchWeatherData(city: city) { [weak self] result in
            switch result {
            case .success(let weatherData):
                self?.updateModel(with: weatherData)
            case .failure(let error):
                print("Failed to fetch data:", error)
            }
        }
    }
    
    func fetchWeatherWeekData(city: String) {
        WeatherService.shared.fetchWeatherWeekData(city: city) { [weak self] result in
            switch result {
            case .success(let nextWeekWeatherData):
                self?.updateModel(with: nextWeekWeatherData)
            case .failure(let error):
                print("Failed to fetch data:", error)
            }
        }
    }
    
    private func updateModel(with weatherData: WeatherData) {
        model.conditionId = weatherData.weather[0].id
        model.temprature = weatherData.main.temp
        model.cityName = weatherData.name
        model.humidity = weatherData.main.humidity
        model.windStatus = weatherData.wind.speed
        model.airPressure = weatherData.main.pressure
        model.visibility = weatherData.visibility
        model.country = weatherData.sys.country
        
        modelDidChange?()
    }
    
    private func updateModel(with nextWeekWeatherData: NextWeekWeatherData) {
        model.temp1 = nextWeekWeatherData.list[0].main.temp
        model.temp2 = nextWeekWeatherData.list[7].main.temp
        model.temp3 = nextWeekWeatherData.list[14].main.temp
        model.temp4 = nextWeekWeatherData.list[21].main.temp
        model.temp5 = nextWeekWeatherData.list[27].main.temp
        model.conditionId1 = nextWeekWeatherData.list[0].weather[0].id
        model.conditionId2 = nextWeekWeatherData.list[7].weather[0].id
        model.conditionId3 = nextWeekWeatherData.list[14].weather[0].id
        model.conditionId4 = nextWeekWeatherData.list[21].weather[0].id
        model.conditionId5 = nextWeekWeatherData.list[27].weather[0].id
        
        modelDidChange?()
    }
}












