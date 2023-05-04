//
//  main.swift
//  [baekjoon]2217
//
//  Created by 양승현 on 2023/05/04.
//

//1 2 4 7 10
//1 1 1 1 1   5
//2 2 2 2     8
//4 4 4       4
//7 7         14
//10          10


import Foundation

var max = 1
let n = Int(readLine()!)!
(0..<n)
  .map{_ in Int(readLine()!)! }
  .sorted()
  .enumerated()
  .forEach {
    let cal = $0.element*(n-($0.offset))
    if max < cal {
      max = cal
    }else if max < $0.element  {
      max = $0.element
    }
    if $0.offset == n - 1 { print(max) }
  }
