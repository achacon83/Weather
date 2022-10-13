//
//  WeatherTableViewCell.swift
//  Wheather
//
//  Created by Ariel Chacón on 12/10/2022.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    func configure(viewModel: ViewModel) {
        var content = self.defaultContentConfiguration()
        content.text = viewModel.title
        content.secondaryText = viewModel.subtitle
        self.contentConfiguration = content
    }
}
