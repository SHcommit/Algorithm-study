//
//  main.swift
//  등대
//
//  Created by 양승현 on 9/1/24.
//

import Foundation

///
/// 그리디하게 풀려고했는데 그리디하게 풀지 못하는 조건이 나올 수 도 있다.
/// 이 문제는 서브트리의 등대 켜짐 조건을 최소한으로 파악해나가면서 현 노드의 등대가 켜졌을때 또는 꺼졌을때의 최소값을
/// 갱신해나가는 문제다.
///
/// dp는대박이다... 문제가어렵다 ㅠㅅㅠ
///
/// n개 정점에 대한 간선은 n-1이므로 dfs, bfs쓰기 정말 좋다.
/// 그래프가 아니라 트리임.
/// dfs를 통해 탐색한다면 모든 정점에 대해서만 탐색하게 됨으로 O(n)의 시간복잡도가 이루어진다.
///
/// 탐색할 때 visited뿐 아니라 최적해를 구하게 되는 시간복잡도는 O(1)에 가깝다. (visited + dfs 떄문)
func solution(_ n:Int, _ lighthouse:[[Int]]) -> Int {
  var graph = Array(repeating: [Int](), count: n+1)
  for nodes in lighthouse {
    graph[nodes[0]].append(nodes[1])
    graph[nodes[1]].append(nodes[0])
  }
  
  var dp = Array(repeating: [0,0], count: n+1)
  var visited = Array(repeating: false, count: n+1)
  
  func dfs(_ node: Int) {
    visited[node] = true
    dp[node][1] = 1
    for neighbor in graph[node] where !visited[neighbor] {
      dfs(neighbor)
      
      dp[node][0] += dp[neighbor][1]
      dp[node][1] += min(dp[neighbor][1], dp[neighbor][0])
    }
  }
  dfs(1)
  return min(dp[1][0], dp[1][1])
}
