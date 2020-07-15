//
//  RIAttributes+WindowLevel.swift
//  RelevantInformerExample
//
//  Created by Rufat Mirza on 15.07.2020.
//  Copyright © 2020 Rufat Mirza. All rights reserved.
//

import Foundation
import CoreGraphics

public extension RIAttributes {
  
  enum Scroll {
        
    case disabled
    case edgeCrossingDisabled(swipeable: Bool)
    case enabled(swipeable: Bool, pullbackAnimation: PullbackAnimation)
    
    var isEnabled: Bool {
      switch self {
      case .disabled:
        return false
      default:
        return true
      }
    }
    
    var isSwipeable: Bool {
      switch self {
      case .edgeCrossingDisabled(swipeable: let swipeable), .enabled(swipeable: let swipeable, pullbackAnimation: _):
        return swipeable
      default:
        return false
      }
    }
    
    var isEdgeCrossingEnabled: Bool {
      switch self {
      case .edgeCrossingDisabled:
        return false
      default:
        return true
      }
    }
  }
}

extension RIAttributes.Scroll {
  
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
