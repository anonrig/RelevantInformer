//
//  RIBackgroundView.swift
//  RelevantInformerExample
//
//  Created by Rufat Mirza on 13.07.2020.
//  Copyright © 2020 Rufat Mirza. All rights reserved.
//

import UIKit

final class RIBackgroundView: RIStyleView {
  
  struct Style {
    let background: RIAttributes.BackgroundStyle
    let displayMode: RIAttributes.DisplayMode
  }
  
  // TODO: Optimization point: Making these properties lazy.
  private let imageView: UIImageView = .init()
  private let visualEffectView: UIVisualEffectView = .init(effect: nil)
  private let gradientView: RIGradientView = .init()
  
  private var style: Style?
  
  init() {
    super.init(frame: UIScreen.main.bounds)
    
    addSubview(imageView)
    addSubview(visualEffectView)
    addSubview(gradientView)
    
    imageView.contentMode = .scaleAspectFill
    
    imageView.fillSuperview()
    visualEffectView.fillSuperview()
    gradientView.fillSuperview()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func prepare(with style: Style) {
    self.style = style

    var gradient: RIAttributes.BackgroundStyle.Gradient?
    var backgroundEffect: UIBlurEffect?
    var backgroundColor: UIColor = .clear
    var backgroundImage: UIImage?
    
    switch style.background {
    case .color(let color):
      backgroundColor = color.color(for: traitCollection, mode: style.displayMode)
    
    case .gradient(let value):
      gradient = value
    
    case .image(let image):
      backgroundImage = image
      
    case .visualEffect(let value):
      backgroundEffect = value.blurEffect(for: traitCollection, mode: style.displayMode)
    
    case .clear:
      break
    }
    
    gradientView.style = RIGradientView.Style(gradient: gradient, displayMode: style.displayMode)
    visualEffectView.effect = backgroundEffect
    layer.backgroundColor = backgroundColor.cgColor
    imageView.image = backgroundImage
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    guard let style = style else { return }
    
    switch style.background {
    case .color(color: let color):
      layer.backgroundColor = color.color(for: traitCollection, mode: style.displayMode).cgColor
    
    case .visualEffect(style: let value):
      visualEffectView.effect = value.blurEffect(for: traitCollection, mode: style.displayMode)
    
    default:
      break
    }
  }
}
