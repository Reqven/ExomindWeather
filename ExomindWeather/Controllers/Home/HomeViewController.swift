//
//  ViewController.swift
//  ExomindWeather
//
//  Created by Manu on 11/04/2022.
//

import UIKit

class HomeViewController: UIViewController {
  
  //MARK: - Properties
  private let appView = AppView()
  private let button = RoundedButton()

  //MARK: - Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
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
    button.setTitle("Open", for: .normal)
    button.addTarget(self, action: #selector(onTouch), for: .touchUpInside)
    
    setupLayout()
  }
  
  private func setupLayout() {
    appView.translatesAutoresizingMaskIntoConstraints = false
    button.translatesAutoresizingMaskIntoConstraints = false
    view.addSubviews(appView, button)
    
    NSLayoutConstraint.activate([
      appView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      appView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
      appView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
      
      button.heightAnchor.constraint(equalToConstant: 50),
      button.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
      button.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
      button.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
    ])
  }
}
