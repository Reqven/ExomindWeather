//
//  WeatherCellViewModel.swift
//  ExomindWeather
//
//  Created by Manu on 11/04/2022.
//

import UIKit

class WeatherCellViewModel {
  
  //MARK: - Properties
  private var data: Weather
  
  var city: String { data.city }
  var image: UIImage? { data.image }
  var temperature: String { "\(Int(data.temperature.rounded()))°" }
  
  //MARK: - Methods
  init(with weather: Weather) {
    data = weather
  }
}
