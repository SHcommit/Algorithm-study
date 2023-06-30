//
//  main.swift
//  [baekjoon]13913
//
//  Created by 양승현 on 2023/06/30.
//

import Foundation

let input = readLine()!.split{$0==" "}.map{Int(String($0))!}
let (N, K) = (input[0], input[1])
func bfs() {
  var visited = Array(repeating:-1, count: 100001)
  var queue = [N]
  var idx = 0
  while idx < queue.count {
    let cx = queue[idx]
    idx+=1
    if cx == K {
      var ans = [K]
      var nx = K
      while nx != N {
        ans.append(visited[nx])
        nx = visited[nx]
      }
      print(ans.count-1)
      print(ans.reversed().map{String($0)}.joined(separator: " "))
      return
    }
    _=[cx-1, cx+1,cx*2].map {
      if (0...100000).contains($0) && visited[$0] == -1 {
        visited[$0] = cx
        queue.append($0)
      }
    }
  }
}
bfs()
