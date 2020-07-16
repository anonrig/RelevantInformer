//
//  ExampleViewController.swift
//  RelevantInformerExample
//
//  Created by Rufat Mirza on 4.07.2020.
//  Copyright © 2020 Rufat Mirza. All rights reserved.
//

import UIKit

public class ExampleViewController: UIViewController {
    
  private let iconImageView: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "liveRemoval"))
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  public let titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .center
    label.text = "Lorem Ipsum"
    return label
  }()
  
  let descriptionLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .center
    label.text = "Would you like to try our Live Background Eraser Camera? You can also choose a photo from your camera roll."
    return label
  }()
  
  public let textField: UITextField = {
    let textField = UITextField()
    textField.text = "Lorem Ipsum"
    return textField
  }()
  
  private let button_1: UIButton = {
    let button = UIButton(type: .system)
    button.backgroundColor = UIColor(red: 241, green: 216, blue: 11, alpha: 1)
    button.layer.cornerRadius = 25
    button.translatesAutoresizingMaskIntoConstraints = false
    button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    button.setTitle("TRY LIVE BG ERASER CAMERA", for: .normal)
    return button
  }()
  
  private let button_2: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Choose from Camera Roll", for: .normal)
    return button
  }()
  
  public lazy var stackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [iconImageView, descriptionLabel, textField, button_1, button_2])
    stack.axis = .vertical
    stack.spacing = 10
    return stack
  }()
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .clear
    
    view.addSubview(stackView)
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
      stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16)
    ])
  }
}
