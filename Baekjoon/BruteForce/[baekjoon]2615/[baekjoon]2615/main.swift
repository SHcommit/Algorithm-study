//
//  main.swift
//  [baekjoon]2615
//
//  Created by 양승현 on 2023/04/24.
//

import Foundation

typealias Point = (x:Int,y:Int)
let direction = [(0,1),(0,1),(1,1)]
let map=(0..<19).map{_ in readLine()!.split{$0==" "}.map{String($0)}}
func isOutOfBounds(_ p:Point) -> Bool {
  return p.x<0 || p.y < 0 || p.x > 18 || p.y > 18
}
func isWin(_ p:Point) -> Bool {
  let target = map[p.y][p.x]
  var count = 1
  for (dx,dy) in direction {
    var nx = p.x, ny = p.y
    while true {
      nx += dx; ny += dy
      if !isOutOfBounds((nx,ny)) && map[ny][nx] == target {
        count += 1
      }else {
        if count == 5 { return true }
        break
      }
    }
  }
  return false
}
func solution() {
  for y in 0..<19 {
    for x in 0..<19 where map[y][x]=="1" || map[y][x]=="2" {
      if isWin((x,y)) {
        print("\(map[y][x])\n\(y+1) \(x+1)")
        return
      }
    }
  }
}

solution()
