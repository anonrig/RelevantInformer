//
//  ViewController.swift
//  RelevantInformerExample
//
//  Created by Rufat Mirza on 16.07.2020.
//  Copyright © 2020 Relevant Fruit. All rights reserved.
//

import UIKit
import RelevantInformer

final class ViewController: UIViewController {
  
  private lazy var button: UIButton = {
    let button = UIButton(type: .system)
    button.addTarget(self, action: #selector(action), for: .touchUpInside)
    button.setTitle("Show message", for: .normal)
    return button
  }()
  
  private var counter: Int = 0
  
  private let exampleVC = ExampleViewController()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.addSubview(button)
    button.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
  
  @objc private func action() {
    var attributes = RIAttributes()
    attributes.screenBackground = .visualEffect(style: .prominent)
    attributes.roundCorners = .all(radius: 20)
    attributes.shadow = .active(with: .init(color: .black, opacity: 0.3, radius: 4, offset: .init(width: 0, height: 0)))
    attributes.contentBackground = .color(color: .init(.white))
    attributes.positionConstraints.keyboardRelation = .bind(offset: .init())
    
    attributes.animations.entrance = .init(
      translate: .init(duration: 0.7,
                       delay: 0,
                       spring: .init(damping: 0.7, initialVelocity: 0)),
      
      scale: .init(from: 0.7,
                   to: 1,
                   duration: 0.4,
                   delay: 0,
                   spring: .init(damping: 1, initialVelocity: 0)),
      
      fade: nil
    )
    
    attributes.displayDuration = .infinity
    attributes.interaction.onScreen = .ignore
    
    if counter > 0 {
      exampleVC.descriptionLabel.text = "\(counter)"
    }
    
    counter += 1
    
    let ratingPopup = RelevantInformer.Context(content: exampleVC, attributes: attributes, displayMethod: .override(removeRest: false), presentInsideKeyWindow: true)
    
    RelevantInformer.display(ratingPopup)
  }
}
