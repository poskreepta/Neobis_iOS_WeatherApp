//
//  WeatherService.swift
//  WeatherApp
//
//  Created by poskreepta on 25.06.23.
//

import Foundation
import CoreLocation

enum ServiceError: Error {
    case serviceError(String)
    case unknown(String = "An unknown error occured")
    case decodingError(String = "Error parsing server response")
}

class WeatherService {
    
    let weatherURLtoday = "https://api.openweathermap.org/data/2.5/weather?appid=91e5d58992af1530198417d1084df956&&units=metric"
    
    static let shared = WeatherService()
    
    private init() {}
    
    func fetchWeatherData(city: String, copmletion: @escaping (Result<WeatherData, Error>) -> Void) {
        let urlString = "\(weatherURLtoday)&q=\(city)"
        performRequest(with: urlString, decodingType: WeatherData.self, completion: copmletion)
    }
    
    func fetchWeatherWeekData(city: String, completion: @escaping (Result<NextWeekData, Error>) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=91e5d58992af1530198417d1084df956"
        performRequest(with: urlString, decodingType: NextWeekData.self, completion: completion)
    }
    
    func fetchWeatherWithLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (Result<WeatherData, Error>) -> Void) {
        let urlString = "\(weatherURLtoday)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString, decodingType: WeatherData.self, completion: completion)
    }
    
    func fetchWeekWeatherWithLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (Result<NextWeekData, Error>) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?&lat=\(latitude)&lon=\(longitude)&appid=91e5d58992af1530198417d1084df956"
        performRequest(with: urlString, decodingType: NextWeekData.self, completion: completion)
    }
    
    func performRequest<T: Codable>(with urlString: String, decodingType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        if let url = URL(string: urlString) {
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else {
                    if let error = error {
                        completion(.failure(ServiceError.serviceError(error.localizedDescription)))
                        print(error)
                    } else {
                        completion(.failure(ServiceError.unknown()))
                    }
                    return
                }
                print(data)
                
                let decoder = JSONDecoder()
                
                if let successMessage = try? decoder.decode(T.self, from: data) {
                    completion(.success(successMessage))
                } else if let errorMessage = try? decoder.decode(ErrorResponse.self, from: data) {
                    completion(.failure(ServiceError.serviceError(errorMessage.error)))
                } else {
                    let responseString = String(data: data, encoding: .utf8) ?? "none"
                    completion(.failure(ServiceError.decodingError("Error parsing server response: \(responseString)")))
                }
            }.resume()
        }
    }
}
