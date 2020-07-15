//
//  RIMessageView.swift
//  RelevantInformerExample
//
//  Created by Rufat Mirza on 13.07.2020.
//  Copyright © 2020 Rufat Mirza. All rights reserved.
//

import UIKit

protocol TouchEventsDelegate: AnyObject {
  func touchesBegan(view: RIMessageView)
  func touchesEnded(view: RIMessageView)
}

final class RIMessageView: RIStyleView {
  
  private let attributes: RIAttributes
  private let contentView: UIView
  private let backgroundView: RIBackgroundView = .init()
  
  weak var delegate: TouchEventsDelegate!
    
  init(view: UIView, attributes: RIAttributes) {
    self.contentView = view
    self.attributes = attributes
    
    super.init(frame: UIScreen.main.bounds)
    addSubview(contentView)
    contentView.fillSuperview()
    
    prepareShadow()
    prepareBackground()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    backgroundView.applyFrameStyle(roundCorners: attributes.roundCorners, border: attributes.border)
  }
  
  private func prepareShadow() {
    switch attributes.shadow {
    case .active(with: let value):
      applyDropShadow(withOffset: value.offset,
                      opacity: value.opacity,
                      radius: value.radius,
                      color: value.color.color(for: traitCollection, mode: attributes.displayMode))
    case .none:
      removeDropShadow()
    }
  }
  
  private func prepareBackground() {
    let style = RIBackgroundView.Style(background: attributes.contentBackground, displayMode: attributes.displayMode)
    backgroundView.prepare(with: style)
    insertSubview(backgroundView, at: 0)
    backgroundView.fillSuperview()
  }
  
  override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    prepareShadow()
  }
}

// MARK: - UIResponder

extension RIMessageView {
  
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    delegate.touchesBegan(view: self)
  }

  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    delegate.touchesEnded(view: self)
  }

  override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    touchesEnded(touches, with: event)
  }
}
