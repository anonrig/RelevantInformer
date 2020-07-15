//
//  UIView+Additions.swift
//  RelevantInformerExample
//
//  Created by Rufat Mirza on 6.07.2020.
//  Copyright © 2020 Rufat Mirza. All rights reserved.
//

import UIKit

extension UIView {
  
  var containsFirstResponder: Bool {
    var contains = false
    for subview in subviews.reversed() where !contains {
      if subview.isFirstResponder {
        contains = true
      }
      else {
        contains = subview.containsFirstResponder
      }
    }
    return contains
  }
}
