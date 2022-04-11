//
//  AppView.swift
//  ExomindWeather
//
//  Created by Manu on 11/04/2022.
//

import UIKit

class AppView: UIStackView {
  
  //MARK: - Properties
  private let verticalStackView = UIStackView()
  private let imageView = UIImageView()
  private let titleLabel = UILabel()
  private let descriptionLabel = UILabel()
  
  //MARK: - Methods
  init() {
    super.init(frame: .zero)
    setup()
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


//MARK: - Setup
extension AppView {
  
  private func setup() {
    alignment = .center
    spacing = 10
    
    verticalStackView.spacing = 5
    verticalStackView.axis = .vertical
    verticalStackView.addArrangedSubviews(titleLabel, descriptionLabel)
    
    imageView.contentMode = .scaleAspectFit
    imageView.image = UIImage(systemName: "cloud.sun.fill")
    
    titleLabel.text = "ExomindWeather"
    titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
    
    descriptionLabel.numberOfLines = 0
    descriptionLabel.textColor = .secondaryLabel
    descriptionLabel.font = UIFont.preferredFont(forTextStyle: .footnote)
    descriptionLabel.text = "Technical iOS test for the Exomind company. This app goes through a list of cities and fetch the weather from the OpenWeather API."
  
    addArrangedSubviews(imageView, verticalStackView)
    setupLayout()
  }
  
  private func setupLayout() {
    NSLayoutConstraint.activate([
      imageView.widthAnchor.constraint(equalToConstant: 50),
      imageView.heightAnchor.constraint(equalToConstant: 50)
    ])
  }
}
