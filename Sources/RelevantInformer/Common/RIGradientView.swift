//
//  RIGradientView.swift
//  RelevantInformerExample
//
//  Created by Rufat Mirza on 15.07.2020.
//  Copyright © 2020 Rufat Mirza. All rights reserved.
//

import UIKit

final class RIGradientView: UIView {
    
  private let gradientLayer = CAGradientLayer()
  
  var style: Style? {
    didSet {
      setupColor()
    }
  }
  
  init() {
    super.init(frame: .zero)
    layer.addSublayer(gradientLayer)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    gradientLayer.frame = bounds
  }
  
  private func setupColor() {
    guard let style = style else { return }
    
    gradientLayer.colors = style.gradient.colors.map {
      $0.color(for: traitCollection, mode: style.displayMode).cgColor
    }
    
    gradientLayer.startPoint = style.gradient.startPoint
    gradientLayer.endPoint = style.gradient.endPoint
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    setupColor()
  }
}

// MARK: - Style

extension RIGradientView {
  
  struct Style {
    let gradient: RIAttributes.BackgroundStyle.Gradient
    let displayMode: RIAttributes.DisplayMode
    
    init?(gradient: RIAttributes.BackgroundStyle.Gradient?,
          displayMode: RIAttributes.DisplayMode) {
      
      guard let gradient = gradient else { return nil }
      
      self.gradient = gradient
      self.displayMode = displayMode
    }
  }
}
