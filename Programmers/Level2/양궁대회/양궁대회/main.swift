//
//  main.swift
//  양궁대회
//
//  Created by 양승현 on 7/8/24.
//

import Foundation

func solution(_ n:Int, _ info:[Int]) -> [Int] {
  var buf = (0...10).map { _ in 0 }
  var maxValue = 0
  var ans: [Int] = []
  func dfs(_ idx: Int, hitCnt: Int) {
    if idx == 11 {
      if hitCnt == n {
        var res = 0
        for i in info.indices {
          if info[i] == 0 && buf[i] == 0 { continue }
          if info[i] >= buf[i] { res -= 10-i }
          else { res += 10-i }
        }
        guard res > 0 else { return }
        if maxValue < res {
          maxValue = res
          ans = buf
        } else if maxValue == res {
          for i in stride(from:10, through: 0, by:-1) {
            if ans[i] < buf[i] {
              ans = buf
              return
            } else if ans[i] > buf[i] { return }
          }
        }
      }
      return
    }
    if info[idx] == 0 {
      dfs(idx+1, hitCnt: hitCnt)
    } else {
      for i in 0...info[idx] {
        if i + hitCnt <= n {
          buf[idx] = i
          dfs(idx+1, hitCnt: hitCnt+i)
          buf[idx] = 0
        }
        
      }
    }
    if info[idx] + hitCnt + 1 <= n {
      buf[idx] = info[idx] + 1
      dfs(idx+1, hitCnt: hitCnt + 1 + info[idx])
      buf[idx]  = 0
    }
  }
  dfs(0, hitCnt: 0)
  return ans.isEmpty ? [-1] : ans
}
print(solution(5, [2,1,1,1,0,0,0,0,0,0,0]))
  
