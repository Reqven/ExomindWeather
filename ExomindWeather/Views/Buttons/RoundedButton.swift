//
//  RoundedButton.swift
//  ExomindWeather
//
//  Created by Manu on 11/04/2022.
//

import UIKit

class RoundedButton: UIButton {
  
  init() {
    super.init(frame: .zero)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setup() {
    layer.cornerRadius = 10
    backgroundColor = tintColor
    setTitleColor(.white, for: .normal)
    titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
  }
}
