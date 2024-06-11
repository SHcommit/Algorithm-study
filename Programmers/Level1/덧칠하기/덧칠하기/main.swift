//
//  main.swift
//  덧칠하기
//
//  Created by 양승현 on 6/11/24.
//

import Foundation

/// 길이 n미터인 벽에 구역을 나누어 일부만 새로 페인트 칠한다.
/// 벽을 1m인 구역 n개로 나눈다.
///
/// 롤러의 규칙.
/// 1. 벽에서 벗어나면 안된다.
/// 2. 구역의 일부분만 포함되도록 칠해서는 안된다.
///
/// Parameters:
/// - Parameter n: 학교에 페인트 칠해진 길이 n
/// - Parameter m: 페인트 칠할 롤러의 길이 m
/// - Parameter section: 다시 칠할 구간.
func solution(_ n:Int, _ m:Int, _ sections:[Int]) -> Int {
  let sections = sections.map { $0-1 }
  var painting = 0
  var hasPainted = Array(repeating: true, count: n)
  sections.forEach { hasPainted[$0] = false }
  for section in sections {
    if hasPainted[section] {
      continue
    }
    painting += 1
    for s in section..<section+m where s < n {
      hasPainted[s] = true
    }
  }
  return painting
}

print(solution(4, 1, [1, 2,3,4]))
