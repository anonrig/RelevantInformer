//
//  RIRootViewController.swift
//  RelevantInformerExample
//
//  Created by Rufat Mirza on 4.07.2020.
//  Copyright © 2020 Rufat Mirza. All rights reserved.
//

import UIKit

protocol PresentationDelegate: AnyObject {
  
  var isResponsiveToTouches: Bool { set get }
  func rootNeedsUpdate()
}

final class RIRootViewController: UIViewController {
    
  var contentManager: RIContentManager?

  private unowned let delegate: PresentationDelegate
  
  private let backgroundView: RIBackgroundView = .init()
    
  private var isResponsive = false {
    didSet {
      containerView.isAbleToReceiveTouches = isResponsive
      delegate.isResponsiveToTouches = isResponsive
    }
  }
  
  private let containerView: RITouchReceivingView = .init()

  public init(with delegate: PresentationDelegate) {
    self.delegate = delegate
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  deinit {
    print(#function + " " + String(describing: type(of: self)))
  }
  
  override public func loadView() {
    view = containerView
    view.insertSubview(backgroundView, at: 0)
    backgroundView.isUserInteractionEnabled = false
    backgroundView.fillSuperview()
  }
  
  func prepare(with context: RelevantInformer.Context) {
        
    contentManager = RIContentManager(with: context, container: self, delegate: self)
    contentManager?.display()
    
    isResponsive = context.attributes.interaction.onScreen.isResponsive
    
    if shouldAutorotate {
      UIViewController.attemptRotationToDeviceOrientation()
    }
  }
 
  func closeCurrentContext(completion: VoidCallback? = nil) {
    contentManager?.close(userInitiated: false) {
      completion?()
    }
    contentManager = nil
  }
}

// MARK: - ContentViewDelegate

extension RIRootViewController: ContentViewDelegate {
  
  func didCloseUserInitiated(view: RIMessageView) {
    contentManager = nil
    delegate.rootNeedsUpdate()
  }
  
  func changeToActive(with attributes: RIAttributes) {
    let style = RIBackgroundView.Style(background: attributes.screenBackground, displayMode: attributes.displayMode)
    changeBackground(to: style, duration: attributes.animations.entrance.totalDuration)
  }
  
  func changeToInactive(with attributes: RIAttributes) {
    let style = RIBackgroundView.Style(background: .clear, displayMode: attributes.displayMode)
    changeBackground(to: style, duration: attributes.animations.exit.totalDuration)
  }
  
  private func changeBackground(to style: RIBackgroundView.Style, duration: TimeInterval) {
    UIView.animate(withDuration: duration) {
      self.backgroundView.prepare(with: style)
    }
  }
}

// MARK: - UIResponder

extension RIRootViewController {
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    switch contentManager?.context.attributes.interaction.onScreen {
    case .dismiss:
      contentManager?.close()
      fallthrough
      
    default:
      // TODO: Custom actions can be added here.
      break
    }
  }
}
