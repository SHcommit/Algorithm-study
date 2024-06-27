//
//  main.swift
//  귤 고르기
//
//  Created by 양승현 on 6/27/24.
//

import Foundation

func solution(_ k:Int, _ tangerine:[Int]) -> Int {
  let d = tangerine.reduce(into: [Int: Int]()) { $0[$1, default: 0] += 1 }
  let values = d.values.sorted(by: >)
  var res = 0
  var tempK = 0
  for value in values {
    tempK += value
    res += 1
    if tempK >= k {
      return res
    }
  }
  return res
}

print(solution(6, [1, 3, 2, 5, 4, 5, 2, 3]))

/// Dictionary(grouping;by:) 이거도 좋네 한번 풀어봄
func s2(_ k: Int, _ tangeriune: [Int]) -> Int {
  Dictionary(grouping: tangeriune) { $0 }
    .values
    .sorted(by: {$0.count > $1.count })
    .reduce((0, 0)) { elem, arr in
      elem.0 >= k ? (elem.0, elem.1) : (elem.0 + arr.count, elem.1 + 1)
    }.1
}

print(s2(6, [1,2,3,5,4,5,2,3]))
