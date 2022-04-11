//
//  Weather.swift
//  ExomindWeather
//
//  Created by Manu on 11/04/2022.
//

import UIKit

struct Weather {
  let city: String
  let temperature: Double
  let icon: String?
  
  static func from(response: WeatherResponse) -> Weather {
    return Weather(city: response.name, temperature: response.main.temp, icon: response.weather.first?.icon)
  }
}
