//
//  main.swift
//  가장 가까운 같 글자
//
//  Created by 양승현 on 6/25/24.
//

import Foundation

func solution(_ s:String) -> [Int] {
  let s = s.map { String($0) }
  var res: [Int] = []
  for (n, char) in s.enumerated() {
    var nextToIdx = -1
    for j in stride(from: n-1, through: 0, by: -1) {
      if s[j] == char {
        nextToIdx = n-j
        break
      }
    }
    res.append(nextToIdx)
  }
  return res
}

print(solution("banana"))
