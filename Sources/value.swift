//
//  value.swift
//  witness
//
//  Created by Wesley Cope on 2/3/17.
//
//

import Foundation

public class Value<T> : Observable {

  public var value:T {
    didSet {
      previousValue = oldValue
      executeUpdates()
    }
  }

  private var previousValue:T?
  private var observers:[Observer<T>] = []
  private var callbacks:[(_:T) -> ()] = []
  private var chains:[Chain<T>]       = []

  public init(_ value:T) {
    self.value = value
  }

  public func `where`(_ condition: @escaping (_:T) -> Bool) -> Filter<T> {
    let filter = Filter(condition)
    chains.append(filter)

    return filter
  }

  public func map<R>(_ mapping: @escaping (_:T) -> R) -> Map<T, R> {
    let map = Map(mapping)
    chains.append(map)

    return map
  }

  public func observe(_ callback: @escaping (_:T) -> ()) {
    callbacks.append(callback)
  }

  public func observe(_ observer: Observer<T>) {
    observers.append(observer)
  }

  private func executeUpdates() {
    for observer in observers {
      observer.value = value
    }

    for chain in chains {
      chain.update(value)
    }

    for callback in callbacks {
      callback(value)
    }

  }
}
