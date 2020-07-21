//
//  RelevantInformer.swift
//  RelevantInformerExample
//
//  Created by Rufat Mirza on 4.07.2020.
//  Copyright © 2020 Rufat Mirza. All rights reserved.
//

import UIKit

public struct RIWrapper<Base> {
  let base: Base
  
  init(_ base: Base) {
    self.base = base
  }
}

public protocol RICompatible: AnyObject { }

public extension RICompatible {
  
  var ri: RIWrapper<Self> {
    get { return RIWrapper(self) }
    set { }
  }
}

extension UIView: RICompatible { }
extension UIViewController: RICompatible { }

public final class RelevantInformer {
  
  public static func display(_ context: Context) {
    RIWindowService.shared.display(context: context)
  }
  
  public static func dismiss(_ context: Context) {
    RIWindowService.shared.dismiss(.specific(context.content))
  }
  
  class func layoutIfNeeded() {
    safeSync {
      RIWindowService.shared.layoutIfNeeded()
    }
  }
}

// MARK: - Presentation

public extension RIWrapper where Base: RICompatible {
  
  func display(with attributes: RIAttributes,
               presentInsideKeyWindow: Bool = false,
               displayMethod: RelevantInformer.Context.DisplayMethod = .enqueue) {
    
    let context = RelevantInformer.Context(content: self.base,
                                           attributes: attributes,
                                           displayMethod: displayMethod,
                                           presentInsideKeyWindow: presentInsideKeyWindow)
    
    RIWindowService.shared.display(context: context)
  }
  
  func dismiss() {
    RIWindowService.shared.dismiss(.specific(self.base))
  }
}

// MARK: - Dismissal

extension RelevantInformer {
  
  public enum DismissMethod {
    
    case specific(_ content: RICompatible)
    case enqueued
    case all
    case displayed
  }
  
  public static func dismiss(_ descriptor: DismissMethod = .displayed,
                             with completion: VoidCallback? = nil) {
    RIWindowService.shared.dismiss(.displayed, with: completion)
  }
  
  public static func hideAll(with completion: VoidCallback? = nil) {
    RIWindowService.shared.dismiss(.all, with: completion)
  }
}

// MARK: - Content Caching

public extension RelevantInformer {
  
  struct RelevantInformerOptions {
    var autoCache: Bool = true
  }
}
