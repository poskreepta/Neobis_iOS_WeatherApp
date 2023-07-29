//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by poskreepta on 20.07.23.
//

import Foundation
import CoreLocation

protocol WeatherViewModelType {
    var weatherData: WeatherData? { get }
    var nextWeekData: NextWeekData? { get }
    var modelDidChange: (() -> Void)? { get set }
    func fetchWeatherData(city: String)
    func fetchWeatherWeekData(city: String)
    func fetchWeatherWithLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    func fetchWeekWeatherWithLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
}

class WeatherViewModel: WeatherViewModelType {
    
    var modelDidChange: (() -> Void)?
    
    private(set) var weatherData: WeatherData?
    private(set) var nextWeekData: NextWeekData?
    
    func fetchWeatherData(city: String) {
        WeatherService.shared.fetchWeatherData(city: city) { [weak self] result in
            switch result {
            case .success(let weatherData):
                self?.weatherData = weatherData
                self?.modelDidChange?()
            case .failure(let error):
                print("Failed to fetch data:", error)
            }
        }
    }
    
    func fetchWeatherWithLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        WeatherService.shared.fetchWeatherWithLocation(latitude: latitude, longitude: longitude) { [weak self] result in
            switch result {
            case .success(let weatherData):
                self?.weatherData = weatherData
                self?.modelDidChange?()
            case .failure(let error):
                print("Failed to fetch data:", error)
            }
        }
    }
    
    func fetchWeatherWeekData(city: String) {
        WeatherService.shared.fetchWeatherWeekData(city: city) { [weak self] result in
            switch result {
            case .success(let nextWeekData):
                self?.nextWeekData = nextWeekData
                self?.modelDidChange?()
            case .failure(let error):
                print("Failed to fetch data:", error)
            }
        }
    }
    
    func fetchWeekWeatherWithLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        WeatherService.shared.fetchWeekWeatherWithLocation(latitude: latitude, longitude: longitude) { [weak self] result in
            switch result {
            case .success(let weatherData):
                self?.nextWeekData = weatherData
                self?.modelDidChange?()
            case .failure(let error):
                print("Failed to fetch data:", error)
            }
        }
    }
    
}












