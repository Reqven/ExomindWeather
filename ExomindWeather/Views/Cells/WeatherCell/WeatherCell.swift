//
//  WeatherCell.swift
//  ExomindWeather
//
//  Created by Manu on 11/04/2022.
//

import UIKit

class WeatherCell: UITableViewCell {
  
  //MARK: - Properties
  static let identifier = "WeatherCell"
  
  private var stackView = UIStackView()
  private var cityLabel = CityLabel()
  private var weatherImage = WeatherImageView()
  private var temperatureLabel = TemperatureLabel()
  
  private var viewModel: WeatherCellViewModel? {
    didSet { updateContent() }
  }
  
  //MARK: - Methods
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupLayout()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setup(with viewModel: WeatherCellViewModel) {
    self.viewModel = viewModel
  }
  
  private func updateContent() {
    guard let viewModel = viewModel else { return }
    cityLabel.text = viewModel.city
    temperatureLabel.text = viewModel.temperature
    
    guard let imageURL = viewModel.imageURL else { return }
    Network.image(from: imageURL) { [weak self] result in
      guard let self = self else { return }
      
      switch(result) {
        case .failure(let error): print(error.localizedDescription)
        case .success(let image): DispatchQueue.main.async {
          self.weatherImage.image = image
        }
      }
    }
  }
}


// MARK: - Setup
extension WeatherCell {
  
  private func setupLayout() {
    stackView.spacing = 8
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.addArrangedSubviews(weatherImage, cityLabel, temperatureLabel)
    
    contentView.addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
      stackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
      stackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
    ])
  }
}
