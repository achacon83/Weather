//
//  WeatherViewController.swift
//  Weather
//
//  Created by Ariel Chacón on 12/10/2022.
//

import UIKit

protocol WeatherItemViewModel {
    var location: String { get }
    var temperature: String { get }
}

protocol WeatherViewModel {
    var items: [WeatherItemViewModel] { get }
}

class WeatherViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: WeatherViewModel!
    
    convenience init(viewModel: WeatherViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeatherTableViewCell
        cell.configure(viewModel: ViewModel(title: item.location, subtitle: item.temperature))
        return cell;
    }
}
