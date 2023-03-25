//
//  main.swift
//  [baekjoon]24445
//
//  Created by 양승현 on 2023/03/24.
//

import Foundation

let nmr = readLine()!.split{$0==" "}.map{Int(String($0))!}
let n = nmr[0], m = nmr[1], s = nmr[2] - 1

var graph = Array(repeating: [Int](), count: n)
_=(0..<m).map{_ in
  let input = readLine()!.split{$0==" "}.map{Int(String($0))! - 1}
  graph[input[0]].append(input[1])
  graph[input[1]].append(input[0])
}
graph = graph.map{$0.sorted(by:>)}
func bfs() {
  var visited = Array(repeating: 0, count: n)
  var queue = [s]
  var count = 1
  var idx = 0
  visited[s] = count
  while idx < queue.count {
    let vertex = queue[idx]
    idx += 1
    _=graph[vertex].map {
      if visited[$0] != 0 { return }
      count += 1
      queue.append($0)
      visited[$0] = count
    }
  }
  print(visited.map{String($0)}.joined(separator: "\n"))
}
bfs()
