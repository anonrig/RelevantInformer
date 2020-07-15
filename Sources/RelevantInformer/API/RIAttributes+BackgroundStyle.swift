//
//  BackgroundStyle.swift
//  RelevantInformerExample
//
//  Created by Rufat Mirza on 15.07.2020.
//  Copyright © 2020 Rufat Mirza. All rights reserved.
//

import UIKit

public extension RIAttributes {
  
  enum BackgroundStyle {
    
    case visualEffect(style: BlurStyle)
    case color(color: EKColor)
    case gradient(gradient: Gradient)
    case image(image: UIImage)
    case clear
  }
}

// MARK: - BlurStyle

extension RIAttributes.BackgroundStyle {
  
  public struct BlurStyle: Equatable {
        
    let light: UIBlurEffect.Style
    let dark: UIBlurEffect.Style
    
    public init(style: UIBlurEffect.Style) {
      self.light = style
      self.dark = style
    }
    
    public init(light: UIBlurEffect.Style, dark: UIBlurEffect.Style) {
      self.light = light
      self.dark = dark
    }
    
    /** Computes a proper `UIBlurEffect.Style` instance */
    public func blurStyle(for traits: UITraitCollection,
                          mode: RIAttributes.DisplayMode) -> UIBlurEffect.Style {
      switch mode {
      case .inferred:
        if #available(iOS 13, *) {
          switch traits.userInterfaceStyle {
          case .light, .unspecified:
            return light
          case .dark:
            return dark
          @unknown default:
            return light
          }
        }
        else {
          return light
        }
      case .light:
        return light
      case .dark:
        return dark
      }
    }
    
    public func blurEffect(for traits: UITraitCollection,
                           mode: RIAttributes.DisplayMode) -> UIBlurEffect {
      return UIBlurEffect(style: blurStyle(for: traits, mode: mode))
    }
    
    public static var extra: BlurStyle {
      return BlurStyle(light: .extraLight, dark: .dark)
    }
    
    public static var standard: BlurStyle {
      return BlurStyle(light: .light, dark: .dark)
    }
    
    public static var prominent: BlurStyle {
      return BlurStyle(light: .prominent, dark: .prominent)
    }

    public static var dark: BlurStyle {
      return BlurStyle(light: .dark, dark: .dark)
    }
  }
}

// MARK: - Gradient

extension RIAttributes.BackgroundStyle {
  
  public struct Gradient {
    
    public var colors: [EKColor]
    public var startPoint: CGPoint
    public var endPoint: CGPoint
    
    public init(colors: [EKColor],
                startPoint: CGPoint,
                endPoint: CGPoint) {
      self.colors = colors
      self.startPoint = startPoint
      self.endPoint = endPoint
    }
  }
}
