//
//  main.swift
//  [baekjoon]11729
//
//  Created by 양승현 on 2023/06/29.
//

import Foundation
var res: [String] = []
func hanoiTower(n:Int, from: Int, mid: Int, to: Int) {
  if n == 1 {
    res.append("\(from) \(to)")
    return
  }
  hanoiTower(n: n-1, from: from, mid: to, to: mid)
  res.append("\(from) \(to)")
  hanoiTower(n: n-1, from: mid, mid: from, to: to)
}

hanoiTower(n: Int(readLine()!)!, from: 1, mid: 2, to: 3)
print(res.count)
print(res.joined(separator: "\n"))
