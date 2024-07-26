//
//  main.swift
//  실패율
//
//  Created by 양승현 on 7/26/24.
//

import Foundation

/// 승현아. 문제의, 제한상을 읽거라. 너 스스로 창의적으로 풀지말고.
func solution(_ N:Int, _ stages:[Int]) -> [Int] {
  var stageHeadcounts = (0..<N+1).map{_ in 0}
  var tempHeadcount = 0
  var ans: [Double] = (0..<N).map{_ in 0}
  stages.forEach { stage in
    stageHeadcounts[stage-1] += 1
  }
  
  stride(from: N, through: 0, by: -1).forEach {
    if $0 == N {
      tempHeadcount = stageHeadcounts[$0]
      return
    }
    tempHeadcount += stageHeadcounts[$0]
    ans[$0] = tempHeadcount == 0 ? 0 : Double(stageHeadcounts[$0])/Double(tempHeadcount)
  }
  return ans
    .enumerated()
    .sorted { $0.1 == $1.1 ? $0.0 < $1.0 : $0.1 > $1.1}
    .map { $0.0 + 1 }
}

print(solution(6, [2, 2, 2, 2, 2, 2, 2, 2, 2]))
