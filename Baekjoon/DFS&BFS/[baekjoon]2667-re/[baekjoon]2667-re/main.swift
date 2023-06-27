//
//  main.swift
//  [baekjoon]2667-re
//
//  Created by 양승현 on 2023/06/27.
//

import Foundation
typealias Point = (x:Int, y:Int)
let direction: [Point] = [(-1,0),(1,0),(0,1),(0,-1)]
let n = Int(readLine()!)!
var map = (0..<n).map { _ in readLine()!.map{Int(String($0))!} }
var res: [Int] = []
var visited = Array(repeating: Array(repeating: false, count: n), count: n)
func isOutOfBounds(_ p: Point) -> Bool {
  return !(0..<n).contains(p.x) || !(0..<n).contains(p.y)
}
func bfs(_ start: Point) {
  res.append(1)
  visited[start.y][start.x] = true
  var queue: [Point] = [start]
  var idx = 0
  while idx < queue.count {
    let (cx,cy) = queue[idx]
    idx += 1
    for (dx,dy) in direction {
      let (nx,ny) = (cx+dx, cy+dy)
      if isOutOfBounds((nx,ny)) { continue }
      if !visited[ny][nx] && map[ny][nx] == 1 {
        visited[ny][nx] = true
        res[res.count-1] += 1
        queue.append((nx,ny))
      }
    }
  }
}

for y in 0..<n {
  for x in 0..<n where !visited[y][x] && map[y][x] == 1 {
    bfs((x,y))
  }
}
res.sort()
res.insert(res.count, at: 0)
print(res.map{String($0)}.joined(separator: "\n"))
