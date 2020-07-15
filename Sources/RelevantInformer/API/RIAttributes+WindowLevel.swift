//
//  RIAttributes+WindowLevel.swift
//  RelevantInformerExample
//
//  Created by Rufat Mirza on 13.07.2020.
//  Copyright © 2020 Rufat Mirza. All rights reserved.
//

import UIKit

public extension RIAttributes {
  
  enum WindowLevel {
    
    case aboveAlerts
    case aboveStatusBar
    case aboveApplicationWindow
    case custom(_ level: UIWindow.Level)
        
    public var value: UIWindow.Level {
      switch self {
      case .aboveAlerts:
        return .alert
      case .aboveStatusBar:
        return .statusBar
      case .aboveApplicationWindow:
        return .normal
      case .custom(let level):
        return level
      }
    }
    
    static let `default` = WindowLevel.aboveStatusBar
  }
}
