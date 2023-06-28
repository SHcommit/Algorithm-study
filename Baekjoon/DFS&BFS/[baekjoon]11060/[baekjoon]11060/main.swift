//
//  main.swift
//  [baekjoon]11060
//
//  Created by 양승현 on 2023/06/29.
//

import Foundation

let n = Int(readLine()!)!
let map = readLine()!.split{$0==" "}.map{Int(String($0))!}
var visited = Array(repeating: Int.max, count: n)
func bfs() {
  var queue = [0]
  var idx = 0
  visited[0] = 0
  while(idx < queue.count) {
    let cx = queue[idx]
    idx += 1
    for dx in 0...map[cx] {
      let nx = dx+cx
      if !(0..<n).contains(nx) { break }
      if visited[cx] + 1 < visited[nx] {
        visited[nx] = visited[cx] + 1
        queue.append(nx)
      }
    }
  }
  print(visited[n-1] == Int.max ? -1 : visited[n-1])
}
bfs()
