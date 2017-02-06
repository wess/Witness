//
//  map.swift
//  Witness
//
//  Created by Wess Cope on 02/03/2017.
//

import Foundation

public class Map<T, R> : Chain<T> {
  private var block:((_:T) -> R)?
  private var observer:Observer<R>?
  private var callback:((_:R) -> ())?
  private var nextFilter:Filter<R>?
  private var nextMap:Chain<R>?

  public init(_ block:@escaping (_:T)->R) {
    self.block = block
  }

  public func `where`(_ condition:@escaping (_: R) -> Bool) -> Filter<R> {
    let filter  = Filter(condition)
    nextFilter  = filter

    return filter
  }

  public func map<N>(_ mapping:@escaping (_: R) -> N) -> Map<R, N> {
    let map = Map<R, N>(mapping)
    nextMap = map

    return map
  }

  public func observe(_ observer: Observer<R>) {
    self.observer = observer
  }

  public func observe(_ callback: @escaping (_:R) -> ()) {
    self.callback = callback
  }

  internal override func update(_ updatedValue:T) {
    super.update(updatedValue)

    guard let value = value, let mappedValue = block?(value) else { return }

    if let nextFilter = nextFilter {
      nextFilter.update(mappedValue)
    } else if let nextMap = nextMap {
      nextMap.update(mappedValue)
    } else {
      observer?.value = mappedValue
      callback?(mappedValue)
    }
  }
}
