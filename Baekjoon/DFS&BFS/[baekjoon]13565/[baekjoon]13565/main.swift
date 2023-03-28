//
//  main.swift
//  [baekjoon]13565
//
//  Created by 양승현 on 2023/03/29.
//

import Foundation
typealias Point = (x:Int, y:Int)
let direction = [(-1,0),(1,0),(0,1),(0,-1)]
let hw = readLine()!.split{$0==" "}.map{Int(String($0))!}
let height = hw[0], width = hw[1]
var flow = false
var graph = (0..<height).map{_ in readLine()!.map{Int(String($0))!}}
var visited = Array(repeating: Array(repeating: false, count: width), count: height)

func isOutOfBounds(_ p: Point) -> Bool {
  return p.x < 0 || p.y < 0 || p.x > width - 1 || p.y > height - 1
}

func bfs(start p: Point) {
  var isTop = false
  var isBottom = false
  var queue = [p]
  var idx = 0
  visited[p.y][p.x] = true
  
  while idx < queue.count {
    let (cx,cy) = queue[idx]
    if cy == height - 1 {
      isBottom = true
    }
    if cy == 0 {
      isTop = true
    }
    if isTop && isBottom {
      flow = true
      return
    }
    
    for (dx,dy) in direction {
      let (nx,ny) = (cx+dx, cy+dy)
      if isOutOfBounds((nx,ny)) { continue }
      if !visited[ny][nx] && graph[ny][nx] == 0 {
        
        visited[ny][nx] = true
        queue.append((nx,ny))
      }
    }
    idx += 1
  }
}
func solution() {
  for y in 0..<height {
    for x in 0..<width where graph[y][x] == 0 && !visited[y][x] {
      bfs(start: (x,y))
      if flow {
        print("YES")
        return
      }
    }
  }
  print("NO")
}

solution()
