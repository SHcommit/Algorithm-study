//
//  main.swift
//  [baekjoon]6603
//
//  Created by 양승현 on 1/25/24.
//
/*
 큼. 조합!! 콤비네이션은 백트레킹!!+_+
 */
import Foundation
var n = 0, lotto: [String] = []
func recur(of k: Int, seq: [String]) {
  if seq.count == 6 {
    print(seq.joined(separator: " "))
    return
  }
  for i in k..<n { recur(of: i+1, seq: seq+[lotto[i]])}
}
while let input = Optional(readLine()!.split{$0==" "}.compactMap{String($0)}), input.count != 1{
  lotto = (1..<input.count).map{input[$0]}
  n = lotto.count
  recur(of: 0, seq: [])
  print()
}
