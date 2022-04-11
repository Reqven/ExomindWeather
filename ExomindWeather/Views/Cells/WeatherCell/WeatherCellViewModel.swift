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
  var delegate: WeatherCellViewModelDelegate?
  
  var image: UIImage?
  var city: String { data.city }
  var temperature: String { "\(Int(data.temperature.rounded()))°" }
  
  private var imageURL: URL? {
    guard let icon = self.data.icon else { return nil }
    return URL(string: "https://openweathermap.org/img/wn/\(icon)@2x.png")
  }
  
  //MARK: - Methods
  init(with weather: Weather) {
    data = weather
  }
  
  func loadImage() {
    guard let imageURL = imageURL else { return }
    Network.image(from: imageURL) { [weak self] result in
      guard let self = self else { return }
      
      switch(result) {
        case .failure(let error): print(error.localizedDescription)
        case .success(let image): DispatchQueue.main.async {
          self.image = image
          self.delegate?.didLoadImage()
        }
      }
    }
  }
}


//MARK: - Delegate Protocol
protocol WeatherCellViewModelDelegate {
  func didLoadImage()
}
