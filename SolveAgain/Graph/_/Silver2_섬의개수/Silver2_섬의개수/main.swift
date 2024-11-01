//
//  main.swift
//  Silver2_섬의개수
//
//  Created by 양승현 on 10/31/24.
//

import Foundation

typealias Point = (x: Int, y: Int)
let Direction: [Point] = [(-1,0), (1,0),(0,1),(0,-1), (-1,-1),(1,1),(-1,1),(1,-1)]

var board: [[Int]] = [], visited: [[Bool]] = []
var width = 0, height = 0
while let wh = readLine()?.split { $0==" " }.compactMap { Int($0) }, wh[0] != 0 {
  var ans = 0
  width = wh[0]
  height = wh[1]
  board = []
  visited = []
  board = (0..<height).map { _ in readLine()!.split{$0==" "}.compactMap { Int($0) } }
  visited = (0..<height).map { _ in (0..<width).map { _ in false } }
  
  for y in 0..<height {
    for x in 0..<width {
      if board[y][x] == 1 && !visited[y][x] {
        visited[y][x] = true
        bfs((x,y))
        ans += 1
      }
    }
  }
  print(ans)
}

func bfs(_ startPoint: Point) {
  var queue = [startPoint]
  var idx = 0
  while idx < queue.count {
    let cur = queue[idx]
    idx += 1
    for d in Direction {
      let next: Point = (d.x + cur.x, d.y + cur.y)
      if isOutOfBounds(next) || board[next.y][next.x] == 0 || visited[next.y][next.x] { continue }
      queue.append(next)
      visited[next.y][next.x] = true
    }
  }
}

@inline(__always)
func isOutOfBounds(_ point: Point) -> Bool { !((0..<height)~=point.y && (0..<width)~=point.x) }
