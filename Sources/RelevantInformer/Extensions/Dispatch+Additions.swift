//
//  Dispatch+Additions.swift
//  RelevantInformerExample
//
//  Created by Rufat Mirza on 7.07.2020.
//  Copyright © 2020 Rufat Mirza. All rights reserved.
//

import Dispatch
import Foundation

public func after(on queue: DispatchQueue = .main, seconds: Double, execute: @escaping VoidCallback) {
  let time: DispatchTime = .now() + seconds
  queue.asyncAfter(deadline: time, execute: execute)
}

public func after(on queue: DispatchQueue = .main, seconds: Double, execute: DispatchWorkItem) {
  let time: DispatchTime = .now() + seconds
  queue.asyncAfter(deadline: time, execute: execute)
}

public func async(on queue: DispatchQueue = .main, execute: @escaping VoidCallback) {
  queue.async(execute: execute)
}

public extension DispatchQueue {
  static let userInitiated: DispatchQueue = .global(qos: .userInitiated)
}

public func safeSync(execute: VoidCallback) {
  if Thread.isMainThread {
    execute()
  }
  else {
    DispatchQueue.main.sync(execute: execute)
  }
}
