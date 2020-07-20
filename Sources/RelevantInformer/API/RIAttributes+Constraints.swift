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
    
    public var size: Size
    public let keyboard: Keyboard = .connected(distance: .default)
    public var verticalOffset: CGFloat = 0
    
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
      
    private init(size: Size) {
      self.size = size
    }
    
    public static func floatingInAir(withSideMargins margin: CGFloat) -> Constraints {
      let size = Size(width: .margin(value: margin), height: .intrinsic)
      return Constraints(size: size)
    }
    
    public static var floatingOnEdges: Constraints {
      let size = Size(width: .margin(value: 0), height: .intrinsic)
      return Constraints(size: size)
    }
    
    public static var nonFloating: Constraints {
      let size = Size(width: .margin(value: 0), height: .intrinsic)
      return Constraints(size: size)
    }
    
    public static let `default` = Constraints.floatingInAir(withSideMargins: 20)
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
    case margin(value: CGFloat)
    case constant(value: CGFloat)
    case intrinsic
    
    public static var fill: Edge {
      return .margin(value: 0)
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
    
    public var sideMargin: CGFloat {
      get {
        guard case .margin(let value) = width else {
          return 0
        }
        return value
      }
      set {
        width = .margin(value: newValue)
      }
    }
  }
}
