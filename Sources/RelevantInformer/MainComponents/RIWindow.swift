//
//  RIWindow.swift
//  RelevantInformerExample
//
//  Created by Rufat Mirza on 13.07.2020.
//  Copyright © 2020 Rufat Mirza. All rights reserved.
//

import UIKit

final class RIWindow: UIWindow {
  
  var isAbleToReceiveTouches = false
  
  init(with rootVC: UIViewController) {
    
    if #available(iOS 13.0, *),
      let scene = UIApplication.shared.connectedScenes.first(where: { $0 is UIWindowScene } ) as? UIWindowScene {
      super.init(windowScene: scene)
    }
    else {
      super.init(frame: UIScreen.main.bounds)
    }
    backgroundColor = .clear
    rootViewController = rootVC
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    if isAbleToReceiveTouches {
      return super.hitTest(point, with: event)
    }
    
    guard let root = RIWindowService.shared.root else {
      return nil
    }
    
    if let view = root.view.hitTest(point, with: event) {
      return view
    }
    
    return nil
  }
}
