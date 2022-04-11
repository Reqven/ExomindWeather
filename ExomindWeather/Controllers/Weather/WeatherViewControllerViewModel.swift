//
//  WeatherViewControllerViewModel.swift
//  ExomindWeather
//
//  Created by Manu on 11/04/2022.
//

import UIKit

class WeatherViewControllerViewModel: NSObject {
  
  //MARK: - Properties
  private var data = ["Paris", "Lyon"]
  
}


//MARK: - UITableViewDataSource
extension WeatherViewControllerViewModel: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    cell.textLabel?.text = data[indexPath.row]
    cell.imageView?.image = UIImage(systemName: "sun.max.fill")
    return cell
  }
}
