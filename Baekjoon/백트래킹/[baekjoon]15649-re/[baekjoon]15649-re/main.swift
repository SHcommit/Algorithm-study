//
//  main.swift
//  [baekjoon]15649-re
//
//  Created by 양승현 on 1/8/24.
//

import Foundation

let input = readLine()!.split{$0==" "}.map {Int(String($0))!}
let n = input[0], m = input[1]
var seq = Array(repeating: 0, count: m)
var isSelected = Array(repeating: false, count: n+1)

func execute(with k: Int) {
  if k == m {
    print(seq.map{String($0)}.joined(separator: " "))
    return
  }
  for i in 1...n {
    if !isSelected[i] {
      isSelected[i].toggle()
      seq[k] = i
      execute(with: k+1)
      isSelected[i].toggle()
    }
  }
}
execute(with: 0)
