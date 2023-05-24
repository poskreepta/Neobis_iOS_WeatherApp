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
    var modelDidChange: (() -> Void)? {get set}
    func fetchWeatherData(city: String)
    func fetchWeatherWeekData(city: String)
}

class WeatherViewModel: WeatherViewModelType {
    
    var modelDidChange: (() -> Void)?
    
    private(set) var model: WeatherModel = WeatherModel()
    
    let weatherURLtoday = "https://api.openweathermap.org/data/2.5/weather?appid=91e5d58992af1530198417d1084df956&&units=metric"
    
    func fetchWeatherData(city: String) {
        let urlString = "\(weatherURLtoday)&q=\(city)"
        model.cityName = city
        performRequest(with: urlString, decodingType: WeatherData.self) { [weak self] result in
            switch result {
            case .success(let weatherData):
                self?.updateModel(with: weatherData)
            case .failure(let error):
                print("Failed to fetch data:", error)
            }
        }
    }
    
    func fetchWeatherWeekData(city: String) {
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=91e5d58992af1530198417d1084df956"
        model.cityName = city
        performRequest(with: urlString, decodingType: NextWeekWeatherData.self) { [weak self] result in
            switch result {
            case .success(let nextWeekWeatherData):
                self?.updateModel(with: nextWeekWeatherData)
            case .failure(let error):
                print("Failed to fetch data:", error)
            }
        }
    }
    
    private func performRequest<T: Codable>(with urlString: String, decodingType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
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
    
    private func updateModel(with weatherData: WeatherData) {
        model.conditionId = weatherData.weather[0].id
        model.temprature = weatherData.main.temp
        model.cityName = weatherData.name
        model.humidity = weatherData.main.humidity
        model.windStatus = weatherData.wind.speed
        model.airPressure = weatherData.main.pressure
        model.visibility = weatherData.visibility
        model.country = weatherData.sys.country
        
        print(model.country)
        
        modelDidChange?()
    }
    
    private func updateModel(with nextWeekWeatherData: NextWeekWeatherData) {
        model.temp1 = nextWeekWeatherData.list[1].main.temp
        print(model.temp1)
        model.temp2 = nextWeekWeatherData.list[5].main.temp
        model.temp3 = nextWeekWeatherData.list[10].main.temp
        model.temp4 = nextWeekWeatherData.list[15].main.temp
        model.temp5 = nextWeekWeatherData.list[20].main.temp
        modelDidChange?()

    }
}

//    let temp1 = decodedDataWeek.list[1].main.temp
//    let temp2 = decodedDataWeek.list[8].main.temp
//    let temp3 = decodedDataWeek.list[16].main.temp
//    let temp4 = decodedDataWeek.list[24].main.temp
//    let temp5 = decodedDataWeek.list[28].main.temp
//    model.conditionId = id
//    model.cityName = cityName
//    model.temprature = temp
//    model.humidity = humidity
//    model.windStatus = windSpeed
//    model.airPressure = airPressure
//    model.visibility = visibility
//    model.country = country
//    model.temp1 = temp1
//    model.temp2 = temp2
//    model.temp3 = temp3
//    model.temp4 = temp4
//    model.temp5 = temp5
//















//    
//    
//    func fetchWeatherData(city: String) {
//        let urlString = "\(weatherURLtoday)&q=\(city)"
//        model.cityName = city
//        perfomRequest(with: urlString)
//    }
//    
//    func fetchWeatherWeekData(city: String) {
//        let urlString = "https://api.openweathermap.org/data/2.5/forecast?q=\(city)&appid=91e5d58992af1530198417d1084df956"
//        model.cityName = city
//        perfomRequest(with: urlString)
//    }
//    
//    func perfomRequest(with urlString: String) {
//        //1. Create URL
//        if let url = URL(string: urlString) {
//            //2. Create a URLSession
//            let session = URLSession(configuration: .default)
//            //3. Give the session a task
//            let task = session.dataTask(with: url) { [weak self] (data, response, error) in
//                if let error = error {
//                    print("Failed to fetch data", error)
//                    return
//                }
//                if let safeData = data {
//                    if let weather = self?.parseJSON(safeData) {
//                        self?.didUpdateWeather(weather)
//                    }
//                }//чтобы сделать парсинг и вытащить данные по погоде
//            }
//            //4. Start the task
//            task.resume()
//        }
//    }
//    
//    func parseJSON(_ weatherData: Data) -> WeatherModel? {
//        let decoder = JSONDecoder()
//        do { //if it has no error then try, if it has error then catch
//            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
//            let decodedDataWeek = try decoder.decode(NextWeekWeatherData.self, from: weatherData)
//            let id = decodedData.weather[0].id
//            let temp = decodedData.main.temp
//            let cityName = decodedData.name
//            let windSpeed = decodedData.wind.speed
//            let airPressure = decodedData.main.pressure
//            let humidity = decodedData.main.humidity
//            let visibility = decodedData.visibility
//            let country = decodedData.sys.country
//            let temp1 = decodedDataWeek.list[1].main.temp
//            let temp2 = decodedDataWeek.list[8].main.temp
//            let temp3 = decodedDataWeek.list[16].main.temp
//            let temp4 = decodedDataWeek.list[24].main.temp
//            let temp5 = decodedDataWeek.list[28].main.temp
//            model.conditionId = id
//            model.cityName = cityName
//            model.temprature = temp
//            model.humidity = humidity
//            model.windStatus = windSpeed
//            model.airPressure = airPressure
//            model.visibility = visibility
//            model.country = country
//            model.temp1 = temp1
//            model.temp2 = temp2
//            model.temp3 = temp3
//            model.temp4 = temp4
//            model.temp5 = temp5
//        
//           
////            let weatherModel = WeatherModel(conditionId: id, cityName: name, temprature: temp)
//            return model
//        } catch {
//           print("error: \(error)") //if our data havent decoded succesfully we need to take errors out of weathermanager to weatherVC. we catch the errors
//            return nil
//        }
//    }
//    
//    
//    
//    private func didUpdateWeather(_ weather: WeatherModel) {
//        model = weather
//        modelDidChange?()
//        
//    }


