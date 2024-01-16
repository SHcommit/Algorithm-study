//
//  main.swift
//  [baekjoon]1941
//
//  Created by 양승현 on 1/16/24.
//

import Foundation
let n=5
let board: [[Int]] = (0..<n).map{_ in 
  return readLine()!.map{
    if String($0) == "S" {
      return 1
    }
    return 0
  }
}
var selected = (0..<25).map{_ in 0}
var ans = 0
typealias Point = (x: Int, y: Int)
let direction: [Point] = [(-1,0),(0,1),(1,0),(0,-1)]

func dfs(from idx: Int, withCount cnt: Int) {
  if cnt == 7 {
    if isMoreThanFour() {
      if bfs() {
        ans += 1
      }
    }
  }
  for i in idx..<25 {
    if selected[i] == 1 { continue }
    selected[i] = 1
    dfs(from: i, withCount: cnt+1)
    selected[i] = 0
  }
}

func bfs() -> Bool {
  var visited = (0..<n).map{_ in (0..<n).map{_ in 0}}
  var hasSelected = (0..<n).map{_ in (0..<n).map{_ in 0}}
  var queue: [Point] = []
  var idx = 0
  var count = 1
  var isFirstSave = false
  for i in 0..<25 {
    if selected[i] == 0 { continue }
    let y = i/5
    let x = i%5
    hasSelected[y][x] = 1
    if !isFirstSave {
      isFirstSave = true
      visited[y][x] = 1
      queue.append((x,y))
    }
  }
  while queue.count > idx {
    let c = queue[idx]
    for d in direction{
      let (nx, ny) = (c.x+d.x, c.y+d.y)
      if nx<0 || nx>n-1 || ny<0 || ny>n-1 { continue }
      if hasSelected[ny][nx] == 1 && visited[ny][nx] == 0 {
        count += 1
        if count == 7 { return true }
        visited[ny][nx] = 1
        queue.append((nx,ny))
      }
    }
    idx += 1
  }
  return false
}

func isMoreThanFour() -> Bool {
  var cnt = 0
  for i in 0..<25 {
    let y = i/n
    let x = i%n
    if selected[i] == 1 && board[y][x] == 1 { cnt+=1 }
  }
  if cnt >= 4 {
    return true
  }
  return false
}

dfs(from: 0, withCount: 0)
print(ans)
