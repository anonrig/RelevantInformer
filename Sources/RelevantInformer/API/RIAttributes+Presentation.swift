//
//  RIAttributes+PresentationStyle.swift
//  RelevantInformerExample
//
//  Created by Rufat Mirza on 19.07.2020.
//  Copyright © 2020 Rufat Mirza. All rights reserved.
//

import Foundation

public extension RIAttributes {
  
  enum PresentationStyle {
    
    case slideUpToCenter
    case slideDownToTop
    case slideUpToBottom
    
    func animation(context: AnimationContext) -> Animator {
      switch self {
      case .slideUpToCenter:
        return BottomToCenterAnimation(context: context)
      case .slideDownToTop:
        return NotificationAnimation(context: context)
      case .slideUpToBottom:
        return BottomBarAnimation(context: context)
      }
    }
  }
}
