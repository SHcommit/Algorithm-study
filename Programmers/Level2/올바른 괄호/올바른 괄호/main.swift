//
//  main.swift
//  올바른 괄호
//
//  Created by 양승현 on 8/17/24.
//

import Foundation

func solution(_ s:String) -> Bool {
  var ss = Array(s.reversed()), stack: [Character] = []
  while let popped = ss.popLast() {
    if popped == ")" {
      if let stackPopped = stack.popLast(), stackPopped == "(" { continue }
      return false
    }
    stack.append(popped)
  }
  return stack.isEmpty ? true : false
}
