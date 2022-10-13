//
//  WeatherViewController.swift
//  Weather
//
//  Created by Ariel Chacón on 12/10/2022.
//

import UIKit

class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    let items: [Weather] = [
        Weather(location: "Buenos Aires", temperature: "25 ºC"),
        Weather(location: "La Plata", temperature: "32 ºC")
    ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeatherTableViewCell
        cell.configure(viewModel: ViewModel(title: item.location, subtitle: item.temperature))
        return cell;
    }
}

