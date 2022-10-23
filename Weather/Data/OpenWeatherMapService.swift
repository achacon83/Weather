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

struct OWCoordinate: Codable {
    let lon: Double
    let lat: Double
}

struct OWWeather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct OWMain: Codable {
    let temp: Float
    let feels_like: Float
    let temp_min: Float
    let temp_max: Float
    let pressure: Int
    let humidity: Int
//    let sea_level: Int
//    let grnd_level: Int
}

struct OpenWeather: Codable {
    let coord: OWCoordinate
    let weather: [OWWeather]
    let base: String
    let main: OWMain
    let name: String
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
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&exclude=\(exclude)&units=\(units)&appid=\(apiKey)"
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
