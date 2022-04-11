//
//  UIStackView+Ext.swift
//  ExomindWeather
//
//  Created by Manu on 11/04/2022.
//

import UIKit

extension UIStackView {
  
  func addArrangedSubviews(_ views: UIView...) {
    for view in views { self.addArrangedSubview(view) }
  }
}
