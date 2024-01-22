//
//  main.swift
//  [baekjoon]14888
//
//  Created by 양승현 on 1/22/24.
//

import Foundation
/*
  띠로리...
 이 문제를 제출했을때 한번 틀렸다..
 그 이유는 Maximum값의 초기값을 0으로 해줬기 떄문이다. 문제의 조건에는 +10억, -10억 결과가 나올수 있다고 했는데 이부분을 보긴봤는데
 0으로 잡아서 틀렸다.
 문제를 잘 읽자 승현아!!
 */
let n = Int(readLine()!)!
let seq = readLine()!.split{$0==" "}.map{Int($0)!}
let operators = readLine()!.split{$0==" "}.map{Int($0)!}
var isUsed = (0..<4).map{_ in 0}
var maximum = -Int.max, minimum = Int.max
func recur(of k: Int, res: Int) {
  if k == n-1 {
    maximum = max(maximum, res)
    minimum = min(minimum, res)
    return
  }
  let e=seq[k+1]
  _=[res+e, res-e, res*e, res/e].enumerated().map {
    if isUsed[$0] < operators[$0] {
      isUsed[$0]+=1
      recur(of: k+1, res: $1)
      isUsed[$0]-=1
    }
  }
}

recur(of: 0, res: seq[0])
print(maximum)
print(minimum)
