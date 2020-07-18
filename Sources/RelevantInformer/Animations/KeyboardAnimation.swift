//
//  KeyboardAnimation.swift
//  RelevantInformerExample
//
//  Created by Rufat Mirza on 15.07.2020.
//  Copyright © 2020 Rufat Mirza. All rights reserved.
//

import UIKit

final class KeyboardAnimation {
  
  private var resistanceConstraint: NSLayoutConstraint!
  private var showingConstraint: NSLayoutConstraint!
  
  private let child: UIView
  private let parent: UIView
  private let attributes: RIAttributes
  private var targetConstraint: NSLayoutConstraint
  
  private let notifier = NotificationCenter.default
    
  init(context: AnimationContext, targetConstraint: NSLayoutConstraint) {
    self.child = context.view
    self.parent = context.parent
    self.attributes = context.attributes
    self.targetConstraint = targetConstraint
    
    setup()
    setupObservers()
  }
  
  private func setup() {
    if let distance = attributes.constraints.distanceToTop {
      resistanceConstraint = child.constraint(.top, constant: distance, relation: .greaterThanOrEqual,
                                              toView: parent, to: .top, priority: .defaultLow)
    }
    
    showingConstraint = child.constraint(.bottom, toView: parent, to: .bottom, priority: .defaultLow)
  }
  
  private func setupObservers() {
    guard attributes.constraints.keyboard.isBound else {
      return
    }
    
    notifier.addObserver(self, selector: #selector(keyboardWillShow(_:)),
                         name: UIResponder.keyboardWillShowNotification, object: nil)
    notifier.addObserver(self, selector: #selector(keyboardWillHide(_:)),
                         name: UIResponder.keyboardWillHideNotification, object: nil)
    notifier.addObserver(self, selector: #selector(keyboardWillChangeFrame(_:)),
                         name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
  }
  
  private func show(with userInfo: [AnyHashable: Any]?) {
    guard let properties = KeyboardAttributes(with: userInfo) else { return }
    showingConstraint.constant = -(properties.height + attributes.constraints.distanceToKeyboard)
    showingConstraint.activate()
    resistanceConstraint?.activate()
    targetConstraint.deactivate()
    animate(with: properties)
  }
  
  private func hide(with userInfo: [AnyHashable: Any]?) {
    guard let properties = KeyboardAttributes(with: userInfo) else { return }
    showingConstraint.deactivate()
    resistanceConstraint?.deactivate()
    targetConstraint.activate()
    animate(with: properties)
  }
  
  private func animate(with properties: KeyboardAttributes) {
      
    UIView.animate(withDuration: properties.duration, delay: 0, options: properties.curve, animations: {
      self.parent.layoutIfNeeded()
    })
  }
  
  @objc private func keyboardWillShow(_ notification: Notification) {
    guard child.containsFirstResponder else { return }
    show(with: notification.userInfo)
  }
  
  @objc private func keyboardWillHide(_ notification: Notification) {
    hide(with: notification.userInfo)
  }
  
  @objc private func keyboardWillChangeFrame(_ notification: Notification) {
    guard child.containsFirstResponder else { return }
    show(with: notification.userInfo)
  }
}

// MARK: - KeyboardAttributes

private struct KeyboardAttributes {
  
  let duration: TimeInterval
  let curve: UIView.AnimationOptions
  let begin: CGRect
  let end: CGRect
  
  init?(with rawValue: [AnyHashable: Any]?) {
    
    guard let rawValue = rawValue else {
      return nil
    }
    
    duration = rawValue[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
    curve = .init(rawValue: rawValue[UIResponder.keyboardAnimationCurveUserInfoKey] as! UInt)
    begin = (rawValue[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
    end = (rawValue[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
  }
  
  var height: CGFloat {
    return end.maxY - end.minY
  }
}
