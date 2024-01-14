//
//  main.swift
//  [baekjoon]15664
//
//  Created by 양승현 on 1/14/24.
//

import Foundation
let nm = readLine()!.split{$0==" "}.map{Int($0)!}
let l = readLine()!.split{$0==" "}.map{Int($0)!}.sorted()
var cached = Set<String>()
var isUsed = (0..<nm[0]).map{_ in false}
func r(_ seq: [Int]) {
  if seq.count == nm[1] {
    let t = seq.map{String($0)}.joined(separator: " ")
    if cached.contains(t) { return }
    print(t)
    cached.insert(t)
    return
  }
  l.enumerated().forEach {
    if (seq.last ?? 0) <= $1 && !isUsed[$0] {
      isUsed[$0] = true
      r(seq+[$1])
      isUsed[$0] = false
    }
  }
}
r([])
