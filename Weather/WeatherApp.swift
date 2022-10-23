//
//  Weather.swift
//  Weather
//
//  Created by Ariel Chacón on 13/10/2022.
//

import Foundation

struct WeatherItem: WeatherItemViewModel {
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

    
    fileprivate func addItem(latitude: Double, longitude: Double, callback: @escaping () -> Void) {
        weatherService.requestCurrentWheather(latitude: latitude, longitude: longitude) { [weak self] response in
            switch response {
            case let .success(value):
                
                let tempString = String(format: "%.2f ºC", value.main.temp)
                self?.add(item: WeatherItem(location: value.name, temperature:tempString))
                callback();
            case .failed:
                break
            }
        }
    }
    
    private func add(item: WeatherItemViewModel) {
        self.items.append(item)
    }
    
    func refreshItems(callback: @escaping () -> Void) {
        items.removeAll(keepingCapacity: true)
        //Combine
        addItem(latitude: 30.489772, longitude: -99.771335, callback: callback)
        addItem(latitude: -34.5760111, longitude: -58.5462005, callback: callback)
    }
}

