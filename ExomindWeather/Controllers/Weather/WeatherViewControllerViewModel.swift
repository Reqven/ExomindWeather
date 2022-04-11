//
//  WeatherViewControllerViewModel.swift
//  ExomindWeather
//
//  Created by Manu on 11/04/2022.
//

import UIKit

class WeatherViewControllerViewModel: NSObject {
  
  //MARK: - Properties
  var delegate: WeatherViewControllerViewModelDelegate?
  
  private var data = [
    Weather(city: "Paris", temperature: 10, icon: "01d"),
    Weather(city: "Lyon", temperature: 15, icon: "01d")
  ]
  
  //MARK: - Methods
  func fetch() {
    OpenWeatherAPI.getCurrentWeather(for: "Bordeaux", { [weak self] result in
      guard let self = self else { return }
      
      switch(result) {
        case .failure(let error): print(error)
        case .success(let response):
          self.data.append(Weather.from(response: response))
          DispatchQueue.main.async { self.delegate?.didUpdateDataSource() }
      }
    })
  }
}


//MARK: - UITableViewDataSource
extension WeatherViewControllerViewModel: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCell.identifier, for: indexPath) as! WeatherCell
    guard let weather = data.elementAt(indexPath.row) else { return cell }
    
    let viewModel = WeatherCellViewModel(with: weather)
    cell.setup(with: viewModel)
    return cell
  }
}


//MARK: - Delegate Protocol
protocol WeatherViewControllerViewModelDelegate {
  func didUpdateDataSource()
}
