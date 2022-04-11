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
  private var error = false
  private var currentTime = 0
  private let maxLoadingTime = 60
  private let cityFetchInterval = 10
  private let messageUpdateInterval = 6
  
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
        case .success(let response):
          self.data.append(Weather.from(response: response))
        case .failure(let error):
          self.error = true
          print(error.localizedDescription)
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
    currentTime += 1
    updateProgress()
    
    if messageUpdateNeeded {
      updateMessage()
      messageIndex += 1
    }
    if cityFetchNeeded {
      fetchCity()
      cityIndex += 1
    }
    if currentTime >= maxLoadingTime {
      timer?.invalidate()
      
      // Wait for progressBar animation to end
      Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { _ in
        self.delegate?.didFinishLoading(error: self.error)
      }
    }
  }
}


//MARK: - UITableViewDataSource - UITableViewDelegate
extension WeatherViewControllerViewModel: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return data.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: WeatherCell.identifier, for: indexPath) as! WeatherCell
    guard let weather = data.elementAt(indexPath.row) else { return cell }
    
    let viewModel = WeatherCellViewModel(with: weather)
    cell.configure(with: viewModel)
    return cell
  }
}


//MARK: - Delegate Protocol
protocol WeatherViewControllerViewModelDelegate {
  func didUpdateMessage(message: String)
  func didUpdateProgress(progress: Float)
  func didFinishLoading(error: Bool)
}
