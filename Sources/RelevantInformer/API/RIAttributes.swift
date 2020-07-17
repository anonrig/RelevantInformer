//
//  RIAttributes.swift
//  RelevantInformerExample
//
//  Created by Rufat Mirza on 4.07.2020.
//  Copyright © 2020 Rufat Mirza. All rights reserved.
//

import Foundation

public struct RIAttributes {
  
  public init() {}
  
  // MARK: - Display Attributes
  
  public var windowLevel = WindowLevel.default
    
  public var displayDuration = DisplayDuration.default
  
  public var positionConstraints = PositionConstraints.default
  
  // MARK: - User Interaction Attributes
  
  public var interaction = Interaction.default
  
  public var scroll = Scroll.enabled(swipeable: true, pullbackAnimation: .jolt)
  
//    public var hapticFeedbackType = NotificationHapticFeedback.none
  
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
}
