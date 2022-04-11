//
//  WeatherCellViewModel.swift
//  ExomindWeather
//
//  Created by Manu on 11/04/2022.
//

import UIKit

class WeatherCellViewModel {
  
  //MARK: - Properties
  private var data: (String, Double)
  
  var city: String { data.0 }
  var temperature: String { "\(Int(data.1.rounded()))°" }
  
  //MARK: - Methods
  init(weather: (String, Double)) {
    data = weather
  }
}
