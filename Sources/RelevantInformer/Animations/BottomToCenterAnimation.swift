//
//  BottomToCenterAnimation.swift
//  RelevantInformerExample
//
//  Created by Rufat Mirza on 9.07.2020.
//  Copyright © 2020 Rufat Mirza. All rights reserved.
//

import UIKit

final class BottomToCenterAnimation: Animator {
  
  var initialConstraint: NSLayoutConstraint!
  var targetConstraint: NSLayoutConstraint!
  internal var keyboardAnimation: KeyboardAnimation?
  
  private let child: UIView
  private let parent: UIView
  private let attributes: RIAttributes
  private let context: AnimationContext
    
  init(context: AnimationContext) {
    self.child = context.view
    self.parent = context.parent
    self.attributes = context.attributes
    self.context = context
    
    setup()
    setInitialState()
    setupKeyboardAnimation()
  }
  
  private func setup() {
    var offset: CGFloat = 0
    
    if case .offset(let value) = attributes.constraints.size.width {
      offset = value
    }

    child.anchorCenterXToSuperview()
    child.anchorTo(leading: parent.leadingAnchor,
                   trailing: parent.trailingAnchor,
                   leadingConstant: offset,
                   trailingConstant: offset)
    
    initialConstraint = child.constraint(.top, toView: parent, to: .bottom, priority: .must)
    targetConstraint = child.constraint(.centerY, toView: parent, to: .centerY)
  }
  
  private func setupKeyboardAnimation() {
    if attributes.constraints.keyboard.isBound {
      keyboardAnimation = KeyboardAnimation(context: context, targetConstraint: targetConstraint)
    }
  }
  
  private func setInitialState() {
    targetConstraint.deactivate()
    initialConstraint.activate()
    parent.layoutIfNeeded()
  }
  
  private func setTargetState() {
    targetConstraint.activate()
    initialConstraint.deactivate()
    parent.layoutIfNeeded()
  }
  
  func show(completion: VoidCallback? = nil) {
    setup(for: attributes.animations.entrance, curve: .curveEaseOut, translation: setTargetState, completion: completion)
  }
  
  func hide(completion: VoidCallback? = nil) {
    setup(for: attributes.animations.exit, curve: .curveEaseIn, translation: setInitialState, completion: completion)
  }
  
  func animateRubberBandPullback() {
    
    let animation: RIAttributes.Scroll.PullbackAnimation
    
    if case .enabled(swipeable: _, let pullbackAnimation) = attributes.scroll {
      animation = pullbackAnimation
    }
    else {
      animation = .easeOut
    }
    
    let options: UIView.AnimationOptions = [.allowUserInteraction, .beginFromCurrentState]
    
    let action = {
      self.targetConstraint?.constant = 0
      self.parent.layoutIfNeeded()
    }
    
    animate(with: animation, options: options, action: action)
  }
  
  private func setup(for animation: RIAttributes.Animation,
                     curve: UIView.AnimationOptions,
                     translation: @escaping VoidCallback,
                     completion: VoidCallback? = nil) {
    
    parent.layoutIfNeeded()
    
    let options: UIView.AnimationOptions = [curve, .beginFromCurrentState, .allowUserInteraction]
        
    var count = 0 {
      didSet {
        if count == 0 { completion?() }
      }
    }
    
    let animationCompletion = { count -= 1 }
    
    if let animation = animation.translate {
      count += 1
      animate(with: animation, options: options, action: translation, completion: animationCompletion)
    }
  
    if let animation = animation.fade {
      count += 1
      let preAction = { self.child.alpha = animation.start }
      let postAction = { self.child.alpha = animation.end }
      animate(with: animation, options: options, preAction: preAction, action: postAction, completion: animationCompletion)
    }
    
    if let animation = animation.scale {
      count += 1
      let preAction = { self.child.transform = CGAffineTransform(scaleX: animation.start, y: animation.start) }
      let postAction = { self.child.transform = CGAffineTransform(scaleX: animation.end, y: animation.end) }
      animate(with: animation, options: options, preAction: preAction, action: postAction, completion: animationCompletion)
    }
  }
  
  private func animate(with animation: RIAnimation,
                       usingSpringWithDamping: CGFloat? = nil,
                       initialSpringVelocity: CGFloat? = nil,
                       options: UIView.AnimationOptions,
                       preAction: @escaping VoidCallback = voidCallback(),
                       action: @escaping VoidCallback,
                       completion: VoidCallback? = nil) {
    preAction()
    
    let damping = usingSpringWithDamping ?? animation.spring?.damping ?? 1
    let velocity = initialSpringVelocity ?? animation.spring?.initialVelocity ?? 0
    
    UIView.animate(withDuration: animation.duration,
                   delay: animation.delay,
                   usingSpringWithDamping: damping,
                   initialSpringVelocity: velocity,
                   options: options,
                   animations: action) { _ in
                    completion?()
    }
  }
}
