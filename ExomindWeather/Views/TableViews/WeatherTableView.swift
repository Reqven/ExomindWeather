//
//  WeatherTableView.swift
//  ExomindWeather
//
//  Created by Manu on 11/04/2022.
//

import UIKit

class WeatherTableView: UITableView {
  
  init() {
    super.init(frame: .zero, style: .insetGrouped)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    rowHeight = UITableView.automaticDimension
    translatesAutoresizingMaskIntoConstraints = false
    register(WeatherCell.self, forCellReuseIdentifier: WeatherCell.identifier)
  }
}
