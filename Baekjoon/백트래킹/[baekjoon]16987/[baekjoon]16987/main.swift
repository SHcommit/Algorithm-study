//
//  main.swift
//  [baekjoon]16987
//
//  Created by 양승현 on 1/23/24.
//

import Foundation

/*
 우선 아쉬운것은.. 문제를 잘못이해했다는 것임ㅠㅅㅠ
 문제에서 가장 최근에 든 계란이 가장 오른쪽에 위치한 계란일 경우 계란 치는 과정을 종료한다고했는데
 이게 가장 오른쪽 계란은 그냥 치지 않고 종료하는거로 생각을 했거든..
 
 그리고 이 문제를 풀면서 여러번 틀렸는데 그 이유는 만약에 특정 시점에 계란의 def는 높은데, 다른 계란들이 이미 다 깨졌을 경우야.
 이때 더이상 k는 증가되지 않고 그 시점에서의 깨진계란이 몇개인지 세야하는데 그냥 종료되버려. 이게 문제였으.
 */

typealias E = (def: Int, att: Int)
let n = Int(readLine()!)!
var eggs: [E] = (0..<n).map {_ in
  let input = readLine()!.split{$0==" "}.map{Int($0)!}
  return (input[0],input[1])
}
var res = 0
func recur(of k: Int) {
  if k == n {
    res = max(res,eggs.filter{$0.def <= 0}.count)
    return
  }
  if eggs[k].def <= 0 {
    recur(of: k+1)
    return
  }
  var f = false
  for j in 0..<n where k != j && eggs[j].def>0 {
    eggs[j].def -= eggs[k].att
    eggs[k].def -= eggs[j].att
    f = true
    recur(of: k+1)
    eggs[j].def += eggs[k].att
    eggs[k].def += eggs[j].att
  }
  ///만약 체력이 높지만 다른거들 안 내리칠때는 그 때의 계란이 몇개 깨졌는지도 구해주어야함.
  if !f { recur(of: n) }
}
recur(of: 0)
print(res)
