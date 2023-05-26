//
//  main.swift
//  [Baekjoon]14940
//
//  Created by 양승현 on 2023/05/26.
//

import Foundation
// MARK: - Constant
typealias Point = (x:Int, y:Int)
let direction = [(-1,0),(1,0),(0,1),(0,-1)]

// MARK: - Properties
let hw = readLine()!.split{$0==" "}.map{Int(String($0))!}
let height = hw[0], width = hw[1]
let map = (0..<height).map {_->[Int] in return readLine()!.split{$0==" "}.map{Int(String($0))!}}
var visited = Array(repeating: Array(repeating: -1, count:width), count: height)

// MARK: - Helpers
func isOutOfBounds(_ p: Point) -> Bool {
  return p.x<0 || p.x>width-1 || p.y<0 || p.y>height-1
}

func bfs(_ sp: Point) {
  var queue: [Point] = [sp]
  var idx = 0
  visited[sp.y][sp.x] = 0
  while queue.count != idx {
    let (cx, cy) = (queue[idx].x, queue[idx].y)
    for (dx,dy) in direction {
      let (nx, ny) = (cx+dx,cy+dy)
      if isOutOfBounds((nx,ny)) { continue }
      if visited[ny][nx] == -1 && map[ny][nx] == 1 {
        visited[ny][nx] = visited[cy][cx] + 1
        queue.append((nx,ny))
      }
    }
    idx += 1
  }
}

func solution() {
  for y in 0..<height {
    for x in 0..<width where map[y][x] == 2 {
      bfs((x,y))
    }
  }
  visited = visited.enumerated().map { y, list in
    list.enumerated().map { x, value in
      if value == -1 {
        if map[y][x] == 0 {
          return 0
        } else {
          return -1
        }
      }
      return value
    }
  }
  print(visited.map{$0.map{String($0)}.joined(separator: " ")}.joined(separator: "\n"))
}

solution()
