//
//  WeatherViewController.swift
//  ExomindWeather
//
//  Created by Manu on 11/04/2022.
//

import UIKit

class WeatherViewController: UIViewController {
  
  //MARK: - Properties
  private var tableView = UITableView(frame: .zero, style: .insetGrouped)
  private var viewModel = WeatherViewControllerViewModel()
  
  //MARK: - Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
    setupLayout()
  }
}


// MARK: - Setup
extension WeatherViewController {
  
  private func setup() {
    title = "Weather"
    view.backgroundColor = .systemBackground
    
    tableView.dataSource = viewModel
    tableView.rowHeight = UITableView.automaticDimension
    tableView.register(WeatherCell.self, forCellReuseIdentifier: WeatherCell.identifier)
  }
  
  private func setupLayout() {
    tableView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(tableView)
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])
  }
}
