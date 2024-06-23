//
//  main.swift
//  문자열 나누기
//
//  Created by 양승현 on 6/23/24.
//

import Foundation

func solution(_ s:String) -> Int {
  let str = s.map { String($0) }
  var ans = 0
  var separatorIdx = 0
  var separatorCount = 1
  if str.count == 1 { return 1 }
  for i in (1..<str.count) {
    if separatorCount == 0 {
      separatorCount = 1
      separatorIdx = i
      ans += 1
      if str.count - 1 == i {
        ans += 1
      }
      continue
    }
    if str.count - 1 == i {
      ans += 1
      break
    }
    if str[separatorIdx] == str[i] {
      separatorCount += 1
    } else {
      separatorCount -= 1
    }
  }
  
  return ans
}

print(solution("a"))
