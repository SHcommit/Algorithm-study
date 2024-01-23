//
//  main.swift
//  [baekjoon]16987
//
//  Created by 양승현 on 1/23/24.
//

import Foundation

/*
 각 계란에는 내구도-무게 정해짐.
 계란으로 계란치면 각 계란의 내구도는 상대 계란의 무게만큼 깎이게 됨. 내구도 0 이하 되는 순 간 계란은 깨지게 됨.
 
 ex) 계1의 내구도 7, 무 5.
     계2의 내구도 3, 무 4.
 

 계란 1로 계란 2치면 계란 1의 내구도는 4 감소함. 계란2의 내구도는 5만큼 감소함.
 즉 서로의 무게만큼 내구도가 까임.
 충돌 결과. 계2는 깨졌고, 계란1은 내구도 3으로 남아있음.
 
 왼쪽부터 차례로 들어서 한번씩만 다른 계란을 쳐 최대한 많은 계란 을 깨는 문제임.
 1. 가장 왼쪽 계란 듬.
 2. 손에든 계란은 제자리에 두고, 다른 계란듬.
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
    res = max(res,eggs.filter {$0.def <= 0}.count)
    return
  }
  if eggs[k].def <= 0 { recur(of: k+1) }
  for j in 0..<n where k != j && eggs[j].def > 0 {
    eggs[j].def -= eggs[k].att
    eggs[k].def -= eggs[j].att
    recur(of: k+1)
    eggs[j].def += eggs[k].att
    eggs[k].def += eggs[j].att
  }
}

recur(of: 0)
print(res)
