//
//  ViewController.swift
//  ExomindWeather
//
//  Created by Manu on 11/04/2022.
//

import UIKit

class HomeViewController: UIViewController {
  
  //MARK: - Properties
  private let button = UIButton()

  //MARK: - Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    setupLayout()
  }
  
  @objc private func onTouch(_ sender: UIButton?) {
    let controller = WeatherViewController()
    navigationController?.pushViewController(controller, animated: true)
  }
}


// MARK: - Setup
extension HomeViewController {
  
  private func setup() {
    title = "Home"
    view.backgroundColor = .systemBackground
    button.setTitle("Weather", for: .normal)
    button.setTitleColor(view.tintColor, for: .normal)
    button.addTarget(self, action: #selector(onTouch), for: .touchUpInside)
  }
  
  private func setupLayout() {
    button.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(button)
    
    NSLayoutConstraint.activate([
      button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
}
