//
//  main.swift
//  [baekjoon]1245
//
//  Created by 양승현 on 2023/03/28.
//
// https://dev-with-precious-dreams.tistory.com/214
import Foundation

typealias Point = (x:Int,y:Int)
let direction = [(-1,0),(-1,1),(0,1),(1,1),
                 (1,0),(1,-1),(0,-1),(-1,-1)]
var nm = readLine()!.split{$0==" "}.map{Int(String($0))!}
let height = nm[0], width = nm[1]
var res = 0
var visited = Array(repeating: Array(repeating: false, count: width), count: height)
var farm = (0..<height).map{_ in readLine()!.split{$0==" "}.map{Int(String($0))!} }

func isOutOfBounds(target p: Point) -> Bool{
  return p.x<0 || p.y < 0 || p.x > width-1 || p.y > height-1
}

func bfs(p: Point, completion: (Bool) -> Void) {
  var queue: [Point] = [p]
  var idx = 0
  var isTop = true
  let height = farm[p.y][p.x]
  visited[p.y][p.x] = true
  defer { completion(isTop) }
  while queue.count > idx {
    let (cx,cy) = queue[idx]
    for (dx,dy) in direction {
      let (nx,ny) = (cx+dx,cy+dy)
      if isOutOfBounds(target: (nx,ny)) { continue }
      if farm[ny][nx] > height { isTop = false }
      if !visited[ny][nx] && farm[ny][nx] == height {
        visited[ny][nx] = true
        queue.append((nx,ny))
      }
    }
    idx += 1
  }
}

for y in 0..<height {
  for x in 0..<width where !visited[y][x] && farm[y][x] != 0 {
    bfs(p: (x,y)) { res = $0 ? res + 1 : res }
  }
}
print(res)
