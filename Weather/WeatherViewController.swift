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
    func refreshItems(callback: () -> Void)
}

class WeatherViewController: UIViewController, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    let refreshControl = UIRefreshControl()
    
    private var viewModel: WeatherViewModel!
    
    convenience init(viewModel: WeatherViewModel) {
        self.init()
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: "WeatherTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherTableViewCell")
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        viewModel.refreshItems {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
    }
}

extension WeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = viewModel.items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as! WeatherTableViewCell
        
        cell.configure(viewModel: WeatherItemTableViewCellViewModel(item: item))
        
        return cell;
    }
}

struct WeatherItemTableViewCellViewModel: WeatherTableViewCellViewModel {
    var title: String
    var subtitle: String
    
    init (item: WeatherItemViewModel) {
        self.init(title: item.location, subtitle: item.temperature)
    }
    
    init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
}
