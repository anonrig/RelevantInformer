//
//  RIAttributes+Animation.swift
//  RelevantInformerExample
//
//  Created by Rufat Mirza on 13.07.2020.
//  Copyright © 2020 Rufat Mirza. All rights reserved.
//

import UIKit

public protocol RIAnimation {
  var delay: TimeInterval { get set }
  var duration: TimeInterval { get set }
  var spring: RIAttributes.Animation.Spring? { get set }
}

public protocol EKRangeAnimation: RIAnimation {
  var start: CGFloat { get set }
  var end: CGFloat { get set }
}

public extension RIAttributes {

  struct Animations {
  
    public var entrance: Animation
    public var exit: Animation
    
    init(entrance: Animation = .translation, exit: Animation = .translation) {
      self.entrance = entrance
      self.exit = exit
    }
    
    static let `default` = Animations()
  }
  
  struct Animation {

    public init(translate: TranslateAnimation? = nil, scale: RangeAnimation? = nil, fade: RangeAnimation? = nil) {
      self.translate = translate
      self.scale = scale
      self.fade = fade
    }

    public var translate: TranslateAnimation?

    public var scale: RangeAnimation?

    public var fade: RangeAnimation?
    
    public var maxDelay: TimeInterval {
      return max(translate?.delay ?? 0, max(scale?.delay ?? 0, fade?.delay ?? 0))
    }

    public var maxDuration: TimeInterval {
      return max(translate?.duration ?? 0, max(scale?.duration ?? 0, fade?.duration ?? 0))
    }

    public var totalDuration: TimeInterval {
      return maxDelay + maxDuration
    }

    public static var translation: Animation {
      return Animation(translate: .init(duration: 0.3))
    }

    public static var none: Animation {
      return Animation()
    }
  }
}

// MARK: - Translate Animation

extension RIAttributes.Animation {

  public struct TranslateAnimation: RIAnimation {

    public var duration: TimeInterval

    public var delay: TimeInterval

    public var spring: Spring?

    public init(duration: TimeInterval,
                delay: TimeInterval = 0,
                spring: Spring? = nil)
    {
      self.duration = duration
      self.delay = delay
      self.spring = spring
    }
  }
}

// MARK: - Range Animation (RangeAnimation & Fade)

extension RIAttributes.Animation {

  public struct RangeAnimation: EKRangeAnimation {

    public var duration: TimeInterval

    public var delay: TimeInterval

    public var start: CGFloat

    public var end: CGFloat

    public var spring: Spring?

    public init(from start: CGFloat,
                to end: CGFloat,
                duration: TimeInterval,
                delay: TimeInterval = 0,
                spring: Spring? = nil)
    {
      self.start = start
      self.end = end
      self.delay = delay
      self.duration = duration
      self.spring = spring
    }
  }
}

// MARK: - Springing

extension RIAttributes.Animation {

  public struct Spring: Equatable {

    public var damping: CGFloat

    public var initialVelocity: CGFloat

    public init(damping: CGFloat, initialVelocity: CGFloat) {
      self.damping = damping
      self.initialVelocity = initialVelocity
    }
  }
}
