//
//  NSLayoutConstraints+Additions.swift
//  RelevantInformerExample
//
//  Created by Rufat Mirza on 7.07.2020.
//  Copyright © 2020 Rufat Mirza. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
  
  func with(priority: UILayoutPriority) -> NSLayoutConstraint {
    self.priority = priority
    return self
  }
  
  @discardableResult
  func activate() -> NSLayoutConstraint {
    self.isActive = true
    return self
  }

  @discardableResult
  func deactivate() -> NSLayoutConstraint {
    self.isActive = false
    return self
  }
}
