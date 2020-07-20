//
//  RIAttributes+Interactions.swift
//  RelevantInformerExample
//
//  Created by Rufat Mirza on 13.07.2020.
//  Copyright © 2020 Rufat Mirza. All rights reserved.
//

import UIKit

public extension RIAttributes {
  
  struct Interaction {
  
    public var onScreen: Kind
    public var onContent: Kind
    
    public var isPanEnabled: Bool = true
    public var isStretchEnabled: Bool = true
    public var pullbackAnimation: PullbackAnimation = .jolt

    init(onScreen: Kind, onContent: Kind) {
      self.onScreen = onScreen
      self.onContent = onContent
    }
    
    static let `default` = Interaction(onScreen: .dismiss, onContent: .forwardToLowerWindow)
  }
}

// MARK: - Kind

public extension RIAttributes.Interaction {
  
  /** The default event that happens as the user interacts */
  enum Kind {
    
    /** Ignores the interaction */
    case ignore
    
    /** Delays dismissing by the display duration */
    case delayExit
    
    /** Dismisses immediately */
    case dismiss
    
    /** Touches are forwarded to the lower window (In most cases it would be the application main window that will handle it */
    case forwardToLowerWindow
    
    var isResponsive: Bool {
      switch self {
      case .forwardToLowerWindow:
        return false
      default:
        return true
      }
    }
    
    var isDelayExit: Bool {
      switch self {
      case .delayExit:
        return true
      default:
        return false
      }
    }
  }
}

// MARK: - PullbackAnimation

extension RIAttributes.Interaction {
  
  public struct PullbackAnimation: RIAnimation {
    
    public var delay: TimeInterval
    public var duration: TimeInterval
    public var spring: RIAttributes.Animation.Spring?

    public init(duration: TimeInterval, damping: CGFloat, initialSpringVelocity: CGFloat) {
      self.delay = 0
      self.duration = duration
      self.spring = .init(damping: damping, initialVelocity: initialSpringVelocity)
    }
    
    public static var jolt: PullbackAnimation {
      return PullbackAnimation(duration: 0.5, damping: 0.3, initialSpringVelocity: 10)
    }
    
    public static var easeOut: PullbackAnimation {
      return PullbackAnimation(duration: 0.3, damping: 1, initialSpringVelocity: 10)
    }
  }
}
