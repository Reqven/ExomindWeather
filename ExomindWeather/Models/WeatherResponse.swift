//
//  WeatherResponse.swift
//  ExomindWeather
//
//  Created by Manu on 11/04/2022.
//

import Foundation

struct WeatherResponse: Codable {
  
  struct WeatherItem: Codable {
    let main: String
    let icon: String
  }
  struct MainItem: Codable {
    let temp: Double
  }
  
  let weather: [WeatherItem]
  let main: MainItem
  let name: String
}
