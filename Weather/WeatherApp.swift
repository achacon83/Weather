//
//  Weather.swift
//  Weather
//
//  Created by Ariel Chacón on 13/10/2022.
//

import Foundation

struct Weather: WeatherItemViewModel {
    let location: String
    let temperature: String
    
    init(location: String, temperature: String) {
        self.location = location
        self.temperature = temperature
    }
}

class WeatherApp: WeatherViewModel {
    // TODO: Create DI
    let weatherService = OpenWeatherMapService()
    
    var items: [WeatherItemViewModel] = []
    
    /*var items: [WeatherItemViewModel] = [
                WeatherItem(location: "San Luis", temperature: "18 ºC"),
                WeatherItem(location: "Córdoba", temperature: "21 ºC")
            ]*/

    
    fileprivate func addItem(location: String, latitude: Double, longitude: Double) {
        weatherService.requestCurrentWheather(latitude: latitude, longitude: longitude) { response in
            switch response {
            case let .success(value):
                print("done")
                let tempString = value.current.map { String($0.temp) } ?? ""
                self.items.append(Weather(location: location, temperature:tempString))
            case .failed:
                break
            }
        }
    }
    
    func refreshItems(callback: () -> Void) {
        items.removeAll(keepingCapacity: true)
        
        addItem(location: "Unknown", latitude: 30.489772, longitude: -99.771335)
    }
}

