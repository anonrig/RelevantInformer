//
//  RIAttributes+PositionConstraints.swift
//  RelevantInformerExample
//
//  Created by Rufat Mirza on 15.07.2020.
//  Copyright © 2020 Rufat Mirza. All rights reserved.
//

import UIKit

public extension RIAttributes {
  
  /** Describes the frame of the entry. It's limitations, width and offset from the anchor (top / bottom of the screen) */
  struct PositionConstraints {
    
    /** The rotation attributes of the entry */
    public var rotation = Rotation()
    
    /** The entry can be bound to keyboard in case of appearance */
    public var keyboardRelation = KeyboardRelation.none
    
    /** The size of the entry */
    public var size: Size
    
    /** The maximum size of the entry */
    public var maxSize: Size
    
    /** The vertical offset from the top or bottom anchor */
    public var verticalOffset: CGFloat
    
    /** Can be used to display the content outside the safe area margins such as on the notch of the iPhone X or the status bar itself. */
    public var safeArea = SafeArea.empty(fillSafeArea: false)
    
    public var hasVerticalOffset: Bool {
      return verticalOffset > 0
    }
    
    public var offsetToKeyboard: CGFloat {
      guard case .bind(let offset) = keyboardRelation else {
        return 0
      }
      return offset.distanceFromKeyboard
    }
    
    public var offsetToTop: CGFloat? {
      guard case .bind(let offset) = keyboardRelation,
        let distance = offset.distanceToTop else {
        return nil
      }
      return distance
    }
    
    /** Returns a floating entry (float-like) */
    public static var float: PositionConstraints {
      return PositionConstraints(verticalOffset: 10, size: .init(width: .offset(value: 20), height: .intrinsic))
    }
    
    /** A full width entry (toast-like) */
    public static var fullWidth: PositionConstraints {
      return PositionConstraints(verticalOffset: 0, size: .sizeToWidth)
    }
    
    /** A full screen entry - fills the entire screen, modal-like */
    public static var fullScreen: PositionConstraints {
      return PositionConstraints(verticalOffset: 0, size: .screen)
    }
    
    public init(verticalOffset: CGFloat = 0, size: Size = .sizeToWidth, maxSize: Size = .intrinsic) {
      self.verticalOffset = verticalOffset
      self.size = size
      self.maxSize = maxSize
    }
  }
}

// MARK: - KeyboardRelation

public extension RIAttributes {

  enum KeyboardRelation {
    
    case bind(offset: Offset)
    case none
    
    public var isBound: Bool {
      switch self {
      case .bind:
        return true
      case .none:
        return false
      }
    }
  }
}

// MARK: - Offset

public extension RIAttributes.KeyboardRelation {
  
  struct Offset {
    
    public var distanceFromKeyboard: CGFloat
    public var distanceToTop: CGFloat?
    
    public init(bottom: CGFloat = 20, screenEdgeResistance: CGFloat? = nil) {
      self.distanceFromKeyboard = bottom
      self.distanceToTop = screenEdgeResistance
    }
    
    public static var `default` = Offset()
  }
}

// MARK: - SafeArea

public extension RIAttributes {
  
  enum SafeArea {
    
    /** Entry overrides safe area */
    case overridden
    
    /** The entry shows outs. But can optionally be colored */
    case empty(fillSafeArea: Bool)
    
    public var isOverridden: Bool {
      switch self {
      case .overridden:
        return true
      default:
        return false
      }
    }
  }
}


// MARK: - Edge

public extension RIAttributes {

  enum Edge {
    
    /** Ratio constraint to screen edge */
    case ratio(value: CGFloat)
    
    /** Offset from each edge of the screen */
    case offset(value: CGFloat)
    
    /** Constant edge length */
    case constant(value: CGFloat)
    
    /** Unspecified edge length */
    case intrinsic
    
    /** Edge totally filled */
    public static var fill: Edge {
      return .offset(value: 0)
    }
  }
}

// MARK: - Size

public extension RIAttributes {

  struct Size {
    
    /** Describes a width constraint */
    public var width: Edge
    
    /** Describes a height constraint */
    public var height: Edge
    
    /** Initializer */
    public init(width: Edge, height: Edge) {
      self.width = width
      self.height = height
    }
    
    /** The content's size. Entry's content view must have tight constraints */
    public static var intrinsic: Size {
      return Size(width: .intrinsic, height: .intrinsic)
    }
    
    /** The content's size. Entry's content view must have tight constraints */
    public static var sizeToWidth: Size {
      return Size(width: .offset(value: 0), height: .intrinsic)
    }
    
    /** Screen size, without horizontal or vertical offset */
    public static var screen: Size {
      return Size(width: .fill, height: .fill)
    }
  }
}

// MARK: - Rotation

public extension RIAttributes {

  struct Rotation {
    
    /** Attributes of supported interface orientations */
    public enum SupportedInterfaceOrientation {
      
      /** Uses standard supported interface orientation (target specification in general settings) */
      case standard
      
      /** Supports all orinetations */
      case all
    }
    
    /** Autorotate the entry along with the device orientation */
    public var isEnabled = true
    
    /** The screen autorotates with accordance to this option */
    public var supportedInterfaceOrientations = SupportedInterfaceOrientation.standard
    
    public init() {}
  }
}
