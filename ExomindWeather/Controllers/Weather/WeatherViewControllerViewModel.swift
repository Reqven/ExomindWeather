//
//  WeatherViewControllerViewModel.swift
//  ExomindWeather
//
//  Created by Manu on 11/04/2022.
//

import UIKit

class WeatherViewControllerViewModel: NSObject {
  
  //MARK: - Properties
  private var data = [("Paris", 10.0), ("Lyon", 15.0)]
  
}


//MARK: - UITableViewDataSource
extension WeatherViewControllerViewModel: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCell.identifier, for: indexPath) as! WeatherCell
    guard let item = data.elementAt(indexPath.row) else { return cell }
    
    let viewModel = WeatherCellViewModel(weather: item)
    cell.setup(with: viewModel)
    return cell
  }
}
