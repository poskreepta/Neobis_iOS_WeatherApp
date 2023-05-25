//
//  WeatherService.swift
//  WeatherApp
//
//  Created by poskreepta on 25.05.23.
//

import Foundation

class WeatherService {
    
    static let shared = WeatherService()
    
    private init() {}
    
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
                    let decodedData = try JSONDecoder().decode(decodingType, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        }
    }
}
