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
  var temperature: String { "\(Int(data.temperature.rounded()))°" }
  
  var imageURL: URL? {
    guard let icon = self.data.icon else { return nil }
    return URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")
  }
  
  //MARK: - Methods
  init(with weather: Weather) {
    data = weather
  }
}
