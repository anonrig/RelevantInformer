//
//  NotificationExampleViewController.swift
//  RelevantInformerExample
//
//  Created by Rufat Mirza on 19.07.2020.
//  Copyright © 2020 Relevant Fruit. All rights reserved.
//

import UIKit

public class NotificationExampleViewController: UIViewController {
    
  let descriptionLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .center
    label.text = "Would you like to try our Live Background Eraser Camera? You can also choose a photo from your camera roll."
    return label
  }()
  
  public lazy var stackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [descriptionLabel])
    stack.axis = .vertical
    stack.spacing = 10
    return stack
  }()
  
  public override func viewDidLoad() {
    super.viewDidLoad()
//    view.backgroundColor = .gray
    
    view.backgroundColor = UIColor(red: 242/255, green: 216/255, blue: 11/255, alpha: 1)
    
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
