//
//  main.swift
//  [baekjoon]2504
//
//  Created by 양승현 on 1/11/24.
//

import Foundation
/*
 89%에서 계속 틀렸는데 이때 반례는 ()]()
 */
let str = "()[]".map{String($0)}
var stack: [String] = []
let s: [String] = readLine()!.map {
  if $0 == "(" || $0 == "[" { return String($0) }
  return $0 == "]" ? String("3") : String("2")
}
for element in s {
  if element == "(" || element == "[" {
    stack.append(element)
    continue
  }
  if stack.last == nil || !stack.contains(where: {["[", "("].contains($0)}) {
    print(0)
    exit(0)
  }
  var temp = 0
  while let pop = stack.popLast() {
    if pop != "(" && pop != "[" {
      temp += Int(pop)!
      continue
    }
    guard (pop == "(" && element == "2") || (pop == "[" && element == "3") else {
      print(0)
      exit(0)
    }
    stack.append(String(temp == 0 ? Int(element)! : temp*Int(element)!))
    break
  }
}
if stack.contains(where: {str.contains($0)}) {
  print(0)
} else {
  print(stack.compactMap(Int.init).reduce(0, +))
}
