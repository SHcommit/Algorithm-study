//
//  main.swift
//  보석 쇼핑
//
//  Created by 양승현 on 9/13/24.
//

import Foundation
/// 딱보니.. 투포인터가 생각남.
func solution(_ gems:[String]) -> [Int] {
  let n = gems.count
  let numOfGemTypes = Set(gems).count
  var l = 0, r = 0
  var flex = [gems[0]: 1]
  var ans = [1, n]
  while l<=r && r < n {
    if flex.keys.count == numOfGemTypes {
      if ans[1] - ans[0] > r - l {
        ans = [l+1, r+1]
      }
      flex[gems[l], default: 0] -= 1
      if flex[gems[l]] ?? 0 <= 0 {
        flex.removeValue(forKey: gems[l])
      }
      l+=1
    } else if flex.keys.count < numOfGemTypes {
      r += 1
      if r >= n { break }
      flex[gems[r], default: 0] += 1
    }
  }
  return ans
}
