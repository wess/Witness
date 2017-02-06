//
//  chain.swift
//  Witness
//
//  Created by Wess Cope on 02/03/2017.
//

import Foundation

public class Chain<T> {

  internal var next:Chain?
  private(set) public var value:T?
  
  internal func update(_ value:T) {
    self.value = value
  }
}
