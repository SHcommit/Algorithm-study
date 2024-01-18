//
//  main.swift
//  [baekjoon]14889
//
//  Created by 양승현 on 1/18/24.
//
import Foundation
/*
 시간초과가 났던 이유는 팀을 선정했을 때 예를들어 0 2 4를선정하면
 0 2, 0 4, 2 4 이렇게 조합을 얻어야했고 이걸 또 콤비네이션 재귀로 구했다. 이거보다
 아래의 경우가 빠르긴함 ㅇㅅㅇ.. 결국 isUsed를통해서 양쪽다 true인 경우에 그 둘이 한 팀이라는 걸 파악할수있음..
 이래야 시간초과가 안남.
 */

let n = Int(readLine()!)!
let specs = (0..<n).map{_ in readLine()!.split{$0==" "}.map{Int($0)!}}
var ans = Int.max
var isUsed = (0..<n).map{_ in false}
func combi(from k: Int, withSeq seq: [Int]) {
  if seq.count == n/2 {
    var a = 0,b = 0
    for i in 0..<n {
      for j in 0..<n {
        if !isUsed[i] && !isUsed[j] {
          a+=specs[i][j]
        } else if isUsed[i] && isUsed[j] {
          b+=specs[i][j]
        }
      }
    }
    ans = min(ans, abs(a-b))
    return
  }
  for i in k..<n where !isUsed[i] {
    isUsed[i]=true
    combi(from: i+1, withSeq: seq + [i])
    isUsed[i]=false
  }
}
combi(from: 0, withSeq: [])
print(ans)
