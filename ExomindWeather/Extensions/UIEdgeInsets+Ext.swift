//
//  UIEdgeInsets+Ext.swift
//  ExomindWeather
//
//  Created by Manu on 11/04/2022.
//

import UIKit

extension UIEdgeInsets {
  
  init(all value: CGFloat) {
    self.init(top: value, left: value, bottom: value, right: value)
  }
  
  init(vertical: CGFloat, horizontal: CGFloat) {
    self.init(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
  }
}
