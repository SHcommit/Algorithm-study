//
//  main.swift
//  뒤에 있는 큰 수 찾기
//
//  Created by 양승현 on 6/17/24.
//

import Foundation

var buffer: [Int] = []
var res: [Int] = []

func findNextToBigNumber(_ target: Int) {
  var hasFounded = false
  while !hasFounded {
    if buffer.isEmpty { break }
    let element = buffer.removeLast()
    if target < element {
      hasFounded = true
      res.append(element)
      buffer.append(contentsOf: [element, target])
    }
  }
  if !hasFounded {
    buffer.append(target)
    res.append(-1)
  }
}

func solution(_ numbers:[Int]) -> [Int] {
  numbers.reversed().forEach { findNextToBigNumber($0) }
  return res.reversed()
}
