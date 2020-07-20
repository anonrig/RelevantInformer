//
//  RIAttributes.swift
//  RelevantInformerExample
//
//  Created by Rufat Mirza on 4.07.2020.
//  Copyright © 2020 Rufat Mirza. All rights reserved.
//

import Foundation
import NotificationCenter

public struct RIAttributes {
  
  public init() {}
  
  // MARK: - Display Attributes
  
  public var windowLevel = WindowLevel.default
    
  public var displayDuration = DisplayDuration.default
  
  public var constraints = Constraints.default
  
  // MARK: - User Interaction Attributes
  
  public var interaction = Interaction.default
    
  public var hapticFeedback: HapticFeedback = .none
  
  // MARK: - Theme & Style Attributes
  
  public var displayMode = DisplayMode.inferred
  
  public var contentBackground = BackgroundStyle.clear
  
  public var screenBackground = BackgroundStyle.clear
  
  public var shadow = Shadow.none
  
  public var roundCorners = RoundCorners.none
  
  public var border = Border.none
  
//    public var statusBar = StatusBar.inferred
  
  // MARK: - Animation Attributes
  
  public var animations = Animations.default
  
  // MARK: - Presetation
  
  public var presentation = PresentationStyle.slideUpToCenter
}

// MARK: - Presets

public extension RIAttributes {
  
  static var popup: RIAttributes {
    var attributes = RIAttributes()
    attributes.presentation = .slideUpToCenter
    attributes.constraints.verticalOffset = 0
    attributes.constraints = .floatingInAir(withSideMargins: 20)
    return attributes
  }
  
  static var notification: RIAttributes {
    var attributes = RIAttributes()
    attributes.presentation = .slideDownToTop
    attributes.constraints.verticalOffset = 0
    attributes.constraints = .floatingInAir(withSideMargins: 20)
    return attributes
  }
  
  static var solidBottomBar: RIAttributes {
    var attributes = RIAttributes()
    attributes.presentation = .slideUpToBottom
    attributes.constraints = .nonFloating
    attributes.interaction.isPanEnabled = true
    attributes.interaction.isStretchEnabled = false
    return attributes
  }
}

