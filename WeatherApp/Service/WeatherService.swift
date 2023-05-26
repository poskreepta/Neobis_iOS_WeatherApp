//
//  WeatherService.swift
//  WeatherApp
//
//  Created by poskreepta on 25.05.23.
//

import Foundation

class WeatherService {
    
    let weatherURLtoday = "https://api.openweathermap.org/data/2.5/weather?appid=91e5d58992af1530198417d1084df956&&units=metric"
    
    static let shared = WeatherService()
    
    private init() {}
    
    func fetchWeatherData(city: String, copmletion: @escaping (Result<WeatherData, Error>) -> Void) {
        let urlString = "\(weatherURLtoday)&q=\(city)"
        performRequest(with: urlString, decodingType: WeatherData.self, completion: copmletion)
    }
    
    func fetchWeatherWeekData(city: String, completion: @escaping (Result<NextWeekWeatherData, Error>) -> Void) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=91e5d58992af1530198417d1084df956"
        performRequest(with: urlString, decodingType: NextWeekWeatherData.self, completion: completion)
    }
    
    func performRequest<T: Codable>(with urlString: String, decodingType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    let error = NSError(domain: "com.example.app", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                    completion(.failure(error))
                    return
                }
                
                do {
                    let decodedData = try self.decodeData(data, decodingType: decodingType)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
        }
    }
    
    private func decodeData<T: Codable>(_ data: Data, decodingType: T.Type) throws -> T {
        let decoder = JSONDecoder()
        let decodedData = try decoder.decode(decodingType, from: data)
        return decodedData
    }
}
