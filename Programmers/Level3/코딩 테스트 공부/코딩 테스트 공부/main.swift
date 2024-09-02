//
//  main.swift
//  코딩 테스트 공부
//
//  Created by 양승현 on 9/2/24.
//

import Foundation

/// 어떻게 풀까 !!
///
/// 일단 alp + 1  or cop + 1 or 현재 가능한 alp, cop기반 문제 풀어서 증가 이 3가지 경우를 생각했음.
///
/// 재귀로 풀자니 alp 한번 증가 후 cop나 문제풀어서 증가하도록 구현하는게 쉽지 않았음.
///
/// cache[i][j]는 상황에 따라서, alp만 1 증가 또는 cop만 1증가 또는 문제 풀어서 1 증가하도록 cache를 갱신해 나갈 수 있음
/// cache[i][j]는 다시말하면 i는 현재 알고력, j는 현재 코딩력을 의미.
/// 알고력만 증가시킨 경우, cache[i+1]j[j]는 해당 알고력, 코딩력 까지 걸리는데 증가된 시간을 저장할 수 있게됨
/// 코딩력만 증가시키는 경우 cache[i][j+1]는 i, j+1인 알고력, 코딩력일 때 걸린 시간을 저장할 수 있게됨.
///
/// 이차원으로 접근해야 알고력을 +1 증가하거나, 코딩력을 +1 증가 또는 문제풀어서 증가 모든 경우에 대한 최적해를 구할수 있음
func solution(_ alp:Int, _ cop:Int, _ problems:[[Int]]) -> Int {
  let maxAlp = problems.map { $0[0] }.max()!, maxCop = problems.map { $0[1] }.max()!
  let initialAlp = min(maxAlp, alp), initialCop = min(maxCop, cop)
  var cache = Array(repeating: Array(repeating: Int.max, count: maxCop+1), count: maxAlp+1)
  cache[initialAlp][initialCop] = 0
  for i in initialAlp...maxAlp {
    for j in initialCop...maxCop {
      let curCost = cache[i][j]
      if curCost == Int.max { continue }
      if i+1 <= maxAlp {
        cache[i+1][j] = min(cache[i+1][j], curCost+1)
      }
      if j+1 <= maxCop {
        cache[i][j+1] = min(cache[i][j+1], curCost+1)
      }
      
      for p in problems {
        let (alp_req, cop_req, alp_rwd, cop_rwd, cost) = (p[0],p[1],p[2],p[3],p[4])
        
        if i >= alp_req && j >= cop_req {
          let nextAlp = min(maxAlp, i+alp_rwd)
          let nextCop = min(maxCop, j+cop_rwd)
          cache[nextAlp][nextCop] = min(cache[nextAlp][nextCop], curCost+cost)
        }
      }
    }
  }
  return cache[maxAlp][maxCop]
}
print(solution(0, 0, [[0,0,2,1,2],[4,5,3,1,2],[4,11,4,0,2],[10,4,0,4,2]]))

