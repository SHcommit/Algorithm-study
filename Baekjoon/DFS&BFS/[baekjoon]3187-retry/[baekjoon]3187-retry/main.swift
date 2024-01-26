//
//  main.swift
//  [baekjoon]3187-retry
//
//  Created by 양승현 on 1/26/24.
//

import Foundation

typealias Point = (x:Int, y:Int)
let direction: [Point] = [(-1,0),(1,0),(0,1),(0,-1)]
let hw = readLine()!.split{$0==" "}.map{Int($0)!}
let H = hw[0], W = hw[1]
var visited = (0..<H).map{_ in (0..<W).map{_ in false}}
let board = (0..<H).map{_ in readLine()!.map{String($0)}}
var sheep = 0, wolf = 0

func isOutOfBounds(_ p: Point) -> Bool {
  return !(0..<H).contains(p.y) || !(0..<W).contains(p.x)
}

func bfs(from startPoint: Point) {
  var sheepCount = 0, wolfCount = 0
  var queue: [Point] = [startPoint]
  visited[startPoint.y][startPoint.x] = true
  var index = 0
  while queue.count > index {
    let current = queue[index]
    let currentValue = board[current.y][current.x]
    if currentValue == "k" { sheepCount += 1}
    if currentValue == "v" { wolfCount += 1}
    for d in direction {
      let next: Point = (current.x+d.x, current.y+d.y)
      if isOutOfBounds(next) 
          || board[next.y][next.x] == "#"
          || visited[next.y][next.x] {continue}
      visited[next.y][next.x] = true
      queue.append(next)
    }
    index+=1
  }
  if wolfCount-sheepCount < 0 {
    sheep += sheepCount
    return
  }
  wolf += wolfCount
}

(0..<H).forEach { y in
  for x in 0..<W where !visited[y][x] && (board[y][x] == "v"||board[y][x]=="k") {
    bfs(from: (x,y))
  }
}

print("\(sheep) \(wolf)")
