//
//  OpenWeatherMapService.swift
//  Weather
//
//  Created by Ariel Chacón on 16/10/2022.
//

import Foundation
import Alamofire

struct OpenWeatherCurrent: Codable {
    let dt: UInt32
    let sunrise: UInt32
    let sunset: UInt32
    let temp: Double
    let feels_like: Double
    let pressure: Int
    let humidity: Int
}

struct OpenWeather: Codable {
    let lat: Double
    let lon: Double
    let timezone: String
    let current: OpenWeatherCurrent?
}

enum OpenWheatherResponse {
    case success(OpenWeather)
    case failed
}

class OpenWeatherMapService {
    let apiKey: String = "6f9d66cb76e5f4ca7a0595340dcac856"
    
    func requestCurrentWheather(latitude: Double, longitude: Double, completed: @escaping (_ response: OpenWheatherResponse) -> Void) {
        let exclude = "minutely,hourly,daily,alerts"
        let units = "metric"
        let url = "https://api.openweathermap.org/data/3.0/onecall?lat=\(latitude)&lon=\(longitude)&exclude=\(exclude)&units=\(units)&appid=\(apiKey)"
        AF.request(url, method: .get, encoding: JSONEncoding.default)
            .responseData { response in
                if response.error != nil {
                    completed(.failed)
                    return
                }
                guard
                    let dataFromService = response.data,
                    let model: OpenWeather = try? JSONDecoder().decode(OpenWeather.self, from: dataFromService) else {
                    
                    completed(.failed)
                    return
                }
                
                completed(.success(model))
                return
            }
    }
}
