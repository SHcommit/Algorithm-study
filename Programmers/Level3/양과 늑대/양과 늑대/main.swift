//
//  main.swift
//  양과 늑대
//
//  Created by 양승현 on 9/2/24.
//

import Foundation

/// https://dev-with-precious-dreams.tistory.com/293
///
/// 매번 문제가 신선하다ㅠㅅㅠ..
///
/// 이번에 알게된 것은!
///
/// 트리를 탐색할때 dfs, bfs로 탐색이 되는데, 이 거 말고도 "조건에 의한" 탐색도 가능하다.
/// 재귀적으로 노드를 탐색할 때, 탐색해야할 좌 sub tree, 우 subtree의 노드들 정보를 모아서, 이들을 또 재귀 탐색하며
/// 가능한 많은 수의 양때를 얻을 수 있다.
///
/// 조건은 크게, 현재 노드에 양이 있는지 wolf일 경우에는 양보다 적은지 여부이다.
func makeTree(with edges: [[Int]]) -> [Int: [Int]] {
  let factory = { (p: inout [Int: [Int]], n: [Int]) in p[n[0],default: []].append(n[1]) }
  return edges.reduce(into: [Int: [Int]](), factory)
}

func maxSheep(tree: [Int: [Int]], nextNodes nodes: [Int], info: [Int], sheepCnt: Int, wolfCnt: Int) -> Int {
  if nodes.isEmpty { return sheepCnt }
  var maxSheepCnt = sheepCnt
  for node in nodes {
    let nodeInfo = info[node]
    let nodesWithoutCurNode = nodes.filter{$0 != node}
    if nodeInfo == 0 {
      maxSheepCnt = max(maxSheepCnt, maxSheep(tree: tree, nextNodes: nodesWithoutCurNode + (tree[node] ?? []), info: info, sheepCnt: sheepCnt+1, wolfCnt: wolfCnt))
    } else if sheepCnt > wolfCnt+1 {
      maxSheepCnt = max(maxSheepCnt, maxSheep(tree: tree, nextNodes: nodesWithoutCurNode + (tree[node] ?? []), info: info, sheepCnt: sheepCnt, wolfCnt: wolfCnt+1))
    }
  }
  return maxSheepCnt
}

func solution(_ info: [Int], _ edges: [[Int]]) -> Int {
  let tree = makeTree(with: edges)
  
  return maxSheep(tree: tree, nextNodes: tree[0]!, info: info, sheepCnt: 1, wolfCnt: 0)
}

print(solution([0,0,1,1,1,0,1,0,1,0,1,1], [[0,1],[1,2],[1,4],[0,8],[8,7],[9,10],[9,11],[4,3],[6,5],[4,6],[8,9]]))
