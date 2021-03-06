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
  
  @objc private func onRestart(_ sender: UIButton?) {
    loadingView.progressBar.setProgress(0, animated: false)
    loadingView.isLoading = true
    viewModel.start()
    tableView.reloadData()
  }
}


// MARK: - Setup
extension WeatherViewController {
  
  private func setup() {
    title = "Weather"
    view.backgroundColor = .systemBackground
    
    viewModel.delegate = self
    tableView.dataSource = viewModel
    tableView.delegate = viewModel
    loadingView.restartButton.addTarget(self, action: #selector(onRestart), for: .touchUpInside)
    
    setupLayout()
    viewModel.start()
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
  
  func didUpdateMessage(message: String) {
    loadingView.progressLabel.text = message
  }
  
  func didUpdateProgress(progress: Float) {
    loadingView.progressBar.setProgress(progress, animated: true)
  }
  
  func didFinishLoading(error: Bool) {
    tableView.reloadData()
    loadingView.isLoading = false
    
    if error {
      presentAlert(title: "Error", message: """
        An error occured when fetching one or more cities from the API.
        The TableView might be incomplete. Check the logs for more information.
      """)
    }
  }
}
