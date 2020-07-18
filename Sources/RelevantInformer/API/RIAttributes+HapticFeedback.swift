//
//  RIAttributes+HapticFeedback.swift
//  
//
//  Created by Yagiz Nizipli on 7/18/20.
//

import Foundation
import NotificationCenter

public extension RIAttributes {

  enum HapticFeedback {
    case none
    case light
    case medium
    case heavy

    @available(iOS 13.0, *)
    case soft

    @available(iOS 13.0, *)
    case rigid
    
    private var haptic: UIImpactFeedbackGenerator.FeedbackStyle? {
      switch self {
        case .none:
          return nil
        case .light:
          return .light
        case .medium:
          return .medium
        case .heavy:
          return .heavy
        case .soft:
          if #available(iOS 13.0, *) {
            return .soft
          } else {
            return nil
          }
        case .rigid:
          if #available(iOS 13.0, *) {
            return .rigid
          } else {
            return nil
          }
      }
    }
  }
}

// MARK: - Feedback Generator

extension RIAttributes.HapticFeedback {
  
  func generate() {
    if let style = self.haptic {
      UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
  }
}
