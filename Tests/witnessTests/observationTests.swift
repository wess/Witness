//
//  witnessObservationTests.swift
//  witness
//
//  Created by Wesley Cope on 2/3/17.
//
//

import XCTest
@testable import witness

class witnessObservationTests: XCTestCase {
  func testObserving() {
    let str         = Value("Hello World")
    var wasObserved = false

    str.observe {
      wasObserved = true
    }

    str.value = "Goodbye World"

    XCTAssertTrue(wasObserved)
  }

  func testFiltering() {
    let num   = Value(1)
    var calls = 0

    num.where { $0 != 3 }.observe {
      calls += 1

      XCTAssertEqual($0, 1)
    }

    num.value = 1
    num.value = 2

    XCTAssertEqual(calls, 1)
  }

  func testMapping() {
    let str         = Value("")
    var wasObserved = false

    str.map { $0 + " - Goodbye World" }.observe {
      wasObserved = true

      XCTAssertEqual($0, "Hello World - Goodbye World")
    }

    str.value = "Hello World"

    XCTAssertTrue(wasObserved)
  }
}
