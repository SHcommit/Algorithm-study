//
//  main.swift
//  과일 장수
//
//  Created by 양승현 on 6/28/24.
//

import Foundation

func solution(_ k:Int, _ m:Int, _ score:[Int]) -> Int {
  return score
    .sorted(by: >)
    .reduce(into: ([[Int]](), 0)) { p, s in
      if p.0.isEmpty { p.0.append([s]) }
      else if p.0[p.1].count < m {  p.0[p.1].append(s) }
      else {  p.0.append([s]); p.1 += 1 }
    }
    .0
    .filter { $0.count == m }
    .map { ($0.last ?? 0) * m }
    .reduce(0,+)
}

print(solution(3, 4, [1, 2, 3, 1, 2, 3, 1]))
