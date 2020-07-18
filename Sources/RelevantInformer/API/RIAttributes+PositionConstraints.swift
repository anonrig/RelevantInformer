//
//  RIAttributes+Constraints.swift
//  RelevantInformerExample
//
//  Created by Rufat Mirza on 15.07.2020.
//  Copyright © 2020 Rufat Mirza. All rights reserved.
//

import UIKit

public extension RIAttributes {
  
  struct Constraints {
    
    public let keyboard: Keyboard
    public let size: Size
    
    public var distanceToKeyboard: CGFloat {
      guard case .connected(let distance) = keyboard else {
        return 0
      }
      return distance.toKeyboard
    }
    
    public var distanceToTop: CGFloat? {
      guard case .connected(let distance) = keyboard,
        let distanceToTop = distance.toTop else {
          return nil
      }
      return distanceToTop
    }
    
    public init(size: Size, keyboard: Keyboard) {
      self.size = size
      self.keyboard = keyboard
    }
    
    public static var floatingCard: Constraints {
      let size = Size(width: .offset(value: 20), height: .intrinsic)
      return Constraints(size: size, keyboard: .connected(distance: .default))
    }
    
    public static let `default` = Constraints.floatingCard
  }
}

// MARK: - Keyboard

public extension RIAttributes.Constraints {
  
  enum Keyboard {
    
    case connected(distance: Distance)
    case none
    
    public var isBound: Bool {
      switch self {
      case .connected:
        return true
      case .none:
        return false
      }
    }
  }
}

// MARK: - Distance

public extension RIAttributes.Constraints.Keyboard {
  
  struct Distance {
    
    public var toKeyboard: CGFloat
    public var toTop: CGFloat?
    
    public init(toKeyboard: CGFloat = 20, toTop: CGFloat? = nil) {
      self.toKeyboard = toKeyboard
      self.toTop = toTop
    }
    
    public static var `default` = Distance()
  }
}

// MARK: - Edge

public extension RIAttributes.Constraints {
  
  enum Edge {
    
    case ratio(value: CGFloat)
    
    case offset(value: CGFloat)
    
    case constant(value: CGFloat)
    
    case intrinsic
    
    public static var fill: Edge {
      return .offset(value: 0)
    }
  }
}

// MARK: - Size

public extension RIAttributes.Constraints {
  
  struct Size {
    
    public var width: Edge
    
    public var height: Edge
    
    public init(width: Edge, height: Edge) {
      self.width = width
      self.height = height
    }
  }
}
