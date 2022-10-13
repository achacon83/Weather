//
//  ViewModel.swift
//  Weather
//
//  Created by Ariel Chacón on 13/10/2022.
//

import Foundation

struct WeatherTableViewCellViewModel {
    var title: String
    var subtitle: String
    
    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
}
