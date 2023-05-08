//
//  main.swift
//  [baeojoon]3085
//
//  Created by 양승현 on 2023/05/08.
//

import Foundation

func checkX() {
  for y in 0..<n {
    var cnt = 1
    for x in 0..<n-1 {
      if map[y][x] == map[y][x+1] { cnt += 1 }
      else {
        res = max(res,cnt)
        cnt = 1
      }
    }
    res = max(res,cnt)
  }
}
func checkY() {
  for x in 0..<n {
    var cnt = 1
    for y in 0..<n-1 {
      if map[y][x] == map[y+1][x] { cnt += 1 }
      else {
        res = max(res,cnt)
        cnt = 1
      }
    }
    res = max(res,cnt)
  }
}

var n = Int(readLine()!)!
var map = (0..<n).map {_ in readLine()!.map{ String($0) } }
var res = 0
for y in 0..<n {
  for x in 0..<n-1 {
    map[y].swapAt(x, x+1)
    checkX();checkY();
    map[y].swapAt(x, x+1)
  }
}

for x in 0..<n {
  for y in 0..<n-1 {
    var temp = map[y][x]
    map[y][x] = map[y+1][x]
    map[y+1][x] = temp
    checkX();checkY();
    temp = map[y][x]
    map[y][x] = map[y+1][x]
    map[y+1][x] = temp
  }
}
print(res)
