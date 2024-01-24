//
//  main.swift
//  [baekjoon]15661
//
//  Created by 양승현 on 1/24/24.
//

import Foundation
let n = Int(readLine()!)!
let board = (0..<n).map{_ in readLine()!.split{$0==" "}.map{Int($0)!}}
var isUsed = (0..<n).map{_ in false}
var res = Int.max
func recur(_ k: Int, maxSCnt: Int) {
  if maxSCnt == isUsed.filter({$0}).count {
    var sTeam = 0
    var lTeam = 0
    for i in 0..<n*n {
      let y = i/n, x = i%n
      if isUsed[y] && isUsed[x] {
        sTeam += board[x][y]
      }
      if !isUsed[y] && !isUsed[x] {
        lTeam += board[x][y]
      }
    }
    res = min(res,abs(sTeam-lTeam))
    return
  }
  for i in k..<n where !isUsed[i] {
    isUsed[i] = true
    recur(i+1, maxSCnt: maxSCnt)
    isUsed[i] = false
  }
}
for i in 1...n/2{recur(0, maxSCnt: i)}
print(res)
