//
//  UIView+Ext.swift
//  ExomindWeather
//
//  Created by Manu on 11/04/2022.
//

import UIKit

extension UIView {
  
  func addSubviews(_ views: UIView...) {
    for view in views { self.addSubview(view) }
  }
}
