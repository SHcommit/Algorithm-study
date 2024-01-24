//
//  main.swift
//  [baekjoon]15661
//
//  Created by 양승현 on 1/24/24.
//

/*
 좋아. 어려웠던 점은 시간초과가 났을떄 왜?..
 스타트 팀에서 에서 3명 고를때의 경우와 링크팀에서 3명 고를때의 경우가 다르지 않을까? 생각했는데..
 시간초과가 나지 않으려면 팀 선택할 때 n/2를 해줘야한다.
 */
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
