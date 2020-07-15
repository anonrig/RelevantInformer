//
//  RITouchReceivingView.swift
//  RelevantInformerExample
//
//  Created by Rufat Mirza on 13.07.2020.
//  Copyright © 2020 Rufat Mirza. All rights reserved.
//

import UIKit

final class RITouchReceivingView: UIView {
  
  var isAbleToReceiveTouches = false
  
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    
    if isAbleToReceiveTouches {
      return super.hitTest(point, with: event)
    }
    
    if let view = super.hitTest(point, with: event), view != self {
      return view
    }
    
    return nil
  }
}

