//
//  WeatherTableViewCell.swift
//  Wheather
//
//  Created by Ariel Chacón on 12/10/2022.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
        
    func configure(viewModel: WeatherTableViewCellViewModel) {
        self.titleLabel.text = viewModel.title
        self.subtitleLabel.text = viewModel.subtitle
    }
}
