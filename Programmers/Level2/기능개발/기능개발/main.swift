//
//  main.swift
//  기능개발
//
//  Created by 양승현 on 10/29/24.
//

import Foundation

/// progresses: 작업의 진도
/// speeds: 개발 속도
func solution(_ progresses:[Int], _ speeds:[Int]) -> [Int] {
  let seq = progresses
    .enumerated()
    .map { (n, e) -> Int in
      let remainDays = 100 - e
      let s = speeds[n]
      var atLeastDays = remainDays / s
      atLeastDays += (remainDays % s) > 0 ? 1 : 0
      return atLeastDays
    }
  var ans: [Int] = [0]
  var target = seq[0]
  var i = 0
  for e in seq {
    if target < e {
      target = e
      ans.append(1)
      i+=1
      continue
    }
    ans[i]+=1
  }
  /// 각 배포마다 몇 개의 기능이 배포되는지
  return ans
}
