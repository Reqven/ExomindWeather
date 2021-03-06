//
//  Network.swift
//  ExomindWeather
//
//  Created by Manu on 11/04/2022.
//

import UIKit

class Network {
  
  //MARK: - Properties
  private static let cache = NSCache<NSString, UIImage>()
  
  //MARK: - Methods
  static func json<T: Codable>(from url: URL, as _: T.Type, _ completion: @escaping (Result<T, Error>) -> Void) {
    URLSession.shared.dataTask(with: url) { data, _, error in
      if let error = error {
        completion(.failure(error))
      } else if let data = data {
          do {
            let response = try JSONDecoder().decode(T.self, from: data)
            completion(.success(response))
          } catch let error {
            completion(.failure(error))
          }
      } else {
        completion(.failure(CError.invalidData))
      }
    }.resume()
  }
  
  static func image(from url: URL, _ completion: @escaping (Result<UIImage, Error>) -> Void) {
    let cacheKey = NSString(string: url.path)
    if let image = self.cache.object(forKey: cacheKey) {
      completion(.success(image))
      return
    }
    URLSession.shared.dataTask(with: url) { data, _, error in
      if let error = error {
        completion(.failure(error))
      } else if let data = data, let image = UIImage(data: data) {
        self.cache.setObject(image, forKey: cacheKey)
        completion(.success(image))
      } else {
        completion(.failure(CError.invalidImage))
      }
    }.resume()
  }
}
