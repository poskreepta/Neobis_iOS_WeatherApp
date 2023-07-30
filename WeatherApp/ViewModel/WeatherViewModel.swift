//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by poskreepta on 20.07.23.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa

protocol WeatherViewModelType {
    var weatherData: Observable<WeatherData?> { get }
    var nextWeekData: Observable<NextWeekData?> { get }
//    var modelDidChange: (() -> Void)? { get set }
    func fetchWeatherData(city: String)
    func fetchWeatherWeekData(city: String)
    func fetchWeatherWithLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    func fetchWeekWeatherWithLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
}

class WeatherViewModel: WeatherViewModelType {
    
    private let disposeBag = DisposeBag()
    private let _weatherData = BehaviorRelay<WeatherData?>(value: nil)
    private let _nextWeekData = BehaviorRelay<NextWeekData?>(value: nil)
    
    //    var modelDidChange: (() -> Void)?
    var weatherData: Observable<WeatherData?> {
        return _weatherData.asObservable()
    }
    
    var nextWeekData: Observable<NextWeekData?> {
        return _nextWeekData.asObservable()
    }
    
    
    func fetchWeatherData(city: String) {
        WeatherService.shared.fetchWeatherData(city: city) { [weak self] result in
            switch result {
            case .success(let weatherData):
                self?._weatherData.accept(weatherData)
//                self?.weatherData = weatherData
//                self?.modelDidChange?()
            case .failure(let error):
                print("Failed to fetch data:", error)
            }
        }
    }
    
    func fetchWeatherWithLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        WeatherService.shared.fetchWeatherWithLocation(latitude: latitude, longitude: longitude) { [weak self] result in
            switch result {
            case .success(let weatherData):
                self?._weatherData.accept(weatherData)
//                self?.weatherData = weatherData
//                self?.modelDidChange?()
            case .failure(let error):
                print("Failed to fetch data:", error)
            }
        }
    }
    
    func fetchWeatherWeekData(city: String) {
        WeatherService.shared.fetchWeatherWeekData(city: city) { [weak self] result in
            switch result {
            case .success(let nextWeekData):
                self?._nextWeekData.accept(nextWeekData)
//                self?.nextWeekData = nextWeekData
//                self?.modelDidChange?()
            case .failure(let error):
                print("Failed to fetch data:", error)
            }
        }
    }
    
    func fetchWeekWeatherWithLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        WeatherService.shared.fetchWeekWeatherWithLocation(latitude: latitude, longitude: longitude) { [weak self] result in
            switch result {
            case .success(let nextWeekData):
                self?._nextWeekData.accept(nextWeekData)
//                self?.nextWeekData = weatherData
//                self?.modelDidChange?()
            case .failure(let error):
                print("Failed to fetch data:", error)
            }
        }
    }
    
}












