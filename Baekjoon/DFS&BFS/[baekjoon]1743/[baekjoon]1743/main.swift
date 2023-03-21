//
//  main.swift
//  [baekjoon]1743
//
//  Created by 양승현 on 2023/03/21.
//

import Foundation


/// 오랜만에 풀어서 그런가.. inputs 반환할 때 y,x로 반환해야했는데 x,y로 반환해버렸다. 분리해서 하는게 오류를 최소화하는것같긴하다.

typealias Point = (x:Int,y:Int)
let direction = [(-1,0),(1,0),(0,1),(0,-1)]
let nmk = readLine()!.split{$0==" "}.map{Int(String($0))!}
let height = nmk[0], width = nmk[1], trashs = nmk[2]
var graph = Array(repeating: Array(repeating: 0, count: width), count: height)
let inputs: [(Point)] = (0..<trashs).map{_ in
  let input = readLine()!.split{$0==" "}.map{Int(String($0))!-1}
  graph[input[0]][input[1]] = 1
  return (input[1],input[0])
}
var visited = Array(repeating: Array(repeating: false, count: width), count: height)
func isOutOfBound(point: Point) -> Bool {
  return point.x<0 || point.y<0 || point.x>width - 1 || point.y>height - 1
}
func bfs(start point: Point) -> Int {
  var queue = [point]
  var idx = 0
  var count = 1
  visited[point.y][point.x] = true
  while queue.count > idx {
    let (curX,curY) = queue[idx]
    idx += 1
    for (dx,dy) in direction {
      let (nx,ny) = (curX+dx,curY+dy)
      if isOutOfBound(point: (nx,ny)) { continue }
      if !visited[ny][nx] && graph[ny][nx] == 1 {
        visited[ny][nx] = true
        queue.append((nx,ny))
        count += 1
      }
    }
  }
  return count
}
var res = 0
inputs.map{
  if !visited[$0.y][$0.x] {
    res = max(res,bfs(start: $0))
  }
}
print(res)
