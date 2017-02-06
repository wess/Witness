//
//  filter.swift
//  Witness
//
//  Created by Wess Cope on 02/03/2017.
//

import Foundation

public class Filter<T> : Chain<T>, Observable {

  fileprivate var observer:Observer<T>?
  fileprivate var block:(_:T) -> Bool
  fileprivate var callback:((_:T) -> ())?

  public init(_ block:@escaping(_:T) -> Bool) {
    self.block = block

    super.init()
  }

  public func `where`(_ condition:@escaping (_: T) -> Bool) -> Filter<T> {
    let filter = Filter(condition)
    next        = filter

    return filter
  }

  public func map<R>(_ mapping:@escaping (_: T) -> R) -> Map<T, R> {
    let map = Map(mapping)
    next    = map

    return map
  }

  public func observe(_ observer: Observer<T>) {
    self.observer = observer
  }

  public func observe(_ callback: @escaping (T) -> ()) {
    self.callback = callback
  }

  internal override func update(_ updatedValue:T) {
    super.update(updatedValue)

    guard let value = value, block(value) == true else { return }

    if let next = next {
      next.update(value)
    } else {
      observer?.value = value
      callback?(value)
    }
  }
}
