//
//  OpenWeatherAPI.swift
//  ExomindWeather
//
//  Created by Manu on 11/04/2022.
//

import Foundation

class OpenWeatherAPI {
  
  //MARK: - Properties
  private static let baseUrl = "https://api.openweathermap.org/data/2.5"
  
  //MARK: - Methods
  static func getCurrentWeather(for city: String, _ completion: @escaping (Result<WeatherResponse, Error>) -> Void) {
    let endpoint = "weather"
    let parameters = [
      "q": city,
      "units": "metric",
      "appid": "13e894e804053de91066a9653e38f091"
    ]
    
    guard var components = URLComponents(string: self.baseUrl) else { fatalError() }
    components.queryItems = parameters.map { URLQueryItem(name: $0, value: $1) }
    guard var url = components.url else { return }
    url.appendPathComponent(endpoint)
      
    Network.json(from: url, as: WeatherResponse.self, completion)
  }
}
