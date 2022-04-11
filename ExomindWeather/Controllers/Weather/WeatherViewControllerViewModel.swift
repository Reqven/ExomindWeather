//
//  WeatherViewControllerViewModel.swift
//  ExomindWeather
//
//  Created by Manu on 11/04/2022.
//

import UIKit

class WeatherViewControllerViewModel: NSObject {
  
  //MARK: - Properties
  var delegate: WeatherViewControllerViewModelDelegate?
  
  private var timer: Timer?
  private var currentTime = 0
  private let maxLoadingTime = 15
  private let cityFetchInterval = 2
  private let messageUpdateInterval = 2
  
  private var data: [Weather] = []
  
  //MARK: Message
  private var messageUpdateNeeded: Bool {
    currentTime.isMultiple(of: messageUpdateInterval)
  }
  private var messageIndex = 0 {
    didSet {
      let indices = messages.indices
      guard !indices.contains(messageIndex) else { return }
      messageIndex = 0
    }
  }
  private let messages = [
    "Downloading data...",
    "A few more seconds...",
    "Almost done..."
  ]
  
  //MARK: City
  private var cityFetchNeeded: Bool {
    currentTime.isMultiple(of: cityFetchInterval)
  }
  private var cityIndex = 0
  private let cities = [
    "Rennes",
    "Paris",
    "Nantes",
    "Bordeaux",
    "Lyon"
  ]
  
  
  //MARK: - Methods
  private func updateProgress() {
    let progress = Double(currentTime) / Double(maxLoadingTime)
    delegate?.didUpdateProgress(progress: Float(progress))
  }
  
  private func updateMessage() {
    guard let message = messages.elementAt(messageIndex) else { return }
    delegate?.didUpdateMessage(message: message)
  }
  
  private func fetchCity() {
    guard let city = cities.elementAt(cityIndex) else { return }
    
    OpenWeatherAPI.getCurrentWeather(for: city, { [weak self] result in
      guard let self = self else { return }
  
      switch(result) {
        case .success(let response): self.data.append(Weather.from(response: response))
        case .failure(let error): print(error)
      }
    })
  }
  
  
  func start() {
    reset()
    updateMessage()
    messageIndex += 1
    let exec = #selector(execute)
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: exec, userInfo: nil, repeats: true)
  }
  
  func reset() {
    cityIndex = 0
    messageIndex = 0
    currentTime = 0
    data.removeAll()
    timer?.invalidate()
  }
  
  @objc private func execute() {
    self.currentTime += 1
    self.updateProgress()
    
    if self.messageUpdateNeeded {
      self.updateMessage()
      self.messageIndex += 1
    }
    if self.cityFetchNeeded {
      self.fetchCity()
      self.cityIndex += 1
    }
    if self.currentTime >= self.maxLoadingTime {
      self.timer?.invalidate()
      
      // Wait for progressBar animation to end
      Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
        self.delegate?.didFinishLoading()
      }
    }
  }
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


//MARK: - Delegate Protocol
protocol WeatherViewControllerViewModelDelegate {
  func didUpdateMessage(message: String)
  func didUpdateProgress(progress: Float)
  func didFinishLoading()
}
