//
//  WeatherViewController.swift
//  ExomindWeather
//
//  Created by Manu on 11/04/2022.
//

import UIKit

class WeatherViewController: UIViewController {
  
  //MARK: - Properties
  private let viewModel = WeatherViewControllerViewModel()
  private let tableView = WeatherTableView()
  private let loadingView = LoadingView()
  
  //MARK: - Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    tableView.tableFooterView = UIView(frame: loadingView.frame)
  }
}


// MARK: - Setup
extension WeatherViewController {
  
  private func setup() {
    title = "Weather"
    view.backgroundColor = .systemBackground
    
    viewModel.delegate = self
    tableView.dataSource = viewModel
    loadingView.progressLabel.text = "Downloading..."
    
    setupLayout()
    viewModel.fetch()
  }
  
  private func setupLayout() {
    view.addSubviews(tableView, loadingView)
    
    NSLayoutConstraint.activate([
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      
      loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    ])
  }
}


// MARK: - WeatherViewControllerViewModelDelegate
extension WeatherViewController: WeatherViewControllerViewModelDelegate {
  
  func didUpdateDataSource() {
    loadingView.progressBar.setProgress(1, animated: true)
    Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
      self.loadingView.progressLabel.text = "Done"
      self.tableView.reloadData()
    }
  }
}
