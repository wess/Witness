//
//  observable.swift
//  Witness
//
//  Created by Wess Cope on 02/03/2017.
//

import Foundation

public protocol Observable {
  associatedtype T

  func `where`(_ condition:@escaping (_: T) -> Bool) -> Filter<T>
  func map<R>(_ mapping:@escaping (_: T) -> R) -> Map<T, R>
  func observe(_ callback:@escaping (_: T) -> ())
  func observe(_ observer: Observer<T>)
}
