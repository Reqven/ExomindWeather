//
//  WeatherViewControllerViewModel.swift
//  ExomindWeather
//
//  Created by Manu on 11/04/2022.
//

import UIKit

class WeatherViewControllerViewModel: NSObject {
  
  //MARK: - Properties
  private var data = [
    Weather(city: "Paris", temperature: 10, image: UIImage(systemName: "cloud.fill")),
    Weather(city: "Lyon", temperature: 15, image: UIImage(systemName: "sun.max.fill"))
  ]
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
