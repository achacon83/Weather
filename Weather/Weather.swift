//
//  Weather.swift
//  Weather
//
//  Created by Ariel Chacón on 13/10/2022.
//

import Foundation

struct Weather {
    var location: String
    var temperature: String
    
    init(location: String, temperature: String) {
        self.location = location
        self.temperature = temperature
    }
}
