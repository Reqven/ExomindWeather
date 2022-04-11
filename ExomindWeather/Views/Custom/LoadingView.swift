//
//  LoadingView.swift
//  ExomindWeather
//
//  Created by Manu on 11/04/2022.
//

import UIKit

class LoadingView: UIView {
  
  //MARK: - Properties
  var isLoading = true {
    didSet { updateLayout() }
  }
  
  private let stackView: UIStackView = {
    let stack = UIStackView()
    stack.spacing = 8
    stack.axis = .vertical
    stack.distribution = .equalSpacing
    stack.translatesAutoresizingMaskIntoConstraints = false
    return stack
  }()
  
  private let blurEffect: UIVisualEffectView = {
    let blur = UIBlurEffect(style: .systemChromeMaterial)
    let effect = UIVisualEffectView(effect: blur)
    effect.layer.shadowOpacity = 1
    effect.layer.shadowRadius = 0
    effect.layer.shadowColor = UIColor.systemGray3.cgColor
    effect.layer.shadowOffset = CGSize(width: 0, height: -0.5)
    effect.translatesAutoresizingMaskIntoConstraints = false
    return effect
  }()
  
  let progressLabel: UILabel = {
    var label = UILabel()
    label.textAlignment = .center
    return label
  }()
  
  let progressBar: UIProgressView = {
    let progress = UIProgressView()
    progress.clipsToBounds = true
    progress.layer.cornerRadius = 1.5
    return progress
  }()
  
  let restartButton: UIButton = {
    var button = RoundedButton()
    button.setTitle("Restart", for: .normal)
    button.translatesAutoresizingMaskIntoConstraints = false
    return button
  }()
  
  //MARK: - Methods
  init() {
    super.init(frame: .zero)
    setup()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func updateLayout() {
    stackView.isHidden = !isLoading
    restartButton.isHidden = isLoading
  }
}


//MARK: - Setup
extension LoadingView {
  
  private func setup() {
    setupLayout()
    updateLayout()
  }
  
  private func setupLayout() {
    translatesAutoresizingMaskIntoConstraints = false
    layoutMargins = UIEdgeInsets(vertical: 10, horizontal: 16)
    
    stackView.addArrangedSubviews(progressLabel, progressBar)
    addSubviews(blurEffect, stackView, restartButton)
    
    NSLayoutConstraint.activate([
      blurEffect.leadingAnchor.constraint(equalTo: leadingAnchor),
      blurEffect.trailingAnchor.constraint(equalTo: trailingAnchor),
      blurEffect.topAnchor.constraint(equalTo: topAnchor),
      blurEffect.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      stackView.heightAnchor.constraint(equalToConstant: 45),
      progressBar.heightAnchor.constraint(equalToConstant: 5),
      restartButton.heightAnchor.constraint(equalToConstant: 45),
      
      stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
      stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
      stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
      stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
      
      restartButton.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
      restartButton.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
      restartButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
      restartButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
    ])
  }
}
