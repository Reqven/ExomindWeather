//
//  TemperatureLabel.swift
//  ExomindWeather
//
//  Created by Manu on 11/04/2022.
//

import UIKit

class TemperatureLabel: UILabel {
  
  init() {
    super.init(frame: .zero)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    textColor = .secondaryLabel
    font = .preferredFont(forTextStyle: .callout)
    setContentHuggingPriority(.defaultHigh, for: .horizontal)
  }
}
