//
//  CityLabel.swift
//  ExomindWeather
//
//  Created by Manu on 11/04/2022.
//

import UIKit

class CityLabel: UILabel {
  
  init() {
    super.init(frame: .zero)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    textColor = .label
    font = .preferredFont(forTextStyle: .subheadline)
  }
}
