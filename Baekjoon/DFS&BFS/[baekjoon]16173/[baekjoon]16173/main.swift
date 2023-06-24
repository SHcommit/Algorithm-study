//
//  main.swift
//  [baekjoon]16173
//
//  Created by 양승현 on 2023/06/24.
//

import Foundation
typealias Point = (x:Int, y:Int)
let n = Int(readLine()!)!
var idx = 0
var queue: [Point] = [(0, 0)]
var visited = Array(repeating: Array(repeating: false, count: n), count: n)
var map: [[Int]] = (0..<n).map { _ in
  readLine()!.split{$0==" "}.map{Int(String($0))!}
}
func isOutOfBounds(_ p: Point) -> Bool {
  return !(0..<n).contains(p.x) || !(0..<n).contains(p.y)
}
print({
  while idx < queue.count {
    let (cx, cy) = queue[idx]
    visited[cy][cx] = true
    idx += 1
    if cx == n-1, cy == n-1 { return true }
    let direction: [Point] = [(cx,cy + map[cy][cx]), (cx + map[cy][cx], cy)]
    _=direction.map{
      if !isOutOfBounds($0) && !visited[$0.y][$0.x] {
        queue.append($0)
        visited[$0.y][$0.x].toggle()
      }
    }
  }
  return false
}() ? "HaruHaru" : "Hing")
