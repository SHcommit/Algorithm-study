//
//  main.swift
//  [baekjoon]1890
//
//  Created by 양승현 on 2023/03/28.
//

//https://dev-with-precious-dreams.tistory.com/213
import Foundation

typealias Point = (x:Int, y:Int)
let direction = [(0,1),(1,0)]
var n = Int(readLine()!)!
var ans = 0
var graph = Array(repeating: [Int](), count: n)

_=(0..<n).map{
  graph[$0] = readLine()!.split(separator: " ").map{Int(String($0))!}
}

func isOutOfBounds(p: Point) -> Bool {
  return p.x<0 || p.y<0 || p.x > n - 1 || p.y > n - 1
}

//wrong cases
func bfs() {
  var queue = [(0,0)]
  var idx = 0
  while idx < queue.count {
    let (cx,cy) = queue[idx]
    idx += 1
    let mul = graph[cy][cx]
    if cx == n-1 && cy == n-1 {
      ans += 1
      continue
    }
    for (dx,dy) in direction {
      let (nx,ny) = (cx+dx*mul,cy+dy*mul)
      if isOutOfBounds(p: (nx,ny)) { continue }
      queue.append((nx,ny))
    }
  }
  print(ans)
}

//correct cases
func solution() {
  var cache = Array(repeating: Array(repeating: 0, count: n), count: n)
  cache[0][0] = 1
  for y in 0..<n {
    for x in 0..<n where graph[y][x] != 0 {
      let nx = x + graph[y][x]
      let ny = y + graph[y][x]
      if ny<n { cache[ny][x] += cache[y][x] }
      if nx<n { cache[y][nx] += cache[y][x] }
    }
  }
  print(cache[n-1].last!)
}
solution()
