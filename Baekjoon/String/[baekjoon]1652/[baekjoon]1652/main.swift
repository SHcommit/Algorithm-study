//
//  main.swift
//  [baekjoon]1652
//
//  Created by 양승현 on 2023/07/03.
//

import Foundation

let n = Int(readLine()!)!
var map = (0..<n).map {_ in readLine()!.map{String($0)}}
var verti = 0, hori = 0
for i in 0..<n {
  var cnt = 0
  for j in 0..<n {
    if map[i][j] == "." { cnt += 1 }
    else {
      if cnt >= 2 { hori += 1 }
      cnt = 0
    }
  }
  if cnt >= 2 { hori += 1 }
  cnt = 0
  for k in 0..<n {
    if map[k][i] == "." { cnt += 1 }
    else {
      if cnt >= 2 { verti += 1 }
      cnt = 0 
    }
  }
  if cnt >= 2 { verti += 1 }
}
print("\(hori) \(verti)")
