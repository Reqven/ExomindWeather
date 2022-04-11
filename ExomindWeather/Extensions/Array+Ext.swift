//
//  Array+Ext.swift
//  ExomindWeather
//
//  Created by Manu on 11/04/2022.
//

import Foundation

extension Array {
  
  func elementAt(_ index: Int) -> Self.Element? {
    guard self.indices.contains(index) else { return nil }
    return self[index]
  }
}
