//
//  WeatherViewControllerTest.swift
//  WeatherTests
//
//  Created by Ariel Chacón on 13/10/2022.
//

import Foundation
import XCTest
@testable import Weather

class WeatherViewControllerTest: XCTestCase {
    func test_viewDidLoad_renderTableView() {
        let mockWeatherViewModel = MockWeatherViewModel(items: [
            MockWeatherItemViewModel(location: "Buenos Aires", temperature: "25 ºC"),
            MockWeatherItemViewModel(location: "La Plata", temperature: "29 ºC")
        ])
        let sut = WeatherViewController(viewModel: mockWeatherViewModel)
        _ = sut.view
        
        XCTAssertEqual(2, sut.tableView.numberOfRows(inSection: 0))
        let cell = sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? WeatherTableViewCell
        
        XCTAssertEqual("Buenos Aires", cell?.titleLabel.text)
        XCTAssertEqual("25 ºC", cell?.subtitleLabel.text)
    }
    
    func test_pullRefresh_refreshItemsInViewModel() {
        let mockWeatherViewModel = MockWeatherViewModel(items: [
            MockWeatherItemViewModel(location: "Buenos Aires", temperature: "25 ºC"),
            MockWeatherItemViewModel(location: "La Plata", temperature: "29 ºC")
        ])
        let sut = WeatherViewController(viewModel: mockWeatherViewModel)
        _ = sut.view

        //TODO: Can I simulate the tableView pull refresh?
        sut.refresh(sut.tableView)
        
        XCTAssertTrue(mockWeatherViewModel.refreshedItems)
    }
}

struct MockWeatherItemViewModel: WeatherItemViewModel {
    var location: String
    var temperature: String
    
    init(location: String, temperature: String) {
        self.location = location
        self.temperature = temperature
    }
}

class MockWeatherViewModel: WeatherViewModel {
    var items: [WeatherItemViewModel]
    var refreshedItems = false
    
    init(items: [WeatherItemViewModel]) {
        self.items = items
    }
    
    func refreshItems(callback: () -> Void) {
        refreshedItems = true
        callback()
    }
}
