//
//  RIAttributes+Interactions.swift
//  RelevantInformerExample
//
//  Created by Rufat Mirza on 13.07.2020.
//  Copyright © 2020 Rufat Mirza. All rights reserved.
//

import Foundation

public extension RIAttributes {
  
  struct Interaction {
  
    public var onScreen: Kind
    public var onContent: Kind
    
    init(onScreen: Kind = .dismiss, onContent: Kind = .ignore) {
      self.onScreen = onScreen
      self.onContent = onContent
    }
    
    static let `default` = Interaction()
  }
}

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
