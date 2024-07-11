//
//  main.swift
//  전력망을 둘로 나누기
//
//  Created by 양승현 on 7/11/24.
//

import Foundation

/// 완전탐색 + dfs느낌으로다가 풀음.
/// wires도 개수가 작아서 도전해봄
func solution(_ n:Int, _ wires:[[Int]]) -> Int {
  func detect(_ node: Int, wire: [Int], visited: inout [Bool]) -> Int {
    var res = 0
    for nextNode in dict[node]! {
      if node == wire[0] && nextNode == wire[1] { continue }
      else if node == wire[1] && nextNode == wire[0] { continue }
      if !visited[nextNode-1] {
        visited[nextNode-1] = true
        res += 1
        res += detect(nextNode, wire: wire, visited: &visited)
      }
    }
    return res
  }
  var maxN = 0
  let dict = wires.reduce(into: [Int: [Int]]()) {
    maxN = max(maxN, max($1[0],$1[1]))
    $0[$1[0], default: []].append($1[1])
    $0[$1[1], default: []].append($1[0])
  }
  var res = Int.max
  for wire in wires {
    var visited = (0..<maxN).map { _ in false }
    var p = 0, n = 0
    for i in 1...maxN {
      if visited[i-1] { continue }
      visited[i-1] = true
      if p == 0 {
        p = detect(i, wire: wire, visited: &visited) + 1
      } else {
        n = detect(i, wire: wire, visited: &visited) + 1
      }
    }
    res = min(res, abs(p-n))
  }
  return res
}

print(solution(9,  [[1,3],[2,3],[3,4],[4,5],[4,6],[4,7],[7,8],[7,9]]  ))
