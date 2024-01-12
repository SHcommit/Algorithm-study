//
//  main.swift
//  [baekjoon]15663
//
//  Created by 양승현 on 1/11/24.
//

import Foundation
let nm = readLine()!.split{$0==" "}.map{Int($0)!}
let s = readLine()!.split{$0==" "}.map{Int($0)!}.sorted()
var res: [String] = []
var isUsed = Array(repeating: false, count: nm[0])
var seq = Array(repeating: 0, count: nm[1])
var duplicated = Set<String>()
func sol(_ k: Int) {
  if k == nm[1] {
    let text = seq.map { String($0) }.joined(separator: " ")
    if duplicated.contains(text) { return }
    duplicated.insert(text)
    res.append(text)
    return
  }
  for i in 0..<nm[0] where !isUsed[i] {
    isUsed[i].toggle()
    seq[k] = s[i]
    sol(k+1)
    isUsed[i].toggle()
  }
}
sol(0)
print(res.joined(separator: "\n"))
// (NSOrderedSet(array: res).array as! [String]).forEach{print($0)}
