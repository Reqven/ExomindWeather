//
//  NSLayoutConstraint+Ext.swift
//  ExomindWeather
//
//  Created by Manu on 11/04/2022.
//

import UIKit

extension NSLayoutConstraint {
  
  func withPriority(_ rawValue: Float) -> Self {
    self.priority = UILayoutPriority(rawValue: rawValue)
    return self
  }
}
