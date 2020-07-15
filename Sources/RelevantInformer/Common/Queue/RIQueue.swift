//
//  RIQueue.swift
//  RelevantInformerExample
//
//  Created by Rufat Mirza on 13.07.2020.
//  Copyright © 2020 Rufat Mirza. All rights reserved.
//

import Foundation

struct RIQueue<Element> {
  
  var items: [Element] = []
  
  var isEmpty: Bool {
    return items.isEmpty
  }
  
  mutating func insert(_ item: Element, at index: Int) {
    items.insert(item, at: 0)
  }
  
  mutating func enqueue(_ item: Element) {
    items.append(item)
  }
  
  @discardableResult
  mutating func dequeue() -> Element? {
    guard let first = items.first else {
      return nil
    }
    items.removeFirst()
    return first
  }
  
  func peek() -> Element? {
    return items.first
  }
  
  mutating func removeAll() {
    items.removeAll()
  }
}

extension RIQueue where Element == RelevantInformer.Context {
  
  mutating func remove(_ item: RICompatible) {
    items.removeAll { $0.content === item }
  }
}
