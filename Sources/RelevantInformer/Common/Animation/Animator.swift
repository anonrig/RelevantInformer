//
//  Animator.swift
//  RelevantInformerExample
//
//  Created by Rufat Mirza on 15.07.2020.
//  Copyright © 2020 Rufat Mirza. All rights reserved.
//

import UIKit

protocol Animator: AnyObject {
  
  var targetConstraint: NSLayoutConstraint! { get set }
  var keyboardAnimation: KeyboardAnimation? { get set }
  func show(completion: VoidCallback?)
  func hide(completion: VoidCallback?)
  func animateRubberBandPullback()
}
