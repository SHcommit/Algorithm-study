//
//  main.swift
//  [Baekjoon]1303
//
//  Created by 양승현 on 2023/05/26.
//

import Foundation

// MARK: - Constant
typealias Point = (x: Int, y: Int)
let direction = [(-1,0),(1,0),(0,1),(0,-1)]

// MARK: - Properties
let wh = readLine()!.split{$0==" "}.map{Int(String($0))!}
let width = wh[0], height = wh[1]
let map = (0..<height).map {_->[String] in return readLine()!.map { String($0) } }
var visited = Array(repeating: Array(repeating: false, count: width), count: height)
var res = [0, 0]

// MARK: - Helpers
func isOutOfBounds(_ p: Point) -> Bool {
  return p.x<0 || p.x>width-1 || p.y<0 || p.y>height-1
}

func bfs(_ sp: Point) -> Int {
  var cnt = 1
  var queue: [Point] = [sp]
  var idx = 0
  let color = map[sp.y][sp.x]
  while queue.count != idx {
    let curPoint = queue[idx]
    for (dx,dy) in direction {
      let (nx,ny) = (curPoint.x+dx,curPoint.y+dy)
      if isOutOfBounds((nx,ny)) { continue }
      if !visited[ny][nx] && map[ny][nx] == color {
        visited[ny][nx] = true
        cnt += 1
        queue.append((nx,ny))
      }
    }
    idx += 1
  }
  return cnt
}

func solution() {
  for y in 0..<height {
    for x in 0..<width where !visited[y][x] {
      visited[y][x] = true
      let n = bfs((x,y))
      guard map[y][x] == "W" else {
        res[1] += n*n
        continue
      }
      res[0]+=n*n
    }
  }
  print(res.map{String($0)}.joined(separator:" "))
}

solution()
