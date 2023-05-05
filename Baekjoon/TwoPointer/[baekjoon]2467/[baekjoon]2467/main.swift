//
//  main.swift
//  [baekjoon]2467
//
//  Created by 양승현 on 2023/05/06.
//

import Foundation

let n = Int(readLine()!)!
let list = readLine()!.split{$0==" "}.map{Int(String($0))!}.sorted()
var l = 0, r = n-1, a = 0, b = 0
var min = Int.max
func solution() {
  while l < r {
    let cal = list[l]+list[r]
    if abs(cal) < min {
      min = abs(cal)
      a = list[l]
      b = list[r]
    }
    if cal > 0 {
      r -= 1 }
    else if cal < 0 { l += 1 }
    else {
      print("\(a) \(b)")
      return
    }
  }
  print("\(a) \(b)")
}
solution()
