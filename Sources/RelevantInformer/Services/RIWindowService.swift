//
//  RIWindowService.swift
//  RelevantInformerExample
//
//  Created by Rufat Mirza on 4.07.2020.
//  Copyright © 2020 Rufat Mirza. All rights reserved.
//

import UIKit

final class RIWindowService {
  
  public static var shared: RIWindowService = .init()
  
  private var queue: RIQueue<RelevantInformer.Context> = .init()
  
  private var window: RIWindow!
  
  var root: RIRootViewController? {
    return window?.rootViewController as? RIRootViewController
  }
  
  func layoutIfNeeded() {
    window?.layoutIfNeeded()
  }
}

// MARK: - Presentation

extension RIWindowService {
  
  func display(context: RelevantInformer.Context) {
    
    switch context.displayMethod {
    case .override(let removeRest):
      
      if removeRest {
        queue.removeAll()
      }
      
      queue.insert(context, at: 0)
      
      if let manager = root?.contentManager {
        manager.close(userInitiated: false) { [weak self] in
          self?.update()
        }
      }
      else {
        update()
      }
      
    case .enqueue:
      queue.enqueueUnique(context)
      
      if queue.hasSingleElement {
        update()
      }
    }
  }
  
  private func update() {
    if let next = queue.peek() {
      show(context: next)
    }
    else {
      displayRollbackWindow()
    }
  }
  
  private func show(context: RelevantInformer.Context) {
    guard let root = prepare(for: context) else {
      return
    }
    
    root.prepare(with: context)
  }
  
  private func prepare(for context: RelevantInformer.Context) -> RIRootViewController? {
    let root = setupWindow()
    window.windowLevel = context.attributes.windowLevel.value
    
    if context.presentInsideKeyWindow {
      window.makeKeyAndVisible()
    }
    else {
      window.isHidden = false
    }
    return root
  }
  
  private func setupWindow() -> RIRootViewController {
    if window == nil {
      let root = RIRootViewController(with: self)
      window = RIWindow(with: root)
      return root
    }
    else {
      return root!
    }
  }
  
  private func displayRollbackWindow() {
    window = nil
    UIWindow.keyWindow?.makeKeyAndVisible()
  }
}

// MARK: - PresentationDelegate

extension RIWindowService: PresentationDelegate  {
  
  func rootNeedsUpdate() {
    queue.dequeue()
    update()
  }
  
  var isResponsiveToTouches: Bool {
    set {
      window.isAbleToReceiveTouches = newValue
    }
    get {
      return window.isAbleToReceiveTouches
    }
  }
}

// MARK: - Dismissal

extension RIWindowService {
  
  func dismiss(_ descriptor: RelevantInformer.DismissMethod, with completion: VoidCallback? = nil) {
    
    switch descriptor {
    case .displayed:
      root?.closeCurrentContext() { [weak self] in
        self?.queue.dequeue()
        self?.update()
      }
      
    case .specific(let item):
      
      if item === root?.contentManager?.context.content {
        root?.closeCurrentContext() { [weak self] in
          self?.queue.remove(item)
          self?.update()
        }
      }
      else {
        queue.remove(item)
      }
      
    case .enqueued:
      break // TODO: Add implementation
      
    case .all:
      queue.removeAll()
    }
  }
}

