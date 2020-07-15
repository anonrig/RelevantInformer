//
//  RelevantInformer+Context.swift
//  RelevantInformerExample
//
//  Created by Rufat Mirza on 12.07.2020.
//  Copyright © 2020 Rufat Mirza. All rights reserved.
//

import UIKit

public extension RelevantInformer {
  
  struct Context: Equatable {
    
    public enum DisplayMethod {
      case override(removeRest: Bool)
      case enqueue
    }
    
    var content: RICompatible
    var viewController: UIViewController?
    var view: UIView!
    let attributes: RIAttributes
    let displayMethod: DisplayMethod
    let presentInsideKeyWindow: Bool
    
    public init(content: RICompatible,
         attributes: RIAttributes,
         displayMethod: DisplayMethod,
         presentInsideKeyWindow: Bool) {
      
      self.content = content
      
      if let viewController = content as? UIViewController {
        self.viewController = viewController
        self.view = viewController.view
      }
      
      if let view = content as? UIView {
        self.view = view
        self.viewController = nil
      }
      
      self.attributes = attributes
      self.displayMethod = displayMethod
      self.presentInsideKeyWindow = presentInsideKeyWindow
    }
    
    public static func == (lhs: Context, rhs: Context) -> Bool {
      return lhs.view === rhs.view
    }
  }
}
