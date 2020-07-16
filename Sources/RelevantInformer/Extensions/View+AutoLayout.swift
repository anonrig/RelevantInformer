//
//  View+AutoLayout.swift
//  RelevantInformerExample
//
//  Created by Rufat Mirza on 4.07.2020.
//  Copyright © 2020 Rufat Mirza. All rights reserved.
//

import UIKit

extension UIView {
  
  func anchorTo(top: NSLayoutYAxisAnchor? = nil,
                leading: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                trailing: NSLayoutXAxisAnchor? = nil,
                
                topConstant: CGFloat = 0,
                leadingConstant: CGFloat = 0,
                bottomConstant: CGFloat = 0,
                trailingConstant: CGFloat = 0,
                
                defaultPadding: CGFloat = 0,
                
                widthConstant: CGFloat = 0,
                heightConstant: CGFloat = 0) {
    
    translatesAutoresizingMaskIntoConstraints = false
    
    anchorWithReturnAnchors(top: top,
                            leading: leading,
                            bottom: bottom,
                            trailing: trailing,
                            topConstant: (topConstant != 0) ? topConstant : defaultPadding,
                            leadingConstant: (leadingConstant != 0) ? leadingConstant : defaultPadding,
                            bottomConstant: (bottomConstant != 0) ? bottomConstant : defaultPadding,
                            trailingConstant: (trailingConstant != 0) ? trailingConstant : defaultPadding,
                            widthConstant: widthConstant,
                            heightConstant: heightConstant)
  }
  
  @discardableResult
  func anchorWithReturnAnchors(top: NSLayoutYAxisAnchor? = nil,
                               leading: NSLayoutXAxisAnchor? = nil,
                               bottom: NSLayoutYAxisAnchor? = nil,
                               trailing: NSLayoutXAxisAnchor? = nil,
                               topConstant: CGFloat = 0,
                               leadingConstant: CGFloat = 0,
                               bottomConstant: CGFloat = 0,
                               trailingConstant: CGFloat = 0,
                               widthConstant: CGFloat = 0,
                               heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
    
    translatesAutoresizingMaskIntoConstraints = false
    
    var anchors = [NSLayoutConstraint]()
    
    if let top = top {
      anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
    }
    
    if let leading = leading {
      anchors.append(leadingAnchor.constraint(equalTo: leading, constant: leadingConstant))
    }
    
    if let bottom = bottom {
      anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
    }
    
    if let trailing = trailing {
      anchors.append(trailingAnchor.constraint(equalTo: trailing, constant: -trailingConstant))
    }
    
    if widthConstant > 0 {
      anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
    }
    
    if heightConstant > 0 {
      anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
    }
    
    anchors.forEach({ $0.activate() })
    
    return anchors
  }
  
  func anchorCenterSuperview() {
    anchorCenterXToSuperview()
    anchorCenterYToSuperview()
  }
  
  func anchorCenterXToSuperview(constant: CGFloat = 0) {
    translatesAutoresizingMaskIntoConstraints = false
    if let anchor = superview?.centerXAnchor {
      centerXAnchor.constraint(equalTo: anchor, constant: constant).activate()
    }
  }
  
  func anchorCenterYToSuperview(constant: CGFloat = 0) {
    translatesAutoresizingMaskIntoConstraints = false
    if let anchor = superview?.centerYAnchor {
      centerYAnchor.constraint(equalTo: anchor, constant: constant).activate()
    }
  }
  
  func fillSuperview(withMargins margin: CGFloat = 0) {
    translatesAutoresizingMaskIntoConstraints = false
    if let superview = superview {
      leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: margin).activate()
      trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -margin).activate()
      topAnchor.constraint(equalTo: superview.topAnchor, constant: margin).activate()
      bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -margin).activate()
    }
  }
  
  func anchorToTop(topConstant: CGFloat = 0, sidePadding: CGFloat = 0) {
    translatesAutoresizingMaskIntoConstraints = false
    
    var anchors = [NSLayoutConstraint]()
    
    if let top = superview?.topAnchor {
      anchors.append(bottomAnchor.constraint(equalTo: top, constant: topConstant))
    }
    
    if let left = superview?.leftAnchor {
      anchors.append(leftAnchor.constraint(equalTo: left, constant: sidePadding))
    }
    
    if let right = superview?.rightAnchor {
      anchors.append(rightAnchor.constraint(equalTo: right, constant: -sidePadding))
    }
    
    anchors.forEach { $0.activate() }
  }
  
  func anchorToBottom(bottomConstant: CGFloat = 0, sidePadding: CGFloat = 0) {
    translatesAutoresizingMaskIntoConstraints = false
    
    var anchors = [NSLayoutConstraint]()
    
    if let left = superview?.leftAnchor {
      anchors.append(leftAnchor.constraint(equalTo: left, constant: sidePadding))
    }
    
    if let bottom = superview?.bottomAnchor {
      anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
    }
    
    if let right = superview?.rightAnchor {
      anchors.append(rightAnchor.constraint(equalTo: right, constant: -sidePadding))
    }
    
    anchors.forEach { $0.activate() }
  }
}

extension UIView {
  
  func constraint(_ edge: NSLayoutConstraint.Attribute,
                  constant: CGFloat = 0,
                  relation: NSLayoutConstraint.Relation = .equal,
                  toView: UIView,
                  to attribute: NSLayoutConstraint.Attribute,
                  ratio: CGFloat = 1.0,
                  priority: UILayoutPriority = .required) -> NSLayoutConstraint {
    
    if translatesAutoresizingMaskIntoConstraints {
      translatesAutoresizingMaskIntoConstraints = false
    }
    
    let constraint = NSLayoutConstraint(item: self,
                                        attribute: edge,
                                        relatedBy: relation,
                                        toItem: toView,
                                        attribute: attribute,
                                        multiplier: ratio,
                                        constant: constant).with(priority: priority)
    return constraint
  }
}
