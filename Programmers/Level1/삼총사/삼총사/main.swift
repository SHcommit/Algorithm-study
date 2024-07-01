//
//  main.swift
//  삼총사
//
//  Created by 양승현 on 7/1/24.
//

import Foundation
func solution(_ n:[Int]) -> Int {
  var res = 0
  for i in 0..<n.count-2 {
    for j in i+1..<n.count-1 {
      for k in j+1..<n.count { res += n[i]+n[j]+n[k] == 0 ? 1 : 0  }
    }
  }
  return res
}
print(solution([-2,3,0,2,-5]))
