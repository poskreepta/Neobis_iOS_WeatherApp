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
    func fetchWeatherData(city: String)
}

class WeatherViewModel: WeatherViewModelType {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=91e5d58992af1530198417d1084df956&&units=metric"
  
    private(set) var model: WeatherModel = WeatherModel()
//
//    init(weatherModel: WeatherModel){
//        self.model = weatherModel
//    }
    
    func fetchWeatherData(city: String) {
        let urlString = "\(weatherURL)&q=\(city)"
        model.cityName = city
        perfomRequest(with: urlString)
    }
    
//    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
//        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
////        perfomRequest(with: urlString)
//    }
    
    func perfomRequest(with urlString: String) {
        //1. Create URL
        if let url = URL(string: urlString) {
            //2. Create a URLSession
            let session = URLSession(configuration: .default)
            //3. Give the session a task
            let task = session.dataTask(with: url) { [weak self] (data, response, error) in
                if let error = error {
                    print("Failed to fetch data", error)
                    return
                }
                if let safeData = data {
                    if let weather = self?.parseJSON(safeData) {
                        self?.didUpdateWeather(weather)
                    }
                }//чтобы сделать парсинг и вытащить данные по погоде
            }
            //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do { //if it has no error then try, if it has error then catch
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            model.conditionId = id
            model.cityName = name
            model.temprature = temp
//            let weatherModel = WeatherModel(conditionId: id, cityName: name, temprature: temp)
            return model
        } catch {
           print("error: \(error)") //if our data havent decoded succesfully we need to take errors out of weathermanager to weatherVC. we catch the errors
            return nil
        }
    }
    
    private func didUpdateWeather(_ weather: WeatherModel) {
        model = weather
        
    }

}
