//
//  Observer.swift
//  Witness
//
//  Created by Wess Cope on 02/03/2017.
//

import Foundation

public class Observer<T> {
  public var value:T {
    didSet {
      callback?(value)
    }
  }

  internal var callback:((_:T) -> ())?

  public init(_ value:T) {
    self.value = value
  }
}
