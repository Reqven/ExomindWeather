//
//  WeatherImageView.swift
//  ExomindWeather
//
//  Created by Manu on 11/04/2022.
//

import UIKit

class WeatherImageView: UIImageView {

  init() {
    super.init(frame: .zero)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    NSLayoutConstraint.activate([
      widthAnchor.constraint(equalToConstant: 25).withPriority(999),
      heightAnchor.constraint(equalToConstant: 25).withPriority(999)
    ])
  }
}
