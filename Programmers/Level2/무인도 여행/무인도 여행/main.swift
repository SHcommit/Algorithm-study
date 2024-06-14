//
//  main.swift
//  무인도 여행
//
//  Created by 양승현 on 6/14/24.
//

import Foundation

typealias Point = (x: Int, y: Int)
let Direction: [Point] = [(-1,0),(1,0),(0,1),(0,-1)]
// MARK: - 이렇게 글로발 변수로 때 초기화 잘 됬는지 꼭 확인하기
var visited: [[Bool]] = []
var width = 0, height = 0
var maps: [[String]] = []

func solution(_ input:[String]) -> [Int] {
  maps = input.map { $0.map { String($0) } }
  width = maps[0].count; height = maps.count
  visited = Array(repeating: Array(repeating: false, count: width), count: height)
  let res = (0..<height).map { y in
      (0..<width).map { x in
          guard maps[y][x] != "X" && !visited[y][x] else { return 0 }
          return bfs((x,y))
      }
  }
  .flatMap { $0 }
  .filter{ $0 != 0 }
  .sorted(by: <)
  return res.isEmpty ? [-1] : res
}

func bfs(_ start: Point) -> Int {
  var queue = [start], idx = 0
  var buffer: [Int] = [Int(maps[start.y][start.x])!]
  visited[start.y][start.x] = true
  
  while queue.count > idx {
    let c = queue[idx]
    for d in Direction {
      let n: Point = (c.x+d.x, c.y+d.y)
      if isOutOfBounds(n) { continue }
      if maps[n.y][n.x] == "X" || visited[n.y][n.x] { continue }
      visited[n.y][n.x] = true
      buffer.append(Int(maps[n.y][n.x])!)
      queue.append(n)
    }
    idx += 1
  }
  return buffer.reduce(0, +)
}

@inline(__always)
func isOutOfBounds(_ p: Point) -> Bool {
  return  !(0..<width).contains(p.x)  || !(0..<height).contains(p.y)
}

print(solution(["X591X","X1X5X","X231X", "1XXX1"]))
