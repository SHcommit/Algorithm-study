//
//  main.swift
//  [baekjoon]15650
//
//  Created by 양승현 on 1/8/24.
//

import Foundation

var n = 0, m = 0
_={n = $0[0];m = $0[1]}(readLine()!.split{$0==" "}.map{Int(String($0))!})
var seq = Array(repeating: 0, count: m)
var isSelected = Array(repeating: false, count: n+1)
func tracking(with k: Int) {
  if k == m {
    print(seq.map { String($0) }.joined(separator: " "))
    return
  }
  for i in 1...n where !isSelected[i] {
    if k > 0 && seq[k-1] > i { continue }
    isSelected[i].toggle()
    seq[k] = i
    tracking(with: k+1)
    isSelected[i].toggle()
  }
}
tracking(with: 0)
