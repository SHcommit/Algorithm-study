//
//  main.swift
//  [baekjoon]15654
//
//  Created by 양승현 on 1/9/24.
//

import Foundation

var n = 0, m = 0
_={n=$0[0];m=$0[1]}(readLine()!.split{$0==" "}.map{Int(String($0))!})
let list = readLine()!.split{$0==" "}.map{Int(String($0))!}.sorted()
func execute(_ seq: [Int]) {
  if seq.count == m {
    print(seq.map{String($0)}.joined(separator: " "))
    return
  }
  for i in list where !seq.contains(i) {execute(seq+[i])}
}
execute([])
